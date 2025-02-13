from typing import Callable

from rerankers import Reranker

from mhqa.models import RunContext
from mhqa.react import Tool


def golden_retrieve(docs: list[dict], query: str) -> list[dict]:
    return [doc for doc in docs if doc["is_supporting"]]


def make_retriever(name: str = "t5", top_k: int = 3) -> Callable:
    if name == "golden":
        return golden_retrieve

    reranker = Reranker(name)
    if reranker is None:
        raise ValueError("Ranker is not initialized")

    def retrieve(docs: list[dict], query: str) -> list[dict]:
        texts = [doc["text"] for doc in docs]
        ranking = reranker.rank(query=query, docs=texts, doc_ids=list(range(len(texts))))
        return [docs[result.doc_id] for result in ranking.results[:top_k]]

    return retrieve


def make_search_tool(retriever: Callable) -> Callable:
    def search(query: str, run_context: RunContext) -> list[str]:
        """Find relevant documents for the query."""
        docs = run_context.input["docs"]
        retrieved_docs = retriever(docs, query)
        return [x["text"] for x in retrieved_docs]

    return Tool(func=search, name="search", desc="Search the relevant information")
