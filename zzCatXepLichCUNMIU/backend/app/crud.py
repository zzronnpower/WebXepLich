# -*- coding: utf-8 -*-
from sqlalchemy.orm import Session

from backend.app import models


def tao_hoac_lay_vai_tro(phien: Session, ten_vai_tro: str) -> models.VaiTro:
    vai_tro = phien.query(models.VaiTro).filter(models.VaiTro.ten_vai_tro == ten_vai_tro).first()
    if vai_tro:
        return vai_tro
    vai_tro = models.VaiTro(ten_vai_tro=ten_vai_tro)
    phien.add(vai_tro)
    phien.flush()
    return vai_tro


def tao_nhan_vien(
    phien: Session,
    ma_nv: str,
    ten_nv: str,
    cap_do: str | None,
    muc_uu_tien: int,
    gio_toi_da_tuan: int,
    ghi_chu: str | None,
    danh_sach_vai_tro: list[str],
    danh_sach_ca_ua_thich: list[int],
    danh_sach_ca_tranh: list[int],
    danh_sach_chi_nhanh: list[int] | None = None,
    danh_sach_trong_so: list[int] | None = None,
):
    nhan_vien = models.NhanVien(
        ma_nv=ma_nv,
        ten_nv=ten_nv,
        cap_do=cap_do,
        muc_uu_tien=muc_uu_tien,
        gio_toi_da_tuan=gio_toi_da_tuan,
        ghi_chu=ghi_chu,
    )
    vai_tro = [tao_hoac_lay_vai_tro(phien, ten) for ten in danh_sach_vai_tro if ten.strip()]
    nhan_vien.vai_tro = vai_tro
    if danh_sach_ca_ua_thich:
        nhan_vien.ca_ua_thich = (
            phien.query(models.CaLam).filter(models.CaLam.id.in_(danh_sach_ca_ua_thich)).all()
        )
    if danh_sach_ca_tranh:
        nhan_vien.ca_tranh = (
            phien.query(models.CaLam).filter(models.CaLam.id.in_(danh_sach_ca_tranh)).all()
        )
    if danh_sach_chi_nhanh:
        nhan_vien.chi_nhanh = (
            phien.query(models.ChiNhanh).filter(models.ChiNhanh.id.in_(danh_sach_chi_nhanh)).all()
        )
    if danh_sach_trong_so:
        for ts_id in danh_sach_trong_so:
            ts = phien.query(models.TrongSoUuTien).filter(models.TrongSoUuTien.id == ts_id).first()
            if not ts:
                continue
            nhan_vien.trong_so_uu_tien.append(
                models.NhanVienTrongSo(
                    trong_so_id=ts.id,
                    muc_uu_tien=ts.gia_tri,
                )
            )
    phien.add(nhan_vien)
    phien.commit()
    phien.refresh(nhan_vien)
    return nhan_vien


def cap_nhat_nhan_vien(
    phien: Session,
    nhan_vien: models.NhanVien,
    ma_nv: str,
    ten_nv: str,
    cap_do: str | None,
    muc_uu_tien: int,
    gio_toi_da_tuan: int,
    ghi_chu: str | None,
    danh_sach_vai_tro: list[str],
    danh_sach_ca_ua_thich: list[int],
    danh_sach_ca_tranh: list[int],
    danh_sach_chi_nhanh: list[int] | None = None,
    danh_sach_trong_so: list[int] | None = None,
):
    nhan_vien.ma_nv = ma_nv
    nhan_vien.ten_nv = ten_nv
    nhan_vien.cap_do = cap_do
    nhan_vien.muc_uu_tien = muc_uu_tien
    nhan_vien.gio_toi_da_tuan = gio_toi_da_tuan
    nhan_vien.ghi_chu = ghi_chu
    nhan_vien.vai_tro = [tao_hoac_lay_vai_tro(phien, ten) for ten in danh_sach_vai_tro if ten.strip()]
    nhan_vien.ca_ua_thich = (
        phien.query(models.CaLam).filter(models.CaLam.id.in_(danh_sach_ca_ua_thich)).all()
        if danh_sach_ca_ua_thich
        else []
    )
    nhan_vien.ca_tranh = (
        phien.query(models.CaLam).filter(models.CaLam.id.in_(danh_sach_ca_tranh)).all()
        if danh_sach_ca_tranh
        else []
    )
    nhan_vien.chi_nhanh = (
        phien.query(models.ChiNhanh).filter(models.ChiNhanh.id.in_(danh_sach_chi_nhanh)).all()
        if danh_sach_chi_nhanh
        else []
    )
    phien.query(models.NhanVienTrongSo).filter(models.NhanVienTrongSo.nhan_vien_id == nhan_vien.id).delete()
    if danh_sach_trong_so:
        for ts_id in danh_sach_trong_so:
            ts = phien.query(models.TrongSoUuTien).filter(models.TrongSoUuTien.id == ts_id).first()
            if not ts:
                continue
            phien.add(
                models.NhanVienTrongSo(
                    nhan_vien_id=nhan_vien.id,
                    trong_so_id=ts.id,
                    muc_uu_tien=ts.gia_tri,
                )
            )
    phien.commit()
    phien.refresh(nhan_vien)
    return nhan_vien


