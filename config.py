from fastapi.applications import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from models.producto_model import ProductoModel, CategoriaModel

ALL_MODELS = [
    ProductoModel,
    CategoriaModel
]

def middlewareApi(app:FastAPI):

    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
