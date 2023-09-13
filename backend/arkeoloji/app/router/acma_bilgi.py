from fastapi import APIRouter,Depends,status,HTTPException,File,UploadFile
from .. import database,models,schemas,oauth2
from sqlalchemy.orm import Session
from typing import List
import uuid 

router=APIRouter()
IMAGEDIR="images/"

@router.post("/",response_model=schemas.AcmaBilgiShow)
async def get_users(acmaBilgi:schemas.AcmaBilgiCreate=Depends(),
                    file:UploadFile =File(...),
                    db:Session=Depends(database.get_db),
              get_current:schemas.UserShow=Depends(oauth2.get_current_user),):
    random_uuid = str(uuid.uuid4())
    file.filename=f"{random_uuid}.jpg"
    contents=await file.read()
    #save as file
    with open(f"{IMAGEDIR}{file.filename}","wb") as f:
        f.write(contents)

    new_acma_bilgi=models.AcmaBilgi(name=acmaBilgi.name,description=acmaBilgi.description,
                               photo=f"http://127.0.0.1:8000/images/{file.filename}",acma_id=acmaBilgi.acma_id,
                               owner_id=get_current.id)
    db.add(new_acma_bilgi)
    db.commit()
    db.refresh(new_acma_bilgi)
    return new_acma_bilgi

# @router.get("/",response_model=List[schemas.AcmaBilgiShow])
# def get_users(db:Session=Depends(database.get_db),
#               get_current:schemas.UserShow=Depends(oauth2.get_current_user)):
#     acmalar=db.query(models.AcmaBilgi).all()
#     return acmalar

@router.get("/{acma_id}",response_model=List[schemas.AcmaBilgiShow])
def get_users(acma_id:int,db:Session=Depends(database.get_db),
              get_current:schemas.UserShow=Depends(oauth2.get_current_user)):
    acma_bilgileri=db.query(models.AcmaBilgi).filter(models.AcmaBilgi.acma_id==acma_id).all()
    if not acma_bilgileri:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{acma_id} id'li acmada bilgi yok")
    return acma_bilgileri

@router.delete("/{id}")
def get_users(id:int,db:Session=Depends(database.get_db),
              get_current:schemas.UserShow=Depends(oauth2.get_current_user)):
    acma_bilgi=db.query(models.AcmaBilgi).filter(models.AcmaBilgi.id==id)
    if not acma_bilgi.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{id} id'li açma bilgisi yok")
    acma=db.query(models.Acma).filter(models.Acma.id==acma_bilgi.first().acma_id).first()
    kazi=db.query(models.Kazi).filter(models.Kazi.id == acma.kazi_id).first()
    # if not acma:
    #     raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
    #                         detail=f"{id} id'li acma yok")
    # if acma_bilgi.first().owner_id != get_current.id:
    #     raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
    #                         detail="yetkisiz işlem")
    if kazi.owner_id != get_current.id:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail="yetkisiz işlem")
    acma_bilgi.delete(synchronize_session=False)
    db.commit()
    return {"details":"true"}

@router.put("/{id}",response_model=schemas.AcmaBilgiShow)
def get_users(id:int,acmaBilgi:schemas.AcmaBilgiCreate,db:Session=Depends(database.get_db),
              get_current:schemas.UserShow=Depends(oauth2.get_current_user)):
    acma_bilgi=db.query(models.AcmaBilgi).filter(models.AcmaBilgi.id==id)
    if not acma_bilgi.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{id} id'li açma bilgisi yok")
    acma=db.query(models.Acma).filter(models.Acma.id==acma_bilgi.first().acma_id).first()
    if not acma:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"{id} id'li acma yok")
    if acma_bilgi.first().owner_id != get_current.id:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail="yetkisiz işlem")
    acma_bilgi.update({"name":acmaBilgi.name,"description":acmaBilgi.description,
                       "acma_id":acmaBilgi.acma_id},synchronize_session=False)
    db.commit()
    return {"details":f"{id} id'li açmabilgi güncellendi!!"}