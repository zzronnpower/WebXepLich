# -*- coding: utf-8 -*-
from __future__ import annotations

from collections import defaultdict
from dataclasses import dataclass
from datetime import date, timedelta

from ortools.sat.python import cp_model
from sqlalchemy.orm import Session

from backend.app import models


@dataclass
class KetQuaLich:
    thanh_cong: bool
    thong_bao: str
    lich_tuan_id: int | None
    thieu_nhu_cau: list[str]
    diem_toi_uu: int | None = None
    tong_phan_cong: int = 0
    phan_cong: list[dict] | None = None


def danh_sach_ngay_trong_tuan(ngay_bat_dau: date) -> list[date]:
    return [ngay_bat_dau + timedelta(days=i) for i in range(7)]


def lay_trong_so(phien: Session) -> dict[str, int]:
    mac_dinh = {
        "uu_tien_ca_ua_thich": 4,
        "phat_ca_tranh": 6,
        "cong_bang_chich_ngoai": 5,
        "cong_bang_cuoi_tuan": 4,
        "khong_di_chich_ngoai": 6,
        "uu_tien_ca_quan_trong": 3,
        "han_che_ca_muon_sang": 2,
        "bat_buoc_chich_ngoai": 1,
    }
    for ts in phien.query(models.TrongSoUuTien).all():
        mac_dinh[ts.khoa] = ts.gia_tri
    return mac_dinh


def lay_nhom_hien_thi(phien: Session, chi_nhanh_id: int | None, ca_id: int | None) -> models.NhomHienThi | None:
    mapping = (
        phien.query(models.MappingNhom)
        .filter(models.MappingNhom.ca_id == ca_id)
        .filter(models.MappingNhom.chi_nhanh_id == chi_nhanh_id)
        .first()
    )
    if mapping:
        return mapping.nhom_hien_thi
    mapping = (
        phien.query(models.MappingNhom)
        .filter(models.MappingNhom.ca_id == ca_id)
        .filter(models.MappingNhom.chi_nhanh_id.is_(None))
        .first()
    )
    return mapping.nhom_hien_thi if mapping else None


def tao_nhu_cau_chich_ngoai(phien: Session, ngay_list: list[date]) -> list[models.NhuCauCa]:
    ca_9_20 = phien.query(models.CaLam).filter(models.CaLam.ten_ca == "9h-20h").first()
    if not ca_9_20:
        return []
    nhu_cau = []
    for ngay in ngay_list:
        nhu_cau.append(
            models.NhuCauCa(
                ngay=ngay,
                chi_nhanh_id=None,
                ca_id=ca_9_20.id,
                so_nguoi_can=1,
                vai_tro_yeu_cau_id=None,
                do_quan_trong=5,
                senior_toi_thieu=None,
            )
        )
    return nhu_cau


def tao_nhu_cau_mac_dinh(phien: Session, ngay_bat_dau: date) -> list[models.NhuCauCa]:
    moc = phien.query(models.NhuCauCa).order_by(models.NhuCauCa.ngay.desc()).first()
    if not moc:
        return []
    ngay_goc_bat_dau = moc.ngay - timedelta(days=moc.ngay.weekday())
    ngay_goc_ket_thuc = ngay_goc_bat_dau + timedelta(days=6)
    nhu_cau_goc = (
        phien.query(models.NhuCauCa)
        .filter(models.NhuCauCa.ngay >= ngay_goc_bat_dau)
        .filter(models.NhuCauCa.ngay <= ngay_goc_ket_thuc)
        .all()
    )
    if not nhu_cau_goc:
        return []
    chenh_lech = ngay_bat_dau - ngay_goc_bat_dau
    nhu_cau_moi = []
    for nc in nhu_cau_goc:
        nhu_cau_moi.append(
            models.NhuCauCa(
                ngay=nc.ngay + chenh_lech,
                chi_nhanh_id=nc.chi_nhanh_id,
                ca_id=nc.ca_id,
                so_nguoi_can=nc.so_nguoi_can,
                vai_tro_yeu_cau_id=nc.vai_tro_yeu_cau_id,
                do_quan_trong=nc.do_quan_trong,
                senior_toi_thieu=nc.senior_toi_thieu,
            )
        )
    phien.add_all(nhu_cau_moi)
    phien.commit()
    return nhu_cau_moi


