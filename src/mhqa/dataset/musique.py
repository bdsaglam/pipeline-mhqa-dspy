import dspy
from datasets import load_dataset


def format_paragraph(paragraph):
    text = paragraph["paragraph_text"]
    title = paragraph["title"]
    return f"# {title}\n{text}"


def make_example(record):
    docs = [
        {"idx": p["idx"], "text": format_paragraph(p), "is_supporting": p["is_supporting"]}
        for p in record["paragraphs"]
    ]
    context = "\n\n".join([doc["text"] for doc in docs if doc["is_supporting"]])
    return dspy.Example(
        id=record["id"],
        question=record["question"],
        context=context,
        docs=docs,
        answers=[record["answer"], *record["answer_aliases"]],
        question_decomposition=record["question_decomposition"],
    )


def load_examples(dataset_path: str, dataset_name: str, dataset_split: str):
    ds = load_dataset(dataset_path, dataset_name, split=dataset_split)
    examples = [make_example(record) for record in ds]
    return examples
