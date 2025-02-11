import dspy
from mhqa.qa import make_qa_program, make_qa_tool
from mhqa.react import ReAct
from mhqa.search import make_search_tool

class QuestionAnswer(dspy.Signature):
    question: str = dspy.InputField("A multi-hop question")
    answer: str = dspy.OutputField("The answer in a few words")

def make_simple_agent():
    search_tool = make_search_tool()
    return ReAct(QuestionAnswer, tools=[search_tool])


def make_decomposing_agent(qa_technique: str):
    qa_program = make_qa_program(qa_technique)
    qa_tool = make_qa_tool(qa_program)
    search_tool = make_search_tool()
    return ReAct("question -> answer", tools=[search_tool, qa_tool])
