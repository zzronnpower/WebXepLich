# Lich lam viec theo tuan

Ung dung web xep lich lam viec nhan vien theo tuan, co giao dien Studio va xuat Excel.

## Chay nhanh bang Docker

```bash
docker compose up -d --build
```

Mo trinh duyet tai: `http://localhost:8000`

## Luu y WSL (Linux tren Windows)

- Bat Docker Desktop va WSL integration cho distro dang dung.
- Neu port 8000 dang bi chiem, dung container hoac doi port trong `docker-compose.yml`.

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
