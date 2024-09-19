from db.main_db import BaseModel
from peewee import (
    CharField,
    TextField,
    DecimalField,
    IntegerField
)

class ProductoModel(BaseModel):
    nombre =  CharField(max_length=255)
    descripcion = TextField()
    precio = DecimalField(max_digits=10, decimal_places=2)
    imagen = CharField(max_length=255, null=True)
    stock = IntegerField( default=0 )

    class Meta:
        table_name = "productos"

class CategoriaModel(BaseModel):
    nombre = CharField(max_length=255)
    descripcion = TextField()
    imagen = CharField(max_length=255, null=True)

    class Meta:
        table_name = "categorias"