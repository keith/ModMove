#!/usr/bin/env bash

set -euo pipefail

app_name="ModMove"
app_path="/Applications/${app_name}.app"
backup_path="/tmp/${app_name}.app.bak"

if [ ! -d "${backup_path}" ]; then
  echo "error: no backup found at ${backup_path}" >&2
  exit 1
fi

echo "Killing running ${app_name}..."
killall "${app_name}" 2>/dev/null || true

echo "Restoring backup from ${backup_path}..."
rm -rf "${app_path}"
mv "${backup_path}" "${app_path}"

echo "Launching ${app_name}..."
open "${app_path}"

echo "Done. Reverted to previous version."
