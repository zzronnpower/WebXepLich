#!/usr/bin/env bash
set -euo pipefail

OUTPUT_PATH=${1:-"./lich_dump.sql"}
CONTAINER_NAME=${2:-"zzcodeproject-db-1"}
DB_NAME=${3:-"lich_lam_viec"}
DB_USER=${4:-"lich_user"}

docker exec -i "$CONTAINER_NAME" pg_dump -U "$DB_USER" -d "$DB_NAME" > "$OUTPUT_PATH"
echo "Saved dump to $OUTPUT_PATH"
