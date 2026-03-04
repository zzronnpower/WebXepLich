from __future__ import annotations

from datetime import date, timedelta
import logging
import threading
import time
from typing import Any

from sqlalchemy.orm import Session

from backend.app import models
from backend.app.scheduler.solver import giai_lich_tuan, tao_lich_tu_xep_tuan


logger = logging.getLogger("xeplich.schedule")
_metric_lock = threading.Lock()
_metric_xep_lich = {
    "xep_lich": {"count": 0, "success": 0, "failed": 0, "sum_ms": 0.0, "max_ms": 0.0},
    "tu_xep_lich": {"count": 0, "success": 0, "failed": 0, "sum_ms": 0.0, "max_ms": 0.0},
}


def chuan_hoa_thu_hai(ngay_bat_dau: date) -> date:
    return ngay_bat_dau - timedelta(days=ngay_bat_dau.weekday())


def chay_xep_lich_tuan(phien: Session, ngay_bat_dau: date) -> tuple[Any, date]:
    ngay_bat_dau = chuan_hoa_thu_hai(ngay_bat_dau)
    bat_dau = time.perf_counter()
    ket_qua = giai_lich_tuan(phien, ngay_bat_dau)
    _cap_nhat_trang_thai_nhap(phien, ket_qua, "DA_XEP")
    thoi_gian_ms = round((time.perf_counter() - bat_dau) * 1000.0, 2)
    _ghi_nhan_metric("xep_lich", bool(getattr(ket_qua, "thanh_cong", False)), thoi_gian_ms)
    logger.info(
        "solver_run flow=xep_lich success=%s duration_ms=%s lich_tuan_id=%s",
        bool(getattr(ket_qua, "thanh_cong", False)),
        thoi_gian_ms,
        getattr(ket_qua, "lich_tuan_id", None),
    )
    return ket_qua, ngay_bat_dau


def chay_tu_xep_tuan(phien: Session, ngay_bat_dau: date) -> tuple[Any, date]:
    ngay_bat_dau = chuan_hoa_thu_hai(ngay_bat_dau)
    bat_dau = time.perf_counter()
    ket_qua = tao_lich_tu_xep_tuan(phien, ngay_bat_dau)
    _cap_nhat_trang_thai_nhap(phien, ket_qua, "TU_XEP")
    thoi_gian_ms = round((time.perf_counter() - bat_dau) * 1000.0, 2)
    _ghi_nhan_metric("tu_xep_lich", bool(getattr(ket_qua, "thanh_cong", False)), thoi_gian_ms)
    logger.info(
        "solver_run flow=tu_xep_lich success=%s duration_ms=%s lich_tuan_id=%s",
        bool(getattr(ket_qua, "thanh_cong", False)),
        thoi_gian_ms,
        getattr(ket_qua, "lich_tuan_id", None),
    )
    return ket_qua, ngay_bat_dau


def lay_thong_ke_xep_lich() -> dict[str, dict[str, float | int]]:
    with _metric_lock:
        out: dict[str, dict[str, float | int]] = {}
        for key, value in _metric_xep_lich.items():
            count = int(value.get("count", 0))
            avg_ms = round(float(value.get("sum_ms", 0.0)) / count, 2) if count else 0.0
            out[key] = {
                "count": count,
                "success": int(value.get("success", 0)),
                "failed": int(value.get("failed", 0)),
                "avg_ms": avg_ms,
                "max_ms": round(float(value.get("max_ms", 0.0)), 2),
            }
        return out


def _ghi_nhan_metric(flow: str, thanh_cong: bool, thoi_gian_ms: float) -> None:
    with _metric_lock:
        item = _metric_xep_lich.get(flow)
        if item is None:
            return
        item["count"] = int(item.get("count", 0)) + 1
        item["sum_ms"] = float(item.get("sum_ms", 0.0)) + thoi_gian_ms
        item["max_ms"] = max(float(item.get("max_ms", 0.0)), thoi_gian_ms)
        if thanh_cong:
            item["success"] = int(item.get("success", 0)) + 1
        else:
            item["failed"] = int(item.get("failed", 0)) + 1


def _cap_nhat_trang_thai_nhap(phien: Session, ket_qua: Any, trang_thai: str) -> None:
    lich_tuan_id = getattr(ket_qua, "lich_tuan_id", None)
    thanh_cong = bool(getattr(ket_qua, "thanh_cong", False))
    if not thanh_cong or not lich_tuan_id:
        return
    lich = phien.query(models.LichTuan).filter(models.LichTuan.id == lich_tuan_id).first()
    if not lich:
        return
    lich.trang_thai = f"NHAP_{trang_thai}"
    phien.commit()
