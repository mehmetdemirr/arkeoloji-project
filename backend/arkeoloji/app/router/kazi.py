from sqlalchemy import select
from fastapi import APIRouter,Depends,status,HTTPException
from .. import database,models,schemas,oauth2,enum
from sqlalchemy.orm import Session
from typing import List
import time

router=APIRouter()


@router.post("/",response_model=schemas.KaziShow)
def get_users(kazi:schemas.KaziCreate,db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    if current_user.rol!= enum.Rol.ADMIN:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"yetkiniz yok")
    new_kazi=models.Kazi(name=kazi.name,city=kazi.city,
                         town=kazi.town,owner_id=current_user.id)
    db.add(new_kazi)
    db.commit()
    db.refresh(new_kazi)
    return new_kazi

@router.get("/current",response_model=List[schemas.KaziShow])
def get_users(db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    
     # Kullanıcının sahip olduğu Kazi öğelerini filtreleme / Admin
    if current_user.rol== enum.Rol.ADMIN:
        kazi = db.query(models.Kazi).filter(models.Kazi.owner_id == current_user.id).all()
    # Kullanıcının üye olduğu Kazi öğelerini bulma
    elif current_user.rol== enum.Rol.USER:
        kazi = db.query(models.Kazi).join(models.kazi_users).filter(
            models.kazi_users.c.user_id == current_user.id
        ).all()
    else :
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"yetkiniz yok")
    if not kazi:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail="kazı yok")
    return kazi

@router.get("/{kazi_id}/users",response_model=List[schemas.UserShow])
def get_users(kazi_id:int,db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    kazi=db.query(models.Kazi).filter(models.Kazi.id==kazi_id).first()
    if not kazi.users:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{kazi_id} id'li kazıda kullanıcı yok")
    return kazi.users

@router.get("/",response_model=List[schemas.KaziShow])
def get_users(db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    kazilar=db.query(models.Kazi).all()
    return kazilar

@router.get("/{id}")
def get_users(id:int,db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    return {"users":f"{id} user"}

@router.delete("/{id}")
def get_users(id:int,db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    kazi=db.query(models.Kazi).filter(models.Kazi.id==id)
    if not kazi.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{id} id'li kazı yok")
    if kazi.first().owner_id!=current_user.id:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"yetkiniz yok")
    kazi.delete(synchronize_session=False)
    db.commit()
    return {"details":"true"}

@router.put("/{id}",response_model=schemas.KaziShow)
def get_users(id:int,kazi:schemas.KaziCreate,db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    kazi_new=db.query(models.Kazi).filter(models.Kazi.id==id)
    if not kazi_new.first():
       raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{id} id'li kazı yok")
    if kazi_new.first().owner_id!=current_user.id:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"yetkiniz yok")
    kazi_new.update({"name":kazi.name,"city":kazi.city,"town":kazi.town},synchronize_session=False)
    db.commit()
    return kazi_new.first()

@router.post("/{kazi_id}/user/{user_id}",)
def get_users(kazi_id:int,user_id:int,db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    kazi=db.query(models.Kazi).filter(models.Kazi.id==kazi_id)
    user=db.query(models.User).filter(models.User.id==user_id).first()
    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{user_id} id'li user yok")
    # Veritabanında belirli bir kazi_id ve user_id kombinasyonunu kontrol etmek için bir sorgu oluşturun
    query = models.kazi_users.select().where(
    (models.kazi_users.c.kazi_id == kazi_id) & (models.kazi_users.c.user_id == user_id))
    # Sorguyu veritabanına gönderin ve sonucu alın
    result = db.execute(query)
    # Sonucu kontrol edin
    if result.fetchone():
        raise HTTPException(status_code=404, detail="Kullanıcı ve kazı zaten var")
    
    if kazi.first().owner_id==user_id:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"kazı sahibi eklenemez yok")
    
    if kazi.first().owner_id!=current_user.id:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"yetkiniz yok")
    db.execute(models.kazi_users.insert().values(kazi_id=kazi_id, user_id=user_id))
    db.commit()
    return {"details":"true"}

@router.delete("/{kazi_id}/user/{user_id}/")
def get_users(kazi_id:int,user_id:int,db:Session=Depends(database.get_db),
              current_user:schemas.UserShow=Depends(oauth2.get_current_user)):
    kazi=db.query(models.Kazi).filter(models.Kazi.id==kazi_id)
    # Veritabanında belirli bir kazi_id ve user_id kombinasyonunu kontrol etmek için bir sorgu oluşturun
    query = models.kazi_users.select().where(
    (models.kazi_users.c.kazi_id == kazi_id) & (models.kazi_users.c.user_id == user_id))
    # Sorguyu veritabanına gönderin ve sonucu alın
    result = db.execute(query)
    # Sonucu kontrol edin
    if not result.fetchone():
        raise HTTPException(status_code=404, detail="Kullanıcı ve kazı bulunmadı")
    
    if kazi.first().owner_id!=current_user.id:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"yetkiniz yok")
    
    db.execute(models.kazi_users.delete().where(
    (models.kazi_users.c.kazi_id == kazi_id) & (models.kazi_users.c.user_id == user_id)))
    db.commit()
    return {"details":"true"}
