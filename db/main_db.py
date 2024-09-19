from typing import List
from peewee import (
    Model,
    SqliteDatabase
)

class ConfigDB:
    db = SqliteDatabase('db/main.db')

    def __init__(self, model: List[str]):
        self.model = model

    def refresh_db(self):
        self.db.create_tables(self.model)

    def close_db(self):
        if not self.db.is_closed():
            self.db.close()
    
    def connect_db(self):
        if self.db.is_closed():
            self.db.connect()
            self.refresh_db()

class BaseModel(Model):
    class Meta:
        database = ConfigDB.db