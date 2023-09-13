from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from . import database,models
from .router import user,kazi,acma,auth,acma_bilgi
from fastapi.middleware.cors import CORSMiddleware

models.Base.metadata.create_all(bind=database.engine)

app=FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],  # Tüm HTTP yöntemlerine izin vermek için
    allow_headers=["*"],  # Tüm başlıklara izin vermek için
)
app.mount("/images",StaticFiles(directory="images"),name="images")

app.include_router(
    router=user.router,
    prefix="/user",
    tags=["Users"],
)
app.include_router(
    router=kazi.router,
    prefix="/kazi",
    tags=["Kazilar"],
)
app.include_router(
    router=acma.router,
    prefix="/acma",
    tags=["Açmalar"],
)
app.include_router(
    router=acma_bilgi.router,
    prefix="/acma-bilgi",
    tags=["Açma Bilgi"],
)
app.include_router(
    router=auth.router,
    prefix="/auth",
    tags=["Authentication"],
)


@app.get("/")
def index():
    return {"message":"starting"}

