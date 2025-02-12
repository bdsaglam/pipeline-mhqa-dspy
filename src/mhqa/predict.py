import dspy


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
