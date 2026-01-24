# -*- coding: utf-8 -*-
from sqlalchemy import (
    Boolean,
    Column,
    Date,
    ForeignKey,
    Integer,
    String,
    Table,
    Text,
)
from sqlalchemy.orm import relationship

from backend.app.db import CoSo


nhan_vien_vai_tro = Table(
    "nhan_vien_vai_tro",
    CoSo.metadata,
    Column("nhan_vien_id", ForeignKey("nhan_vien.id", ondelete="CASCADE"), primary_key=True),
    Column("vai_tro_id", ForeignKey("vai_tro.id", ondelete="CASCADE"), primary_key=True),
)

nhan_vien_ca_ua_thich = Table(
    "nhan_vien_ca_ua_thich",
    CoSo.metadata,
    Column("nhan_vien_id", ForeignKey("nhan_vien.id", ondelete="CASCADE"), primary_key=True),
    Column("ca_id", ForeignKey("ca_lam.id", ondelete="CASCADE"), primary_key=True),
)

nhan_vien_ca_tranh = Table(
    "nhan_vien_ca_tranh",
    CoSo.metadata,
    Column("nhan_vien_id", ForeignKey("nhan_vien.id", ondelete="CASCADE"), primary_key=True),
    Column("ca_id", ForeignKey("ca_lam.id", ondelete="CASCADE"), primary_key=True),
)

nhan_vien_chi_nhanh = Table(
    "nhan_vien_chi_nhanh",
    CoSo.metadata,
    Column("nhan_vien_id", ForeignKey("nhan_vien.id", ondelete="CASCADE"), primary_key=True),
    Column("chi_nhanh_id", ForeignKey("chi_nhanh.id", ondelete="CASCADE"), primary_key=True),
)


class NhanVien(CoSo):
    __tablename__ = "nhan_vien"

    id = Column(Integer, primary_key=True, index=True)
    ma_nv = Column(String, unique=True, nullable=False)
    ten_nv = Column(String, nullable=False)
    cap_do = Column(String, nullable=True)
    muc_uu_tien = Column(Integer, default=0)
    gio_toi_da_tuan = Column(Integer, default=44)
    ghi_chu = Column(Text, nullable=True)

    vai_tro = relationship("VaiTro", secondary=nhan_vien_vai_tro, back_populates="nhan_vien")
    ca_ua_thich = relationship("CaLam", secondary=nhan_vien_ca_ua_thich, back_populates="nhan_vien_ua_thich")
    ca_tranh = relationship("CaLam", secondary=nhan_vien_ca_tranh, back_populates="nhan_vien_tranh")
    chi_nhanh = relationship("ChiNhanh", secondary=nhan_vien_chi_nhanh)
    trong_so_uu_tien = relationship(
        "NhanVienTrongSo",
        back_populates="nhan_vien",
        cascade="all, delete-orphan",
    )


class VaiTro(CoSo):
    __tablename__ = "vai_tro"

    id = Column(Integer, primary_key=True, index=True)
    ten_vai_tro = Column(String, unique=True, nullable=False)

    nhan_vien = relationship("NhanVien", secondary=nhan_vien_vai_tro, back_populates="vai_tro")


class CaLam(CoSo):
    __tablename__ = "ca_lam"

    id = Column(Integer, primary_key=True, index=True)
    ten_ca = Column(String, unique=True, nullable=False)
    gio_bat_dau = Column(String, nullable=False)
    gio_ket_thuc = Column(String, nullable=False)
    so_gio = Column(Integer, default=11)
    la_ca_muon = Column(Boolean, default=False)

    nhan_vien_ua_thich = relationship("NhanVien", secondary=nhan_vien_ca_ua_thich, back_populates="ca_ua_thich")
    nhan_vien_tranh = relationship("NhanVien", secondary=nhan_vien_ca_tranh, back_populates="ca_tranh")


class ChiNhanh(CoSo):
    __tablename__ = "chi_nhanh"

    id = Column(Integer, primary_key=True, index=True)
    ma_chi_nhanh = Column(String, unique=True, nullable=False)
    ten_chi_nhanh = Column(String, nullable=False)


class NgayNghi(CoSo):
    __tablename__ = "ngay_nghi"

    id = Column(Integer, primary_key=True, index=True)
    nhan_vien_id = Column(Integer, ForeignKey("nhan_vien.id", ondelete="CASCADE"))
    ngay = Column(Date, nullable=False)
    trang_thai = Column(String, default="OFF")
    ghi_chu = Column(Text, nullable=True)

    nhan_vien = relationship("NhanVien")


