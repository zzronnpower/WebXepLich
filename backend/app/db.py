# -*- coding: utf-8 -*-
import os

from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker


CO_SO_DU_LIEU_URL = os.getenv(
    "CO_SO_DU_LIEU_URL",
    "postgresql+psycopg2://lich_user:lich_pass@localhost:5432/lich_lam_viec",
)

dong_co = create_engine(CO_SO_DU_LIEU_URL, future=True)
PhienLamViec = sessionmaker(autocommit=False, autoflush=False, bind=dong_co)
CoSo = declarative_base()


def lay_phien_lam_viec():
    phien = PhienLamViec()
    try:
        yield phien
    finally:
        phien.close()
