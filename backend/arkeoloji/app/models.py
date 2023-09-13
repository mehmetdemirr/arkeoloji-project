from sqlalchemy import Column,Integer,Text,Boolean,String,ForeignKey,Table
from .database import Base
from sqlalchemy.orm import relationship

# Bağlantı tablosu (association table) tanımı
kazi_users = Table('kazi_users', Base.metadata,
    Column('kazi_id', Integer, ForeignKey('kazi.id')),
    Column('user_id', Integer, ForeignKey('users.id'))
)

class User(Base):
    __tablename__="users"
    id=Column(Integer,primary_key=True,autoincrement=True)
    name=Column(String)
    username=Column(String,unique=True)
    password=Column(String)
    rol=Column(String)
    activate=Column(Boolean,default= True)
    kazilar=relationship("Kazi",back_populates="owner")
    acmalar=relationship("Acma",back_populates="owner")
    acma_bilgi=relationship("AcmaBilgi",back_populates="owner")
    kazi_list = relationship("Kazi", secondary=kazi_users, back_populates="users")
    
class Kazi(Base):
    __tablename__="kazi"
    id=Column(Integer,primary_key=True,autoincrement=True)
    name=Column(String)
    city=Column(String)
    town=Column(String)
    owner_id=Column(Integer,ForeignKey("users.id"))
    owner=relationship("User",back_populates="kazilar")
    acmalar=relationship("Acma",back_populates="kazi")
    users = relationship("User", secondary=kazi_users, back_populates="kazi_list")

class Acma(Base):
    __tablename__="acma"
    id=Column(Integer,primary_key=True,autoincrement=True)
    name=Column(String)
    owner_id=Column(Integer,ForeignKey("users.id"))
    kazi_id=Column(Integer,ForeignKey("kazi.id"))
    kazi=relationship("Kazi",back_populates="acmalar")
    owner=relationship("User",back_populates="acmalar")
    acma_bilgileri=relationship("AcmaBilgi",back_populates="acma")

class AcmaBilgi(Base):
    __tablename__="acmabilgisi"
    id=Column(Integer,primary_key=True,autoincrement=True)
    name=Column(String)
    description=Column(String)
    photo=Column(String)
    owner_id=Column(Integer,ForeignKey("users.id"))
    acma_id=Column(Integer,ForeignKey("acma.id"))
    acma=relationship("Acma",back_populates="acma_bilgileri")
    owner=relationship("User",back_populates="acma_bilgi")
