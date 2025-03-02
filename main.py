import json
import os
from copy import deepcopy
from pathlib import Path

import dspy
import pandas as pd
import typer
import weave
from dotenv import load_dotenv
from dspy.evaluate import Evaluate
from dspy.teleprompt.ensemble import Ensemble
from rich.console import Console

from mhqa.agent import make_decomposing_agent, make_simple_agent
from mhqa.evaluation import (
    aggregate_scores,
    compute_scores,
    compute_scores_dataframe,
)
from mhqa.multihop import make_multihop_program
from mhqa.qa import make_qa_program
from mhqa.search import make_retriever
from mhqa.tgi_json_adapter import TGIJSONAdapter
from mhqa.utils import configure_lm, dynamic_import, set_seed

print = Console(stderr=True).print

load_dotenv()

set_seed(89)

# dspy.settings.adapter = TGIJSONAdapter()

weave.init(project_name="mhqa-dspy")

app = typer.Typer()


def preprocess_examples(examples: list[dspy.Example], technique: str):
    if "agent" in technique or "multihop" in technique:
        return [example.with_inputs("docs", "question") for example in examples]
    else:
        return [example.with_inputs("context", "question") for example in examples]


def prepare_examples(dataset_path: str, dataset_name: str, dataset_split: str, technique: str):
    if "musique" in dataset_path:
        from mhqa.dataset.musique import load_examples

        return preprocess_examples(load_examples(dataset_path, dataset_name, dataset_split), technique)
    elif "drop" in dataset_path:
        from mhqa.dataset.drop import load_examples

        return preprocess_examples(load_examples(dataset_path, dataset_name, dataset_split), technique)
    else:
        raise ValueError(f"Unknown dataset: {dataset_path}")


def make_program(technique: str, retriever_name: str, top_k: int):
    retriever = make_retriever(retriever_name, top_k=top_k)
    if technique == "agent-simple":
        return make_simple_agent(retriever)
    elif technique == "agent-decompose":
        return make_decomposing_agent(retriever)
    elif technique == "multihop-decompose":
        return make_multihop_program(retriever)
    else:
        return make_qa_program(technique)


@weave.op()
def evaluate_answer(example, pred, trace=None):
    scores = compute_scores(pred.answer, example.answers)
    return scores["exact_match"]


def make_optimizer(optimizer_config: dict):
    cls = dynamic_import("dspy.teleprompt", optimizer_config["class"])
    kwargs = deepcopy(optimizer_config["params"])
    if optimizer_config["with_metric"]:
        kwargs["metric"] = evaluate_answer
    return cls(**kwargs)


def preprocess_result(result):
    example, pred, score = result
    predictions = {f"predicted_{k}": v for k, v in dict(pred).items()}
    return {**dict(example), **predictions, "score": float(score)}


def make_results_dataframe(results):
    dataf = pd.json_normalize([preprocess_result(result) for result in results])
    dataf["n_hops"] = dataf["question_decomposition"].apply(len)
    dataf["predicted_answer"] = dataf["predicted_answer"].fillna("No Answer")
    return compute_scores_dataframe(dataf)


@app.command("train")
def train_main(
    dataset_path: str = typer.Option(..., help="Path to the dataset"),
    dataset_name: str = typer.Option(..., help="Name of the dataset"),
    dataset_split: str = typer.Option(..., help="Dataset split to use (e.g., 'train', 'validation')"),
    retriever: str = typer.Option(..., help="Name of the retriever to use"),
    top_k: int = typer.Option(..., help="Number of documents to retrieve"),
    model: str = typer.Option(..., help="Name of the model to use"),
    temperature: float = typer.Option(..., help="Temperature parameter for the model"),
    technique: str = typer.Option(..., help="Prompting technique to use"),
    load_from: str = typer.Option(default="UNSET", help="Path to a saved model to load"),
    optimizer_path: Path = typer.Option(..., help="Path to the optimizer config"),
    ensemble: str = typer.Option("no", help="Whether to use an ensemble of models"),
    out: Path = typer.Option(..., help="Output file for trained program"),
):
    out.parent.mkdir(parents=True, exist_ok=True)

    # Set up LLM
    configure_lm(model, temperature)

    # Load and preprocess datasets
    examples = prepare_examples(dataset_path, dataset_name, dataset_split, technique)
    print(f"Loaded {len(examples)} examples")

    # Create the program
    program = make_program(technique=technique, retriever_name=retriever, top_k=top_k)
    if load_from and load_from != "UNSET":
        print(f"Loading model from {load_from}")
        program.load(load_from)

    # Train the program
    with open(optimizer_path) as f:
        optimizer_config = json.load(f)

    if optimizer_config:
        optimizer = make_optimizer(optimizer_config)
        compile_params = optimizer_config.get("compile_params", {})
        trained_program = optimizer.compile(program, trainset=examples, **compile_params)
    else:
        trained_program = program

    if ensemble == "yes":
        ensemble_optimizer = Ensemble(reduce_fn=dspy.majority)
        candidate_programs = [x[-1] for x in trained_program.candidate_programs]
        trained_program = ensemble_optimizer.compile(candidate_programs)

    # Save the trained program
    trained_program.save(out)


@app.command("evaluate")
def evaluate_main(
    dataset_path: str = typer.Option(..., help="Path to the dataset"),
    dataset_name: str = typer.Option(..., help="Name of the dataset"),
    dataset_split: str = typer.Option(..., help="Dataset split to use (e.g., 'train', 'validation')"),
    retriever: str = typer.Option(..., help="Name of the retriever to use"),
    top_k: int = typer.Option(..., help="Number of documents to retrieve"),
    model: str = typer.Option(..., help="Name of the model to use"),
    temperature: float = typer.Option(..., help="Temperature parameter for the model"),
    technique: str = typer.Option(..., help="Prompting technique to use"),
    load_from: str = typer.Option(default="UNSET", help="Path to a saved model to load"),
    out: Path = typer.Option(..., help="Output directory for generated results"),
):
    out.mkdir(parents=True, exist_ok=True)

    # Set up LLM
    configure_lm(model, temperature)

    # Load and preprocess datasets
    examples = prepare_examples(dataset_path, dataset_name, dataset_split, technique)
    print(f"Loaded {len(examples)} examples")

    # Create the program
    program = make_program(technique=technique, retriever_name=retriever, top_k=top_k)
    if load_from and load_from != "UNSET":
        print(f"Loading model from {load_from}")
        program.load(load_from)

    # Evaluate the program
    evaluate_program = Evaluate(
        metric=evaluate_answer,
        devset=examples,
        num_threads=1,
        display_progress=True,
        return_outputs=True,
    )
    _, results = evaluate_program(program)

    # Save the results
    result_df = make_results_dataframe(results)
    result_df.to_json(out / "results.jsonl", orient="records", lines=True)

    # Save the scores
    scores = aggregate_scores(result_df)
    for n_hops in result_df["n_hops"].unique():
        scores[f"{n_hops}hops"] = aggregate_scores(result_df[result_df["n_hops"] == n_hops])

    with open(out / "scores.json", "w") as f:
        json.dump(scores, f, indent=2)


if __name__ == "__main__":
    dvc_exp_name = os.getenv("DVC_EXP_NAME", "default")
    with weave.attributes({"dvc.experiment": dvc_exp_name}):
        app()
