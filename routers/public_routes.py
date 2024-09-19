from fastapi import APIRouter, status

public_router = APIRouter(
    prefix="",
    tags=["Public"]
)

@public_router.get("/")
async def index():
    return {"message": "Hello World"}