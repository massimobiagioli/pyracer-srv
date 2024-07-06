from enum import Enum

from pydantic import BaseModel


class LedsProgramType(str, Enum):
    normal = "normal"
    reverse = "reverse"
    all = "all"


class LedsProgram(BaseModel):
    program_type: LedsProgramType = LedsProgramType.normal
