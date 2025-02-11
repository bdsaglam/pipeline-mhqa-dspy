import os

import dspy


def configure_lm(model, temperature):
    lm = dspy.LM(
        "openai/" + model,
        temperature=temperature,
        cache=False,
        api_base=os.getenv("OPENAI_BASE_URL"),
        api_key=os.getenv("OPENAI_API_KEY"),
    )
    dspy.configure(lm=lm)


def dynamic_import(module, name):
    import importlib

    return getattr(importlib.import_module(module), name)

