from typing import Optional

import dspy

from mhqa.react import Tool


class GenerateAnswer(dspy.Signature):
    """Answer the question based on the given context."""

    context = dspy.InputField(desc="may contain relevant facts")
    question = dspy.InputField()
    answer = dspy.OutputField(desc="often between 1 and 5 words")


class QAModule(dspy.Module):
    def __init__(self, predict_cls=dspy.Predict):
        super().__init__()
        self.generate_answer = predict_cls(GenerateAnswer)

    def forward(self, context, question):
        return self.generate_answer(context=context, question=question)


def get_predict_cls(technique):
    if technique == "standard":
        return dspy.Predict
    elif technique == "cot":
        return dspy.ChainOfThought
    elif technique == "ccot":
        from bellem.dspy.predict.ccot import ConciseChainOfThought

        return ConciseChainOfThought
    elif technique == "cte":
        from bellem.dspy.predict.cte import ConnectTheEntities

        return ConnectTheEntities
    elif technique == "cok":
        from bellem.dspy.predict.cok import ChainOfKnowledge

        return ChainOfKnowledge
    else:
        raise ValueError(f"Unknown technique: {technique}")


def make_qa_program(technique: str):
    return QAModule(predict_cls=get_predict_cls(technique))


def make_qa_tool(program: Optional[dspy.Module] = None, load_from: str | None = None):
    if program is None:
        program = dspy.ChainOfThought("context, question -> answer")
    if load_from:
        program.load(load_from)

    def answer_question(context: str, question: str) -> str:
        return program(context=context, question=question)

    return Tool(
        func=answer_question,
        name="answer_question",
        desc="Answer the question or sub-question based on the given context.",
    )
