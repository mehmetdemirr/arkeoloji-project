from pydantic import BaseModel

class UserLogin(BaseModel):
    username:str
    password:str

class UserCreate(BaseModel):
    name:str
    username:str
    password:str
    rol:str
    activate:bool

class UserShow(BaseModel):
    id:int
    name:str
    username:str
    rol:str
    activate:bool
    # acmalar:list[AcmaShow]

    class Config:
        from_attributes = True


class AcmaBilgiShow(BaseModel):
    id:int
    name:str
    description:str
    photo:str
    acma_id:int
    owner:UserShow
    class Config:
        from_attributes = True

class AcmaBilgiCreate(BaseModel):
    name:str
    description:str
    acma_id:int

class AcmaCreate(BaseModel):
    name:str
    kazi_id:int

class AcmaShow(BaseModel):
    id:int
    name:str
    kazi_id:int
    owner:UserShow
    acma_bilgileri:list[AcmaBilgiShow]
    class Config:
        from_attributes = True

class KaziShow(BaseModel):
    id:int
    name:str
    city:str
    town:str
    owner:UserShow
    acmalar:list[AcmaShow]
    users:list[UserShow]
    class Config:
        from_attributes = True

class KaziCreate(BaseModel):
    name:str
    city:str
    town:str

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    id: int | None = None