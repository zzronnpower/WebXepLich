from __future__ import annotations

from dataclasses import dataclass, field
from datetime import datetime
import threading
import uuid

from backend.app.db import PhienLamViec
from backend.app.services.schedule_service import chay_tu_xep_tuan, chay_xep_lich_tuan


@dataclass
class JobState:
    job_id: str
    flow: str
    ngay_bat_dau: str
    status: str = "queued"
    message: str = ""
    created_at: str = field(default_factory=lambda: datetime.utcnow().isoformat())
    started_at: str | None = None
    finished_at: str | None = None
    lich_tuan_id: int | None = None
    success: bool | None = None


_job_lock = threading.Lock()
_jobs: dict[str, JobState] = {}


def tao_job_xep_lich(flow: str, ngay_bat_dau_iso: str) -> JobState:
    flow_chuan = str(flow or "xep_lich").strip().lower()
    if flow_chuan not in {"xep_lich", "tu_xep_lich"}:
        raise ValueError("flow khong hop le")

    job = JobState(
        job_id=f"job-{uuid.uuid4().hex[:12]}",
        flow=flow_chuan,
        ngay_bat_dau=ngay_bat_dau_iso,
    )
    with _job_lock:
        _jobs[job.job_id] = job

    worker = threading.Thread(target=_chay_job, args=(job.job_id,), daemon=True)
    worker.start()
    return job


def lay_job(job_id: str) -> JobState | None:
    with _job_lock:
        return _jobs.get(job_id)


def _chay_job(job_id: str) -> None:
    with _job_lock:
        job = _jobs.get(job_id)
        if not job:
            return
        job.status = "running"
        job.started_at = datetime.utcnow().isoformat()

    phien = PhienLamViec()
    try:
        ngay = datetime.fromisoformat(job.ngay_bat_dau).date()
        if job.flow == "tu_xep_lich":
            ket_qua, _ = chay_tu_xep_tuan(phien, ngay)
        else:
            ket_qua, _ = chay_xep_lich_tuan(phien, ngay)
        with _job_lock:
            job.success = bool(getattr(ket_qua, "thanh_cong", False))
            job.lich_tuan_id = getattr(ket_qua, "lich_tuan_id", None)
            job.message = str(getattr(ket_qua, "thong_bao", ""))
            job.status = "done" if job.success else "failed"
    except Exception as exc:
        with _job_lock:
            job.status = "failed"
            job.success = False
            job.message = str(exc)
    finally:
        with _job_lock:
            job.finished_at = datetime.utcnow().isoformat()
        phien.close()
