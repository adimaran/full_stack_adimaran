#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
API_ENV_EXAMPLE="$ROOT_DIR/apps/api/.env.example"
API_ENV_TARGET="$ROOT_DIR/apps/api/.env"
WEB_ENV_EXAMPLE="$ROOT_DIR/apps/web/.env.example"
WEB_ENV_TARGET="$ROOT_DIR/apps/web/.env.local"

copy_if_missing() {
  local source_file="$1"
  local target_file="$2"

  if [[ -f "$target_file" ]]; then
    echo "Skipping $target_file (already exists)."
    return
  fi

  cp "$source_file" "$target_file"
  echo "Created $target_file from template."
}

echo "==> Installing workspace dependencies"
npm install

echo "==> Preparing local environment files"
copy_if_missing "$API_ENV_EXAMPLE" "$API_ENV_TARGET"
copy_if_missing "$WEB_ENV_EXAMPLE" "$WEB_ENV_TARGET"

echo ""
echo "Setup complete. Next steps:"
echo "1) Fill in apps/api/.env with your Supabase values"
echo "2) Optionally edit apps/web/.env.local"
echo "3) Run npm run dev"
