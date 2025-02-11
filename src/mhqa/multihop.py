import dspy
import weave
from typing import Callable

SUBQUESTION_INSTRUCTION = """
Subquestions must be formatted to refer the answer of previous subquestion if applicable. For instance, 
question: 'What is mayor of the city where Alan Turing's mother was born?'
subquestions: ['Who is Alan Turing's mother?', 'What is the name of the city where {previous_answer} was born?', 'What is the name of the mayor of {previous_answer}?']
"""


class QuestionDecomposition(dspy.Signature):
    """Decompose the multi-hop question into 2-4 subquestions."""

    question: str = dspy.InputField()
    subquestions: list[str] = dspy.OutputField(desc=SUBQUESTION_INSTRUCTION)


class QueryGeneration(dspy.Signature):
    question: str = dspy.InputField()
    query: str = dspy.OutputField(desc="query to retrieve relevant documents for the question")


class QuestionAnswerer(dspy.Signature):
    """Answer the subquestion based on the context."""

    context: str = dspy.InputField(desc="may contain relevant facts")
    question: str = dspy.InputField()
    answer: str = dspy.OutputField(desc="in a few words")


class MultiHopQA(dspy.Module):
    def __init__(self, retrieve):
        super().__init__()

        self.retrieve = retrieve
        self.qdecomp = dspy.Predict(QuestionDecomposition)
        self.query_gen = dspy.Predict(QueryGeneration)
        self.qa = dspy.ChainOfThought(QuestionAnswerer)

    @weave.op(name="multihop-qa")
    def forward(self, docs, question):
        subquestions = self.qdecomp(question=question).subquestions

        hops = []
        for subquestion in subquestions:
            if hops and "{previous_answer}" in subquestion:
                previous_answer = hops[-1]["answer"]
                subquestion = subquestion.replace("{previous_answer}", previous_answer)

            query = self.query_gen(question=subquestion).query
            retrieved_docs = self.retrieve(docs, query=query)

            context = "\n\n".join([doc["text"] for doc in retrieved_docs])
            answer = self.qa(context=context, question=subquestion).answer

            hops.append(dict(subquestion=subquestion, query=query, retrieved_docs=retrieved_docs, answer=answer))

        final_answer = hops[-1]["answer"]
        return dspy.Prediction(hops=hops, answer=final_answer)


def make_multihop_program(retriever: Callable):
    return MultiHopQA(retriever)
