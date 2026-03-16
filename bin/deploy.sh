#!/usr/bin/env bash
set -euo pipefail

APP_NAME="whimsy"
SRC_DIR="/home/deploy/whimsy-src"
RELEASE_DIR="/home/deploy/whimsy"
ENV_FILE="/etc/whimsy/env"

echo "==> Pulling latest code..."
cd "$SRC_DIR"
git pull

echo "==> Fetching dependencies..."
MIX_ENV=prod mix deps.get --only prod

echo "==> Compiling..."
MIX_ENV=prod mix compile

echo "==> Building assets..."
MIX_ENV=prod mix assets.deploy

echo "==> Building release..."
MIX_ENV=prod mix release --overwrite

echo "==> Copying release..."
rm -rf "$RELEASE_DIR"
mkdir -p "$RELEASE_DIR"
cp -r "$SRC_DIR/_build/prod/rel/$APP_NAME"/* "$RELEASE_DIR"/

echo "==> Loading environment..."
set -a
source "$ENV_FILE"
set +a

echo "==> Running migrations..."
"$RELEASE_DIR/bin/$APP_NAME" eval "Whimsy.Release.migrate"

echo "==> Restarting service..."
sudo systemctl restart "$APP_NAME"

echo "==> Done! Checking status..."
sudo systemctl status "$APP_NAME" --no-pager
