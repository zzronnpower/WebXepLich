# -*- coding: utf-8 -*-
from __future__ import annotations

from datetime import date

from pydantic import BaseModel


class NhanVienForm(BaseModel):
    ma_nv: str
    ten_nv: str
    cap_do: str | None = None
    muc_uu_tien: int = 0
    gio_toi_da_tuan: int = 44
    ghi_chu: str | None = None
    vai_tro: list[str] = []
    ca_ua_thich: list[int] = []
    ca_tranh: list[int] = []


class NgayNghiForm(BaseModel):
    nhan_vien_id: int
    ngay: date
    trang_thai: str = "OFF"
    ghi_chu: str | None = None


class NhuCauCaForm(BaseModel):
    ngay: date
    chi_nhanh_id: int | None = None
    ca_id: int
    so_nguoi_can: int
    vai_tro_yeu_cau_id: int | None = None
    do_quan_trong: int | None = None
    senior_toi_thieu: int | None = None


class TrongSoForm(BaseModel):
    khoa: str
    gia_tri: int
