from fastapi import APIRouter
from models.producto_model import ProductoModel, CategoriaModel
from schemas.producto_schema import ProductoSchema, ProductoModelSchema, CategoriaSchema, CategoriaModelSchema


producto_router = APIRouter(
    prefix="/producto",
    tags=["Producto"]
)


@producto_router.get("/", response_model = list[ProductoModelSchema])
async def getProducts():
    data = ProductoModel.select()
    return list(data)
    

@producto_router.post("/", response_model = ProductoModelSchema)
async def registrarProduct(producto: ProductoSchema):
    producto = ProductoModel(
        **producto.dict()
    )
    producto.save()
    return producto

@producto_router.put("/{id}", response_model = ProductoModelSchema)
async def actualizaProduct(id: int, producto_data: ProductoSchema):
    producto = ProductoModel.get_or_none(id = id)
    if not producto:
        return {"message": "Producto no encontrado"}
    producto.nombre = producto_data.nombre
    producto.precio = producto_data.precio
    producto.stock = producto_data.stock
    producto.descripcion = producto_data.descripcion
    producto.save()
    return producto


@producto_router.delete("/{id}")
async def elminarProducto(id: int):
    producto = ProductoModel.get_or_none(id = id)
    if not producto:
        return {"message": "Producto no encontrado"}
    producto.delete_instance()
    return {"message": "Producto eliminado"}



@producto_router.get("/categoria", response_model = list[CategoriaModelSchema])
async def get_categoria():
    data = CategoriaModel.select()
    return list(data)

@producto_router.post("/categoria", response_model = CategoriaModelSchema)
async def registrarCategoria(categoria_schema: CategoriaSchema):
    categoria = CategoriaModel(
        **categoria_schema.dict()
    )
    categoria.save()
    return categoria

@producto_router.delete("/categoria/{id}")
async def eliminarCategoria(id: int):
    categoria = CategoriaModel.get_or_none(id = id)
    if not categoria:
        return {"message": "Categoria no encontrada"}
    categoria.delete_instance()
    return {"message": "Categoria eliminada"}