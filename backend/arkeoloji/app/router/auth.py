from typing import Annotated
from fastapi import APIRouter,Depends,status,HTTPException
from .. import database,schemas, models,hashed,oauth2
from sqlalchemy.orm import Session
from fastapi.security.oauth2 import OAuth2PasswordRequestForm

router=APIRouter()
#Annotated[OAuth2PasswordRequestForm, Depends()] //schemas.UserLogin
#response_model=schemas.Token
@router.post("/login")
def login(user: schemas.UserLogin,db:Session=Depends(database.get_db)):
    u=db.query(models.User).filter(models.User.username==user.username).first()
    if not u:
        raise  HTTPException(status_code=status.HTTP_403_FORBIDDEN,detail="Kullanıcı yok")
    if not hashed.verify_password(user.password,u.password):
        raise  HTTPException(status_code=status.HTTP_403_FORBIDDEN,detail="Şifre yanlış")
    
    access_token = oauth2.create_access_token(
        data={"id": u.id,}
    )
    return {"access_token": access_token,
            "id":u.id,
            "name":u.name,
            "username":u.username,
            "rol":u.rol,
            "activate":u.activate,
            }

# @router.post("/register")
# def login(user: schemas.UserLogin,db:Session=Depends(database.get_db)):
#     u=db.query(models.User).filter(models.User.username==user.username).first()
#     if not u:
#         raise  HTTPException(status_code=status.HTTP_403_FORBIDDEN,detail="Kullanıcı yok")
#     if not hashed.verify_password(user.password,u.password):
#         raise  HTTPException(status_code=status.HTTP_403_FORBIDDEN,detail="Şifre yanlış")
    
#     access_token = oauth2.create_access_token(
#         data={"id": u.id,}
#     )
#     return {"access_token": access_token,
#             "id":u.id,
#             "name":u.name,
#             "username":u.username,
#             "rol":u.rol,
#             "activate":u.activate,
#             }
