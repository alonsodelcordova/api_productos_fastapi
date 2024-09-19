from fastapi import FastAPI
from config import ALL_MODELS, middlewareApi
from db.main_db import ConfigDB
from routers.public_routes import public_router
from routers.producto_routes import producto_router

app = FastAPI(
    title="FastAPI Demo",
    description="This is a simple FastAPI demo",
    version="1.0"
)
# Adding the middleware
middlewareApi(app)

# Creating the database connection
config = ConfigDB(ALL_MODELS)

# Importing the routers
app.include_router(public_router)
app.include_router(producto_router)

@app.on_event("startup")
async def startup():
    config.connect_db()

@app.on_event("shutdown")
async def shutdown():
    config.close_db()