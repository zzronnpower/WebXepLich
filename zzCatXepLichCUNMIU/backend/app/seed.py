# -*- coding: utf-8 -*-
from datetime import date, timedelta

from sqlalchemy.orm import Session

from backend.app import models


def lay_thu_hai_tuan_nay() -> date:
    hom_nay = date.today()
    return hom_nay - timedelta(days=hom_nay.weekday())


def tao_du_lieu_mau(phien: Session):
    if phien.query(models.NhanVien).first():
        return

    ca_lam = [
        models.CaLam(ten_ca="8h-19h", gio_bat_dau="8h", gio_ket_thuc="19h", so_gio=11, la_ca_muon=False),
        models.CaLam(ten_ca="8h30-19h30", gio_bat_dau="8h30", gio_ket_thuc="19h30", so_gio=11, la_ca_muon=False),
        models.CaLam(ten_ca="9h-20h", gio_bat_dau="9h", gio_ket_thuc="20h", so_gio=11, la_ca_muon=True),
        models.CaLam(ten_ca="10h-21h", gio_bat_dau="10h", gio_ket_thuc="21h", so_gio=11, la_ca_muon=True),
        models.CaLam(ten_ca="8h30-19h", gio_bat_dau="8h30", gio_ket_thuc="19h", so_gio=10, la_ca_muon=False),
    ]
    phien.add_all(ca_lam)
    phien.flush()

    chi_nhanh = [
        models.ChiNhanh(ma_chi_nhanh="326", ten_chi_nhanh="326TTV"),
        models.ChiNhanh(ma_chi_nhanh="197", ten_chi_nhanh="197LT5"),
    ]
    phien.add_all(chi_nhanh)
    phien.flush()

    vai_tro = [
        models.VaiTro(ten_vai_tro="Bác sỹ"),
        models.VaiTro(ten_vai_tro="KTV"),
        models.VaiTro(ten_vai_tro="Lễ tân"),
    ]
    phien.add_all(vai_tro)
    phien.flush()

    nhan_vien = [
        models.NhanVien(ma_nv="BS01", ten_nv="Hữu", cap_do="Bác sỹ chính", muc_uu_tien=5, gio_toi_da_tuan=66),
        models.NhanVien(ma_nv="BS02", ten_nv="Nhựt", cap_do="Bác sỹ chính", muc_uu_tien=5, gio_toi_da_tuan=66),
        models.NhanVien(ma_nv="BS03", ten_nv="Hồng", cap_do="Bác sỹ chính", muc_uu_tien=5, gio_toi_da_tuan=66),
        models.NhanVien(ma_nv="BS04", ten_nv="Thy", cap_do="Bác sỹ chính", muc_uu_tien=5, gio_toi_da_tuan=66),
        models.NhanVien(ma_nv="BS05", ten_nv="Thùy", cap_do="Bác sỹ mới", muc_uu_tien=2, gio_toi_da_tuan=66),
        models.NhanVien(ma_nv="BS06", ten_nv="My", cap_do="Bác sỹ mới", muc_uu_tien=2, gio_toi_da_tuan=66),
        models.NhanVien(ma_nv="BS07", ten_nv="Hà", cap_do="Bác sỹ mới", muc_uu_tien=2, gio_toi_da_tuan=66),
        models.NhanVien(ma_nv="BS08", ten_nv="Đạt", cap_do="Bác sỹ mới", muc_uu_tien=2, gio_toi_da_tuan=66),
        models.NhanVien(ma_nv="BS09", ten_nv="Hiếu", cap_do="Bác sỹ mới", muc_uu_tien=2, gio_toi_da_tuan=66),
        models.NhanVien(ma_nv="BS10", ten_nv="Phong", cap_do="Bác sỹ mới", muc_uu_tien=2, gio_toi_da_tuan=66),
        models.NhanVien(ma_nv="BS11", ten_nv="Đăng", cap_do="Bác sỹ mới", muc_uu_tien=2, gio_toi_da_tuan=66),
    ]
    phien.add_all(nhan_vien)
    phien.flush()

    for nv in nhan_vien:
        nv.vai_tro = [vai_tro[0]]

    ca_9_20 = next(ca for ca in ca_lam if ca.ten_ca == "9h-20h")
    ca_10_21 = next(ca for ca in ca_lam if ca.ten_ca == "10h-21h")
    ca_8_19 = next(ca for ca in ca_lam if ca.ten_ca == "8h-19h")
    nhan_vien[0].ca_ua_thich = [ca_9_20]
    nhan_vien[1].ca_ua_thich = [ca_10_21]
    nhan_vien[2].ca_ua_thich = [ca_8_19]
    nhan_vien[3].ca_tranh = [ca_10_21]

    nhom = [
        models.NhomHienThi(ten_nhom="326TTV", mau_nen="#d7f2ff"),
        models.NhomHienThi(ten_nhom="197LT5", mau_nen="#d9f7e6"),
        models.NhomHienThi(ten_nhom="CN", mau_nen="#ffd8e6"),
        models.NhomHienThi(ten_nhom="PHU_SPA", mau_nen="#f2d7ff"),
        models.NhomHienThi(ten_nhom="OFF", mau_nen="#e6e6e6"),
        models.NhomHienThi(ten_nhom="CHUA_XEP", mau_nen="#f4f4f4"),
    ]
    phien.add_all(nhom)
    phien.flush()

    def map_nhom(chi, ca, nhom_obj):
        phien.add(models.MappingNhom(chi_nhanh_id=chi, ca_id=ca, nhom_hien_thi_id=nhom_obj.id))

    cn326 = next(cn for cn in chi_nhanh if cn.ma_chi_nhanh == "326")
    cn197 = next(cn for cn in chi_nhanh if cn.ma_chi_nhanh == "197")

    nhan_vien[0].chi_nhanh = [cn326]
    nhan_vien[1].chi_nhanh = [cn197]

    for ca in ca_lam:
        if ca.ten_ca in {"8h-19h", "8h30-19h30", "9h-20h", "10h-21h"}:
            map_nhom(cn326.id, ca.id, nhom[0])
        if ca.ten_ca in {"8h-19h", "9h-20h", "10h-21h"}:
            map_nhom(cn197.id, ca.id, nhom[1])
        if ca.ten_ca in {"9h-20h"}:
            map_nhom(None, ca.id, nhom[2])

    thu_hai = lay_thu_hai_tuan_nay()
    for i in range(7):
        ngay = thu_hai + timedelta(days=i)
        phien.add(
            models.NhuCauCa(
                ngay=ngay,
                chi_nhanh_id=cn326.id,
                ca_id=ca_8_19.id,
                so_nguoi_can=1,
                vai_tro_yeu_cau_id=None,
                do_quan_trong=3,
            )
        )
        phien.add(
            models.NhuCauCa(
                ngay=ngay,
                chi_nhanh_id=cn326.id,
                ca_id=ca_9_20.id,
                so_nguoi_can=1,
                vai_tro_yeu_cau_id=None,
                do_quan_trong=4,
            )
        )
        phien.add(
            models.NhuCauCa(
                ngay=ngay,
                chi_nhanh_id=cn197.id,
                ca_id=ca_9_20.id,
                so_nguoi_can=1,
                vai_tro_yeu_cau_id=None,
                do_quan_trong=3,
            )
        )
    phien.add(models.TrongSoUuTien(khoa="uu_tien_ca_ua_thich", gia_tri=4))
    phien.add(models.TrongSoUuTien(khoa="phat_ca_tranh", gia_tri=6))
    phien.add(models.TrongSoUuTien(khoa="cong_bang_chich_ngoai", gia_tri=5))
    phien.add(models.TrongSoUuTien(khoa="cong_bang_cuoi_tuan", gia_tri=4))
    phien.add(models.TrongSoUuTien(khoa="khong_di_chich_ngoai", gia_tri=6))
    phien.add(models.TrongSoUuTien(khoa="uu_tien_ca_quan_trong", gia_tri=3))
    phien.add(models.TrongSoUuTien(khoa="han_che_ca_muon_sang", gia_tri=2))
    phien.add(models.TrongSoUuTien(khoa="bat_buoc_chich_ngoai", gia_tri=1))

    phien.commit()