def bo_sung_nhu_cau_bat_buoc(
    phien: Session,
    nhu_cau: list[models.NhuCauCa],
    ngay_list: list[date],
    luu_db: bool,
) -> list[models.NhuCauCa]:
    ca_8_19 = phien.query(models.CaLam).filter(models.CaLam.ten_ca == "8h-19h").first()
    ca_8_30_19_30 = (
        phien.query(models.CaLam).filter(models.CaLam.ten_ca == "8h30-19h30").first()
    )
    ca_9_20 = phien.query(models.CaLam).filter(models.CaLam.ten_ca == "9h-20h").first()
    ca_10_21 = phien.query(models.CaLam).filter(models.CaLam.ten_ca == "10h-21h").first()
    if not ca_9_20 or not ca_10_21:
        return []
    chi_nhanh_list = (
        phien.query(models.ChiNhanh)
        .filter(models.ChiNhanh.ten_chi_nhanh.in_(["326TTV", "197LT5"]))
        .all()
    )
    if not chi_nhanh_list:
        return []
    da_co = {(nc.ngay, nc.chi_nhanh_id, nc.ca_id) for nc in nhu_cau}
    can_them = []
    can_cap_nhat = []
    for cn in chi_nhanh_list:
        ca_bat_buoc = [ca_9_20, ca_10_21]
        if cn.ten_chi_nhanh == "197LT5" and ca_8_19:
            ca_bat_buoc = [ca_8_19, ca_9_20, ca_10_21]
        if cn.ten_chi_nhanh == "326TTV" and ca_8_19:
            ca_bat_buoc = [ca_8_19, ca_9_20, ca_10_21]
            if ca_8_30_19_30:
                ca_bat_buoc = [ca_8_19, ca_8_30_19_30, ca_9_20, ca_10_21]
        for ca in ca_bat_buoc:
            for ngay in ngay_list:
                key = (ngay, cn.id, ca.id)
                if key in da_co:
                    for nc in nhu_cau:
                        if (nc.ngay, nc.chi_nhanh_id, nc.ca_id) == key and nc.so_nguoi_can < 1:
                            nc.so_nguoi_can = 1
                            can_cap_nhat.append(nc)
                    continue
                moi = models.NhuCauCa(
                    ngay=ngay,
                    chi_nhanh_id=cn.id,
                    ca_id=ca.id,
                    so_nguoi_can=1,
                    vai_tro_yeu_cau_id=None,
                    do_quan_trong=3,
                    senior_toi_thieu=None,
                )
                can_them.append(moi)
                da_co.add(key)
    if luu_db and can_them:
        phien.add_all(can_them)
    if luu_db and can_cap_nhat:
        phien.flush()
    return can_them


