#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="${ROOT_DIR}/backups"
STAMP="$(date +%Y%m%d_%H%M%S)"
SQL_FILE="${BACKUP_DIR}/lich_dump_${STAMP}.sql"
GZ_FILE="${SQL_FILE}.gz"

mkdir -p "${BACKUP_DIR}"

echo "[1/4] Creating database dump..."
docker compose -f "${ROOT_DIR}/docker-compose.yml" exec -T db \
  pg_dump --clean --if-exists -U lich_user -d lich_lam_viec > "${SQL_FILE}"

echo "[2/4] Compressing dump..."
gzip -f "${SQL_FILE}"

echo "[3/4] Verifying gzip archive..."
gzip -t "${GZ_FILE}"

echo "[4/4] Calculating checksum..."
sha256sum "${GZ_FILE}"

echo "Backup completed: ${GZ_FILE}"
