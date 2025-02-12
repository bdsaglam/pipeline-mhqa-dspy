from typing import Optional

import dspy
import weave

from mhqa.predict import get_predict_cls
from mhqa.react import Tool


class QuestionAnswering(dspy.Signature):
    question: str = dspy.InputField()
    answer: str = dspy.OutputField(desc="in a few words")


class MultihopQuestionAnswering(dspy.Signature):
    question: str = dspy.InputField(desc="A multi-hop question")
    answer: str = dspy.OutputField(desc="in a few words")


class QuestionAnsweringRC(dspy.Signature):
    """Answer the question based on the given context."""

    context = dspy.InputField(desc="may contain relevant facts")
    question = dspy.InputField()
    answer = dspy.OutputField(desc="in a few words")


def make_qa_program(technique: str = "cot"):
    return get_predict_cls(technique)(QuestionAnsweringRC)


def make_qa_tool(program: Optional[dspy.Module] = None, load_from: str | None = None):
    if program is None:
        program = dspy.ChainOfThought(QuestionAnsweringRC)
    if load_from:
        program.load(load_from)

    @weave.op()
    def answer_question(context: str, question: str) -> str:
        return program(context=context, question=question)

    return Tool(
        func=answer_question,
        name="answer_question",
        desc="Answer the question based on the given context.",
    )
