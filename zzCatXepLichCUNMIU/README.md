# Lich lam viec theo tuan

Ung dung web xep lich lam viec nhan vien theo tuan, co giao dien Studio va xuat Excel.

## Chay nhanh bang Docker

```bash
docker compose up -d --build
```

Mo trinh duyet tai: `http://localhost:8000`

Luu y: trong `docker-compose.yml` hien tai, web map `8001:8000`, vi vay truy cap `http://localhost:8001`.

## Luu y WSL (Linux tren Windows)

- Bat Docker Desktop va WSL integration cho distro dang dung.
- Neu port 8000 dang bi chiem, dung container hoac doi port trong `docker-compose.yml`.

## Deploy sang may Windows khac (giu nguyen DB hien tai)

### 1) Tren may nguon (dang chay du an)

```bash
mkdir -p backups
docker compose exec -T db pg_dump --clean --if-exists -U lich_user -d lich_lam_viec > backups/lich_dump.sql
gzip -f backups/lich_dump.sql
```

Copy file `backups/lich_dump.sql.gz` sang may Windows dich.

### 2) Tren may Windows dich

- Cai `Git for Windows` va `Docker Desktop`.
- Clone repo va vao dung thu muc du an.

```powershell
git clone https://github.com/zzronnpower/WebXepLich.git
cd WebXepLich\zzCatXepLichCUNMIU
```

Chay script all-in-one (build + restore):

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows_setup_and_restore.ps1 -DumpPath .\backups\lich_dump.sql.gz
```

Mo app tai: `http://localhost:8001`

Kiem tra port 8000:

```bash
sudo lsof -iTCP:8000 -sTCP:LISTEN
```

## Chay nhanh bang Makefile

```bash
make docker-up
```

Xem log:

```bash
make docker-logs
```

Reset DB (xoa volume docker):

```bash
make db-reset
```

## Chay local (khong Docker)

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
export CO_SO_DU_LIEU_URL="postgresql+psycopg2://lich_user:lich_pass@localhost:5432/lich_lam_viec"
uvicorn backend.app.main:ung_dung --host 0.0.0.0 --port 8000 --reload
```

Tham khao `.env.example` de copy bien moi truong.

## Chuc nang chinh

- Quan ly Nhan vien, Ngay nghi, Nhu cau ca, Trong so uu tien
- Bam **XEP LICH** de tao lich tuan 7 ngay
- Xem bang lich theo template va tai Excel

## Seed du lieu mau

He thong tu dong tao du lieu mau khi khoi dong lan dau:

- 10 nhan vien
- Nhu cau ca cho 1 tuan
- Nhung ca co san theo chi nhanh

## Ghi chu

- Bien moi truong `CO_SO_DU_LIEU_URL` duoc khai bao trong `docker-compose.yml`
- File Excel tai xuong co ten `OUTPUT_Lich_Lam_Viec.xlsx`

## Van hanh production (Phase 3)

- Healthcheck endpoint: `GET /healthz`
- Readiness endpoint: `GET /readyz` (kiem tra DB query `SELECT 1`)
- Runtime metrics endpoint: `GET /metrics`
  - tra ve tong hop metric HTTP (count/error/avg_ms/max_ms)
  - tra ve metric solver (`xep_lich`, `tu_xep_lich`)
- Prometheus text metrics: `GET /metrics/prometheus`
- Request ID middleware:
  - nhan `x-request-id` neu client gui len, neu khong se auto tao
  - response se co header `X-Request-ID`
- Guard endpoint nguy hiem:
  - tat ca route `POST` co duong dan chua `/xoa` se yeu cau `ADMIN_TOKEN`
  - neu set env `ADMIN_TOKEN`, request phai gui dung token qua `x-admin-token` hoac `admin_token` query

### Chay job xep lich nen (khong block request)

- Tao job:
  - `POST /api/jobs/xep-lich`
  - payload JSON: `{ "flow": "xep_lich" | "tu_xep_lich", "ngay_bat_dau": "YYYY-MM-DD" }`
- Theo doi job:
  - `GET /api/jobs/{job_id}`
  - tra ve trang thai `queued|running|done|failed`, message va `lich_tuan_id` neu thanh cong

### Checklist backup/restore dinh ky

1. Dump DB:
   - `docker compose exec -T db pg_dump --clean --if-exists -U lich_user -d lich_lam_viec > backups/lich_dump_$(date +%Y%m%d_%H%M%S).sql`
2. Nen dump:
   - `gzip -f backups/lich_dump_*.sql`
3. Kiem tra file backup co tao thanh cong va co kich thuoc > 0
4. Thu restore tren moi truong test (hoac may clone) it nhat 1 lan/tuần

Co the dung script san co:

```bash
./scripts/ops_backup_verify.sh
```
