from dataclasses import dataclass
from typing import Any


@dataclass
class RunContext:
    input: dict[str, Any]
