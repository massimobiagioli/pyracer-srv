from fastapi import APIRouter, status

from app.schemas.leds import LedsProgram

router = APIRouter()


@router.post("/leds", status_code=status.HTTP_201_CREATED)
async def set_program(program: LedsProgram):
    print(f"Setting program to {program.program_type}")
