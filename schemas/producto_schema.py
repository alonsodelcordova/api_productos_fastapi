from pydantic import BaseModel



class ProductoSchema(BaseModel):
    nombre: str
    precio: float
    stock: int
    descripcion: str

class ProductoModelSchema(ProductoSchema):
    id : int
    class Config:
        orm_mode = True

class CategoriaSchema(BaseModel):
    nombre: str
    descripcion: str

class CategoriaModelSchema(CategoriaSchema):
    id: int
    class Config:
        orm_mode = True