#!/usr/bin/env bash
# =========================================================================
# Digital Twin System Architecture - Environment & Directory Setup Script
# Target OS: Ubuntu Linux
# =========================================================================

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"

echo "================================================================="
echo " Setting up Digital Twin Architecture in: $PROJECT_ROOT"
echo "================================================================="

# 1. Create directory structure for persistent volume bindings
echo "[1/4] Creating volume sub-folders..."
mkdir -p ./volumes/ignition
mkdir -p ./volumes/highbyte
mkdir -p ./volumes/basyx/aas-server
mkdir -p ./volumes/basyx/aas-gui
mkdir -p ./volumes/minio/data
mkdir -p ./volumes/minio/config

# 2. Set directory permissions (Read/Write access for Docker container UIDs)
echo "[2/4] Setting folder permissions for container volume mounts..."
chmod -R 777 ./volumes

# 3. Environment configuration validation
echo "[3/4] Checking environment configuration (.env)..."
if [ ! -f .env ]; then
  if [ -f .env.example ]; then
    cp .env.example .env
    echo "  -> Created .env from .env.example template."
  fi
else
  echo "  -> .env file verified."
fi

# 4. Check for HighByte image or build fallback
echo "[4/4] Checking HighByte image status..."
if ! docker image inspect highbyte:latest >/dev/null 2>&1 && ! docker image inspect highbyte:3.4.0 >/dev/null 2>&1; then
  echo "  -> Note: HighByte official tarball not loaded. Local fallback image will be built on 'docker compose up -d'."
  echo "  -> To load official HighByte image later, run: docker load -i HighByte-Intelligence-Hub-*.tar"
fi

echo "================================================================="
echo " Setup Complete!"
echo " To launch the stack, execute:"
echo "   docker compose up -d"
echo "================================================================="
