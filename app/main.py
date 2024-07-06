from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

from app.routers import health, home, leds

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")

app.include_router(home.router)
app.include_router(health.router)
app.include_router(leds.router)