def tao_ngay_nghi(
    phien: Session,
    nhan_vien_id: int,
    ngay,
    trang_thai: str,
    ghi_chu: str | None,
    nguon: str = "user",
):
    ton_tai = (
        phien.query(models.NgayNghi)
        .filter(models.NgayNghi.nhan_vien_id == nhan_vien_id)
        .filter(models.NgayNghi.ngay == ngay)
        .first()
    )
    if ton_tai:
        ton_tai.trang_thai = trang_thai
        ton_tai.nguon = nguon
        ton_tai.ghi_chu = ghi_chu
        phien.commit()
        return ton_tai

    ngay_nghi = models.NgayNghi(
        nhan_vien_id=nhan_vien_id,
        ngay=ngay,
        trang_thai=trang_thai,
        nguon=nguon,
        ghi_chu=ghi_chu,
    )
    phien.add(ngay_nghi)
    phien.commit()
    return ngay_nghi


def tao_nhu_cau_ca(
    phien: Session,
    ngay,
    chi_nhanh_id: int | None,
    ca_id: int,
    so_nguoi_can: int,
    vai_tro_yeu_cau_id: int | None,
    do_quan_trong: int | None,
    senior_toi_thieu: int | None,
):
    ton_tai = (
        phien.query(models.NhuCauCa)
        .filter(models.NhuCauCa.ngay == ngay)
        .filter(models.NhuCauCa.chi_nhanh_id == chi_nhanh_id)
        .filter(models.NhuCauCa.ca_id == ca_id)
        .filter(models.NhuCauCa.vai_tro_yeu_cau_id == vai_tro_yeu_cau_id)
        .first()
    )
    if ton_tai:
        ton_tai.so_nguoi_can = so_nguoi_can
        ton_tai.do_quan_trong = do_quan_trong
        ton_tai.senior_toi_thieu = senior_toi_thieu
        phien.commit()
        return ton_tai

    nhu_cau = models.NhuCauCa(
        ngay=ngay,
        chi_nhanh_id=chi_nhanh_id,
        ca_id=ca_id,
        so_nguoi_can=so_nguoi_can,
        vai_tro_yeu_cau_id=vai_tro_yeu_cau_id,
        do_quan_trong=do_quan_trong,
        senior_toi_thieu=senior_toi_thieu,
    )
    phien.add(nhu_cau)
    phien.commit()
    return nhu_cau


def tao_hoac_cap_nhat_trong_so(phien: Session, khoa: str, gia_tri: int):
    trong_so = phien.query(models.TrongSoUuTien).filter(models.TrongSoUuTien.khoa == khoa).first()
    if trong_so:
        trong_so.gia_tri = gia_tri
    else:
        trong_so = models.TrongSoUuTien(khoa=khoa, gia_tri=gia_tri)
        phien.add(trong_so)
    phien.commit()
    return trong_so
