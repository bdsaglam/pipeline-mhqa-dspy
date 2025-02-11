import dspy
import weave

from mhqa.search import make_retriever


class Planner(dspy.Signature):
    """Decompose the multi-hop question into 2-4 subquestions."""

    question: str = dspy.InputField()
    subquestions: list[str] = dspy.OutputField()


class QuestionAnswerer(dspy.Signature):
    """Answer the question based on the context."""

    context: str = dspy.InputField()
    question: str = dspy.InputField("A multi-hop question")
    answer: str = dspy.OutputField("The answer in a few words")


def docs2context(docs):
    return "\n\n".join([doc["text"] for doc in docs])


class MultiHopQA(dspy.Module):
    def __init__(self, retrieve):
        super().__init__()

        self.planner = dspy.Predict(Planner)
        self.retrieve = retrieve
        self.qa = dspy.ChainOfThought(QuestionAnswerer)

    @weave.op()
    def forward(self, question, docs):
        hops = []
        subquestions = self.planner(question).subquestions
        for subquestion in subquestions:
            retrieved_docs = self.retrieve(docs, subquestion)
            context = docs2context(retrieved_docs)
            answer = self.qa(context=context, question=subquestion).answer
            hops.append(dict(retrieved_docs=retrieved_docs, subquestion=subquestion, answer=answer))

        final_answer = hops[-1]["answer"]
        return dspy.Prediction(hops=hops, answer=final_answer)


def make_multihop_program(reranker=None):
    retrieve = make_retriever(reranker)
    return MultiHopQA(retrieve)
