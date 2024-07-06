from fastapi import APIRouter, Request
from fastapi.responses import HTMLResponse

from app.config import templates

router = APIRouter()


@router.get("/", response_class=HTMLResponse)
async def home(request: Request):
    return templates.TemplateResponse(request=request, name="index.html")