class NhuCauCa(CoSo):
    __tablename__ = "nhu_cau_ca"

    id = Column(Integer, primary_key=True, index=True)
    ngay = Column(Date, nullable=False)
    chi_nhanh_id = Column(Integer, ForeignKey("chi_nhanh.id", ondelete="SET NULL"), nullable=True)
    ca_id = Column(Integer, ForeignKey("ca_lam.id", ondelete="CASCADE"))
    so_nguoi_can = Column(Integer, nullable=False)
    vai_tro_yeu_cau_id = Column(Integer, ForeignKey("vai_tro.id", ondelete="SET NULL"), nullable=True)
    do_quan_trong = Column(Integer, nullable=True)
    senior_toi_thieu = Column(Integer, nullable=True)

    chi_nhanh = relationship("ChiNhanh")
    ca_lam = relationship("CaLam")
    vai_tro_yeu_cau = relationship("VaiTro")


class TrongSoUuTien(CoSo):
    __tablename__ = "trong_so_uu_tien"

    id = Column(Integer, primary_key=True, index=True)
    khoa = Column(String, unique=True, nullable=False)
    gia_tri = Column(Integer, default=0)

    nhan_vien_trong_so = relationship("NhanVienTrongSo", back_populates="trong_so")


class NhanVienTrongSo(CoSo):
    __tablename__ = "nhan_vien_trong_so"

    id = Column(Integer, primary_key=True, index=True)
    nhan_vien_id = Column(Integer, ForeignKey("nhan_vien.id", ondelete="CASCADE"))
    trong_so_id = Column(Integer, ForeignKey("trong_so_uu_tien.id", ondelete="CASCADE"))
    muc_uu_tien = Column(Integer, default=1)

    nhan_vien = relationship("NhanVien", back_populates="trong_so_uu_tien")
    trong_so = relationship("TrongSoUuTien", back_populates="nhan_vien_trong_so")


class NhomHienThi(CoSo):
    __tablename__ = "nhom_hien_thi"

    id = Column(Integer, primary_key=True, index=True)
    ten_nhom = Column(String, unique=True, nullable=False)
    mau_nen = Column(String, nullable=True)


class MappingNhom(CoSo):
    __tablename__ = "mapping_nhom"

    id = Column(Integer, primary_key=True, index=True)
    chi_nhanh_id = Column(Integer, ForeignKey("chi_nhanh.id", ondelete="CASCADE"), nullable=True)
    ca_id = Column(Integer, ForeignKey("ca_lam.id", ondelete="CASCADE"), nullable=True)
    nhom_hien_thi_id = Column(Integer, ForeignKey("nhom_hien_thi.id", ondelete="CASCADE"))

    chi_nhanh = relationship("ChiNhanh")
    ca_lam = relationship("CaLam")
    nhom_hien_thi = relationship("NhomHienThi")


class LichTuan(CoSo):
    __tablename__ = "lich_tuan"

    id = Column(Integer, primary_key=True, index=True)
    ngay_bat_dau = Column(Date, nullable=False)
    ngay_ket_thuc = Column(Date, nullable=False)
    trang_thai = Column(String, default="MOI")
    ghi_chu = Column(Text, nullable=True)


class LichChiTiet(CoSo):
    __tablename__ = "lich_chi_tiet"

    id = Column(Integer, primary_key=True, index=True)
    lich_tuan_id = Column(Integer, ForeignKey("lich_tuan.id", ondelete="CASCADE"))
    ngay = Column(Date, nullable=False)
    chi_nhanh_id = Column(Integer, ForeignKey("chi_nhanh.id", ondelete="SET NULL"), nullable=True)
    ca_id = Column(Integer, ForeignKey("ca_lam.id", ondelete="SET NULL"), nullable=True)
    nhan_vien_id = Column(Integer, ForeignKey("nhan_vien.id", ondelete="CASCADE"))
    nhom_hien_thi_id = Column(Integer, ForeignKey("nhom_hien_thi.id", ondelete="SET NULL"), nullable=True)

    nhan_vien = relationship("NhanVien")
    chi_nhanh = relationship("ChiNhanh")
    ca_lam = relationship("CaLam")
    nhom_hien_thi = relationship("NhomHienThi")
    lich_tuan = relationship("LichTuan")
