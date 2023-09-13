from fastapi import APIRouter,Depends,HTTPException,status
from .. import database,models,schemas,hashed,oauth2,enum
from sqlalchemy.orm import Session
from typing import List

router=APIRouter()


@router.post("/",response_model=schemas.UserShow)
def get_users(user:schemas.UserCreate,db:Session=Depends(database.get_db)):
    u=db.query(models.User).filter(models.User.username==user.username).first()
    if u:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{user.username} bir kullanıcı zaten var")
    if user.rol is None or (user.rol != enum.Rol.ADMIN and user.rol != enum.Rol.USER):
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"rol tanımlı değil")
    
    user.password=hashed.get_password_hash(user.password)
    new_user=models.User(name=user.name,username=user.username,
                         password=user.password,rol=user.rol,
                         activate=user.activate)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

@router.get("/",response_model=List[schemas.UserShow])
def get_users(db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    users=db.query(models.User).all()
    return users

@router.get("/{id}",response_model=schemas.UserShow)
def get_users(id:int,db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    user=db.query(models.User).filter(models.User.id==id).first()
    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{id}'li kullanıcı yok")
    return user

@router.delete("/{id}")
def get_users(id:int,db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    user=db.query(models.User).filter(models.User.id==id)
    if not user.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{id} id'li kullanıcı yok")
    if user.first().id != current_user.id:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"yetkiniz yok")
    user.delete(synchronize_session=False)
    db.commit()
    return {"details":f"{id}'li kullanıcı silindi"}

@router.put("/{id}",response_model=schemas.UserShow)
def get_users(id:int,user:schemas.UserCreate,db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    u=db.query(models.User).filter(models.User.id==id)
    if not u.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{id} id'li kullanıcı yok")
    if u.first().id != current_user.id:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"yetkiniz yok")
    user.password=hashed.get_password_hash(user.password)
    u.update({"name":user.name,"username":user.username,
                         "password":user.password,"rol":user.rol,
                         "activate":user.activate},synchronize_session=False)
    db.commit()
    return u.first()