def giai_lich_tuan(
    phien: Session,
    ngay_bat_dau: date,
    luu_db: bool = True,
    trong_so_tuy_chon: dict[str, int] | None = None,
) -> KetQuaLich:
    danh_sach_ngay = danh_sach_ngay_trong_tuan(ngay_bat_dau)
    ngay_ket_thuc = danh_sach_ngay[-1]
    trong_so = lay_trong_so(phien)
    if trong_so_tuy_chon:
        trong_so.update(trong_so_tuy_chon)

    nhan_vien_list = phien.query(models.NhanVien).all()
    if not nhan_vien_list:
        return KetQuaLich(False, "Không có nhân viên", None, [])

    ca_list = {ca.id: ca for ca in phien.query(models.CaLam).all()}
    nhu_cau = (
        phien.query(models.NhuCauCa)
        .filter(models.NhuCauCa.ngay >= danh_sach_ngay[0])
        .filter(models.NhuCauCa.ngay <= danh_sach_ngay[-1])
        .all()
    )
    if not nhu_cau:
        nhu_cau = tao_nhu_cau_mac_dinh(phien, ngay_bat_dau)
    nhu_cau += bo_sung_nhu_cau_bat_buoc(phien, nhu_cau, danh_sach_ngay, luu_db)

    bat_buoc_chich_ngoai = trong_so.get("bat_buoc_chich_ngoai", 1) > 0
    nhu_cau_chich_ngoai = tao_nhu_cau_chich_ngoai(phien, danh_sach_ngay) if bat_buoc_chich_ngoai else []
    nhu_cau_mo_rong = list(nhu_cau) + nhu_cau_chich_ngoai

    ngay_nghi = phien.query(models.NgayNghi).filter(models.NgayNghi.ngay.in_(danh_sach_ngay)).all()
    ngay_nghi_map = defaultdict(set)
    for nn in ngay_nghi:
        ngay_nghi_map[nn.ngay].add(nn.nhan_vien_id)

    nhu_cau_info = []
    for idx, nc in enumerate(nhu_cau_mo_rong):
        ca = ca_list.get(nc.ca_id)
        nhu_cau_info.append(
            {
                "id": idx,
                "ngay": nc.ngay,
                "chi_nhanh_id": nc.chi_nhanh_id,
                "ca_id": nc.ca_id,
                "so_nguoi_can": nc.so_nguoi_can,
                "vai_tro_yeu_cau_id": nc.vai_tro_yeu_cau_id,
                "do_quan_trong": nc.do_quan_trong or 0,
                "senior_toi_thieu": nc.senior_toi_thieu or 0,
                "la_chich_ngoai": nc in nhu_cau_chich_ngoai,
                "la_ca_muon": ca.la_ca_muon if ca else False,
                "ten_ca": ca.ten_ca if ca else "",
            }
        )

    thieu_nhu_cau = []
    for nc in nhu_cau_info:
        hop_le = 0
        for nv in nhan_vien_list:
            if nv.id in ngay_nghi_map.get(nc["ngay"], set()):
                continue
            if nc["vai_tro_yeu_cau_id"]:
                if nc["vai_tro_yeu_cau_id"] not in {vt.id for vt in nv.vai_tro}:
                    continue
            hop_le += 1
        if hop_le < nc["so_nguoi_can"]:
            thieu_nhu_cau.append(
                f"Thiếu {nc['so_nguoi_can'] - hop_le} người: {nc['ngay']} ca {nc['ten_ca']}"
            )
    if thieu_nhu_cau:
        return KetQuaLich(False, "Không đủ nhân sự", None, thieu_nhu_cau)

    mo_hinh = cp_model.CpModel()
    bien_x = {}
    chi_nhanh_theo_nv = {nv.id: {cn.id for cn in nv.chi_nhanh} for nv in nhan_vien_list}
    vai_tro_theo_nv = {nv.id: {vt.id for vt in nv.vai_tro} for nv in nhan_vien_list}
    for nv in nhan_vien_list:
        chi_nhanh_hop_le = chi_nhanh_theo_nv.get(nv.id, set())
        vai_tro_hop_le = vai_tro_theo_nv.get(nv.id, set())
        for nc in nhu_cau_info:
            if nv.id in ngay_nghi_map.get(nc["ngay"], set()):
                continue
            if nc["chi_nhanh_id"] and chi_nhanh_hop_le:
                if nc["chi_nhanh_id"] not in chi_nhanh_hop_le:
                    continue
            if nc["vai_tro_yeu_cau_id"]:
                if nc["vai_tro_yeu_cau_id"] not in vai_tro_hop_le:
                    continue
            bien_x[(nv.id, nc["id"])] = mo_hinh.NewBoolVar(f"x_{nv.id}_{nc['id']}")

    for nc in nhu_cau_info:
        bien_cho_ca = [bien_x[(nv.id, nc["id"])] for nv in nhan_vien_list if (nv.id, nc["id"]) in bien_x]
        mo_hinh.Add(sum(bien_cho_ca) == nc["so_nguoi_can"])

    for nv in nhan_vien_list:
        for ngay in danh_sach_ngay:
            bien_trong_ngay = [
                bien_x[(nv.id, nc["id"])]
                for nc in nhu_cau_info
                if nc["ngay"] == ngay and (nv.id, nc["id"]) in bien_x
            ]
            if bien_trong_ngay:
                mo_hinh.Add(sum(bien_trong_ngay) <= 1)

    for nv in nhan_vien_list:
        tong_gio = []
        for nc in nhu_cau_info:
            if (nv.id, nc["id"]) in bien_x:
                so_gio = ca_list[nc["ca_id"]].so_gio if nc["ca_id"] in ca_list else 0
                tong_gio.append(bien_x[(nv.id, nc["id"])] * so_gio)
        if tong_gio:
            mo_hinh.Add(sum(tong_gio) <= nv.gio_toi_da_tuan)

    diem = []
    uu_tien_nv_map = {}
    for nv in nhan_vien_list:
        he_so = {}
        for ts in nv.trong_so_uu_tien:
            if ts.trong_so and ts.trong_so.khoa:
                he_so[ts.trong_so.khoa] = max(1, min(ts.trong_so.gia_tri or 1, 5))
        uu_tien_nv_map[nv.id] = he_so
    for nv in nhan_vien_list:
        ca_ua_thich = {ca.id for ca in nv.ca_ua_thich}
        ca_tranh = {ca.id for ca in nv.ca_tranh}
        cap_do = (nv.cap_do or "").strip().lower()
        la_chinh = cap_do in {"senior", "bác sỹ chính", "bac sy chinh"} or "chính" in cap_do
        uu_tien_nv = nv.muc_uu_tien + (5 if la_chinh else 0)
        he_so_nv = uu_tien_nv_map.get(nv.id, {})
        for nc in nhu_cau_info:
            if (nv.id, nc["id"]) not in bien_x:
                continue
            bien = bien_x[(nv.id, nc["id"])]
            if nc["ca_id"] in ca_ua_thich:
                trong = trong_so.get("uu_tien_ca_ua_thich", 4) * he_so_nv.get("uu_tien_ca_ua_thich", 1)
                diem.append(bien * trong)
            if nc["ca_id"] in ca_tranh:
                trong = trong_so.get("phat_ca_tranh", 6) * he_so_nv.get("phat_ca_tranh", 1)
                diem.append(bien * (-trong))
            if nc["la_chich_ngoai"]:
                trong = trong_so.get("khong_di_chich_ngoai", 6) * he_so_nv.get("khong_di_chich_ngoai", 1)
                if trong > 0:
                    diem.append(bien * (-trong))
            if nc["do_quan_trong"] > 0:
                trong = trong_so.get("uu_tien_ca_quan_trong", 3) * he_so_nv.get("uu_tien_ca_quan_trong", 1)
                diem.append(bien * (uu_tien_nv * trong))

    def tao_cong_bang(ten: str, dieu_kien):
        if not any(dieu_kien(nc) for nc in nhu_cau_info):
            return
        dem_nv = {}
        for nv in nhan_vien_list:
            bien_nv = [
                bien_x[(nv.id, nc["id"])]
                for nc in nhu_cau_info
                if dieu_kien(nc) and (nv.id, nc["id"]) in bien_x
            ]
            if bien_nv:
                dem_nv[nv.id] = mo_hinh.NewIntVar(0, 7, f"dem_{ten}_{nv.id}")
                mo_hinh.Add(dem_nv[nv.id] == sum(bien_nv))
        if dem_nv:
            max_bien = mo_hinh.NewIntVar(0, 7, f"max_{ten}")
            min_bien = mo_hinh.NewIntVar(0, 7, f"min_{ten}")
            for bien in dem_nv.values():
                mo_hinh.Add(bien <= max_bien)
                mo_hinh.Add(bien >= min_bien)
            trong = trong_so.get("cong_bang_chich_ngoai" if ten == "chich" else "cong_bang_cuoi_tuan", 0)
            diem.append((max_bien - min_bien) * (-trong))

    tao_cong_bang("chich", lambda nc: nc["la_chich_ngoai"])
    tao_cong_bang("cuoi_tuan", lambda nc: nc["ngay"].weekday() >= 5)

    if trong_so.get("han_che_ca_muon_sang", 0) > 0:
        for nv in nhan_vien_list:
            he_so_nv = uu_tien_nv_map.get(nv.id, {})
            for nc_muon in nhu_cau_info:
                if not nc_muon["la_ca_muon"]:
                    continue
                if (nv.id, nc_muon["id"]) not in bien_x:
                    continue
                ngay_sau = nc_muon["ngay"] + timedelta(days=1)
                for nc_som in nhu_cau_info:
                    if nc_som["ngay"] != ngay_sau:
                        continue
                    if nc_som["ten_ca"] not in {"8h-19h", "8h30-19h30"}:
                        continue
                    if (nv.id, nc_som["id"]) not in bien_x:
                        continue
                    cap = mo_hinh.NewBoolVar(f"muon_som_{nv.id}_{nc_muon['id']}_{nc_som['id']}")
                    mo_hinh.Add(
                        cap
                        >= bien_x[(nv.id, nc_muon["id"])] + bien_x[(nv.id, nc_som["id"])] - 1
                    )
                    trong = trong_so.get("han_che_ca_muon_sang", 2) * he_so_nv.get("han_che_ca_muon_sang", 1)
                    diem.append(cap * (-trong))

    mo_hinh.Maximize(sum(diem))

    giai = cp_model.CpSolver()
    giai.parameters.max_time_in_seconds = 15
    ket_qua = giai.Solve(mo_hinh)
    if ket_qua not in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        return KetQuaLich(False, "Không tìm được lịch hợp lệ", None, [])
    diem_toi_uu = int(giai.ObjectiveValue())

    lich_tuan = None
    if luu_db:
        lich_tuan = models.LichTuan(
            ten_lich=f"Lịch tự động {ngay_bat_dau.strftime('%d/%m/%Y')}",
            ngay_bat_dau=ngay_bat_dau,
            ngay_ket_thuc=ngay_ket_thuc,
            trang_thai="DA_XEP",
        )
        phien.add(lich_tuan)
        phien.commit()
        phien.refresh(lich_tuan)

    phan_cong = []
    thu_tu_theo_o = defaultdict(int)
    for nc in nhu_cau_info:
        for nv in nhan_vien_list:
            bien = bien_x.get((nv.id, nc["id"]))
            if bien is None:
                continue
            if giai.Value(bien) == 1:
                phan_cong.append(
                    {
                        "nhan_vien_id": nv.id,
                        "ngay": nc["ngay"],
                        "chi_nhanh_id": nc["chi_nhanh_id"],
                        "ca_id": nc["ca_id"],
                        "la_chich_ngoai": nc["la_chich_ngoai"],
                        "la_ca_muon": nc["la_ca_muon"],
                        "do_quan_trong": nc["do_quan_trong"],
                    }
                )
                if luu_db and lich_tuan:
                    nhom = lay_nhom_hien_thi(phien, nc["chi_nhanh_id"], nc["ca_id"])
                    key = (nc["ngay"], nhom.id if nhom else None)
                    thu_tu_theo_o[key] += 1
                    chi_tiet = models.LichChiTiet(
                        lich_tuan_id=lich_tuan.id,
                        ngay=nc["ngay"],
                        chi_nhanh_id=nc["chi_nhanh_id"],
                        ca_id=nc["ca_id"],
                        nhan_vien_id=nv.id,
                        nhom_hien_thi_id=nhom.id if nhom else None,
                        thu_tu=thu_tu_theo_o[key],
                    )
                    phien.add(chi_tiet)
    if luu_db and lich_tuan:
        nhom_off = (
            phien.query(models.NhomHienThi)
            .filter(models.NhomHienThi.ten_nhom == "OFF")
            .first()
        )
        nhom_chua_xep = (
            phien.query(models.NhomHienThi)
            .filter(models.NhomHienThi.ten_nhom == "CHUA_XEP")
            .first()
        )
        if not nhom_chua_xep:
            nhom_chua_xep = models.NhomHienThi(ten_nhom="CHUA_XEP", mau_nen="#f4f4f4")
            phien.add(nhom_chua_xep)
            phien.flush()
        if nhom_off:
            ngay_nghi = (
                phien.query(models.NgayNghi)
                .filter(models.NgayNghi.ngay >= danh_sach_ngay[0])
                .filter(models.NgayNghi.ngay <= danh_sach_ngay[-1])
                .filter(models.NgayNghi.trang_thai == "OFF")
                .all()
            )
            da_xep = {(pc["nhan_vien_id"], pc["ngay"]) for pc in phan_cong}
            off_set = set()

            def tao_chi_tiet(ngay, nhan_vien_id, nhom_hien_thi_id, chi_nhanh_id=None, ca_id=None):
                key = (ngay, nhom_hien_thi_id)
                thu_tu_theo_o[key] += 1
                phien.add(
                    models.LichChiTiet(
                        lich_tuan_id=lich_tuan.id,
                        ngay=ngay,
                        chi_nhanh_id=chi_nhanh_id,
                        ca_id=ca_id,
                        nhan_vien_id=nhan_vien_id,
                        nhom_hien_thi_id=nhom_hien_thi_id,
                        thu_tu=thu_tu_theo_o[key],
                    )
                )

            for nn in ngay_nghi:
                key = (nn.nhan_vien_id, nn.ngay)
                if key in da_xep:
                    continue
                off_set.add(key)
                tao_chi_tiet(nn.ngay, nn.nhan_vien_id, nhom_off.id)

            for nv in nhan_vien_list:
                for ngay in danh_sach_ngay:
                    key = (nv.id, ngay)
                    if key in da_xep or key in off_set:
                        continue
                    tao_chi_tiet(ngay, nv.id, nhom_chua_xep.id)

            off_dang_ky_set = {(nn.nhan_vien_id, nn.ngay) for nn in ngay_nghi}
            if nhom_chua_xep:
                for ct in (
                    phien.query(models.LichChiTiet)
                    .filter(models.LichChiTiet.lich_tuan_id == lich_tuan.id)
                    .filter(models.LichChiTiet.nhom_hien_thi_id == nhom_off.id)
                    .all()
                ):
                    if (ct.nhan_vien_id, ct.ngay) in off_dang_ky_set:
                        continue
                    ct.nhom_hien_thi_id = nhom_chua_xep.id
                    ct.chi_nhanh_id = None
                    ct.ca_id = None
        phien.commit()

    return KetQuaLich(
        True,
        "Đã xếp lịch",
        lich_tuan.id if lich_tuan else None,
        [],
        diem_toi_uu=diem_toi_uu,
        tong_phan_cong=len(phan_cong),
        phan_cong=phan_cong,
    )


