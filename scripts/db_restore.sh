#!/usr/bin/env bash
set -euo pipefail

INPUT_PATH=${1:-"./lich_dump.sql"}
CONTAINER_NAME=${2:-"zzcodeproject-db-1"}
DB_NAME=${3:-"lich_lam_viec"}
DB_USER=${4:-"lich_user"}

if [ ! -f "$INPUT_PATH" ]; then
  echo "Dump file not found: $INPUT_PATH"
  exit 1
fi

docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" < "$INPUT_PATH"
echo "Restored dump from $INPUT_PATH"
