from typing import Callable, Optional

from rerankers import Reranker
from rerankers.models.ranker import BaseRanker

from mhqa.models import RunContext
from mhqa.react import Tool


def make_search_tool(reranker: Optional[BaseRanker] = None, top_k: int = 3) -> Callable:
    if reranker is None:
        reranker = Reranker("t5")
    if reranker is None:
        raise ValueError("Ranker is not initialized")

    def search(query: str, run_context: RunContext) -> list[str]:
        """Find relevant documents for the query."""
        docs = run_context.input["docs"]
        texts = [doc["text"] for doc in docs]
        ranking = reranker.rank(query=query, docs=texts, doc_ids=list(range(len(texts))))
        retrieved_docs = [docs[result.doc_id] for result in ranking.results[:top_k]]
        return [x["text"] for x in retrieved_docs]

    return Tool(func=search, name="search", desc="Search the relevant information")