def tao_lich_tu_xep_tuan(
    phien: Session,
    ngay_bat_dau: date,
    luu_db: bool = True,
) -> KetQuaLich:
    ngay_bat_dau = ngay_bat_dau - timedelta(days=ngay_bat_dau.weekday())
    danh_sach_ngay = danh_sach_ngay_trong_tuan(ngay_bat_dau)
    ngay_ket_thuc = danh_sach_ngay[-1]
    nhan_vien_list = phien.query(models.NhanVien).order_by(models.NhanVien.ten_nv.asc(), models.NhanVien.id.asc()).all()
    if not nhan_vien_list:
        return KetQuaLich(False, "Không có nhân viên", None, [])

    if not luu_db:
        return KetQuaLich(True, "Đã tạo lịch tự xếp", None, [], tong_phan_cong=0, phan_cong=[])

    nhom_off = phien.query(models.NhomHienThi).filter(models.NhomHienThi.ten_nhom == "OFF").first()
    if not nhom_off:
        nhom_off = models.NhomHienThi(ten_nhom="OFF", mau_nen="#e6e6e6")
        phien.add(nhom_off)
        phien.flush()

    nhom_chua_xep = (
        phien.query(models.NhomHienThi)
        .filter(models.NhomHienThi.ten_nhom == "CHUA_XEP")
        .first()
    )
    if not nhom_chua_xep:
        nhom_chua_xep = models.NhomHienThi(ten_nhom="CHUA_XEP", mau_nen="#f4f4f4")
        phien.add(nhom_chua_xep)
        phien.flush()

    lich_tuan = models.LichTuan(
        ten_lich=f"Tự xếp {ngay_bat_dau.strftime('%d/%m/%Y')}",
        ngay_bat_dau=ngay_bat_dau,
        ngay_ket_thuc=ngay_ket_thuc,
        trang_thai="TU_XEP",
    )
    phien.add(lich_tuan)
    phien.flush()

    ngay_nghi = (
        phien.query(models.NgayNghi)
        .filter(models.NgayNghi.ngay >= danh_sach_ngay[0])
        .filter(models.NgayNghi.ngay <= danh_sach_ngay[-1])
        .filter(models.NgayNghi.trang_thai == "OFF")
        .all()
    )
    dang_ky_off_set = {(nn.nhan_vien_id, nn.ngay) for nn in ngay_nghi}

    thu_tu_theo_o = defaultdict(int)
    tong_dong = 0
    for ngay in danh_sach_ngay:
        for nv in nhan_vien_list:
            nhom_id = nhom_off.id if (nv.id, ngay) in dang_ky_off_set else nhom_chua_xep.id
            key = (ngay, nhom_id)
            thu_tu_theo_o[key] += 1
            phien.add(
                models.LichChiTiet(
                    lich_tuan_id=lich_tuan.id,
                    ngay=ngay,
                    chi_nhanh_id=None,
                    ca_id=None,
                    nhan_vien_id=nv.id,
                    nhom_hien_thi_id=nhom_id,
                    thu_tu=thu_tu_theo_o[key],
                )
            )
            tong_dong += 1

    phien.commit()
    return KetQuaLich(
        True,
        "Đã tạo lịch tự xếp",
        lich_tuan.id,
        [],
        tong_phan_cong=tong_dong,
        phan_cong=[],
    )
