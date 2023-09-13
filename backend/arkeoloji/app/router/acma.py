from fastapi import APIRouter,Depends,status,HTTPException
from .. import database,models,schemas,oauth2
from sqlalchemy.orm import Session
from typing import List

router=APIRouter()


@router.post("/{kazi_id}",response_model=schemas.AcmaShow)
def get_users(kazi_id:int,acma:schemas.AcmaCreate,db:Session=Depends(database.get_db),
              get_current:schemas.UserShow=Depends(oauth2.get_current_user)):
    kazi=db.query(models.Kazi).filter(models.Kazi.id==kazi_id).first()
    if not kazi:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{acma.kazi_id} id'li kazı yok!!")
    new_acma=models.Acma(name=acma.name,kazi_id=kazi_id,owner_id=get_current.id)
    db.add(new_acma)
    db.commit()
    db.refresh(new_acma)
    return new_acma

# @router.get("/",response_model=List[schemas.AcmaShow])
# def get_users(db:Session=Depends(database.get_db),
#               get_current:schemas.UserShow=Depends(oauth2.get_current_user)):
#     acmalar=db.query(models.Acma).all()
#     return acmalar

@router.get("/{kazi_id}",response_model=List[schemas.AcmaShow])
def get_users(kazi_id:int,db:Session=Depends(database.get_db),
              get_current:schemas.UserShow=Depends(oauth2.get_current_user)):
    acma=db.query(models.Acma).filter(models.Acma.kazi_id==kazi_id).all()
    #"{kazi_id} kazi_id'li acma list yok"
    if not acma:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{kazi_id} kazi_id'li acma list yok")
    return acma

@router.delete("/{id}")
def get_users(id:int,db:Session=Depends(database.get_db),
              get_current:schemas.UserShow=Depends(oauth2.get_current_user)):
    acma=db.query(models.Acma).filter(models.Acma.id==id)
    if not acma.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{id} id'li acma yok")
    kazi=db.query(models.Kazi).filter(models.Kazi.id==acma.first().kazi_id).first()
    if kazi.owner_id != get_current.id:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail="yetkisiz işlem")
    acma.delete(synchronize_session=False)
    db.commit()
    return {"details":"true"}

@router.put("/{id}")
def get_users(id:int,acma:schemas.AcmaCreate,db:Session=Depends(database.get_db),
              get_current:schemas.UserShow=Depends(oauth2.get_current_user)):
    new_acma=db.query(models.Acma).filter(models.Acma.id==id)
    if not new_acma.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{id} id'li acma yok")
    if new_acma.first().owner_id!=get_current.id:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail="yetkisiz işlem")
    new_acma.update({"name":acma.name},synchronize_session=False)
    db.commit()
    return {"details":f"{id} id'li açma güncellendi!!"}