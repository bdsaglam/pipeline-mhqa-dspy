from typing import Callable


from mhqa.qa import MultihopQuestionAnswering, QuestionAnswering, make_qa_program, make_qa_tool
from mhqa.react import ReAct
from mhqa.search import make_search_tool


def make_simple_agent(retriever: Callable):
    search_tool = make_search_tool(retriever)
    return ReAct(MultihopQuestionAnswering, tools=[search_tool])


def make_decomposing_agent(retriever: Callable, qa_technique: str = "cot"):
    qa_program = make_qa_program(qa_technique)
    qa_tool = make_qa_tool(qa_program)
    search_tool = make_search_tool(retriever)
    return ReAct(QuestionAnswering, tools=[search_tool, qa_tool])
