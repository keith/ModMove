#!/usr/bin/env bash

set -euo pipefail

proj_dir="$(cd "$(dirname "$0")" && pwd)"
app_name="ModMove"
app_path="/Applications/${app_name}.app"
backup_path="/tmp/${app_name}.app.bak"
build_dir="${proj_dir}/DerivedData"

echo "Building ${app_name}..."
xcodebuild -project "${proj_dir}/${app_name}.xcodeproj" \
  -scheme "${app_name}" \
  -configuration Release \
  -derivedDataPath "${build_dir}" \
  -quiet

built_app="${build_dir}/Build/Products/Release/${app_name}.app"
if [ ! -d "${built_app}" ]; then
  echo "error: build product not found at ${built_app}" >&2
  exit 1
fi

echo "Killing running ${app_name}..."
killall "${app_name}" 2>/dev/null || true

echo "Backing up ${app_path} to ${backup_path}..."
rm -rf "${backup_path}"
if [ -d "${app_path}" ]; then
  mv "${app_path}" "${backup_path}"
fi

echo "Installing new build to ${app_path}..."
mv "${built_app}" "${app_path}"

echo "Launching ${app_name}..."
open "${app_path}"

echo "Done. Backup at ${backup_path}"
