#!/bin/sh
# Dev entrypoint: runs on every container start (incl. after a branch switch
# on the host), so node_modules always match whatever package.json/lockfile
# the mounted submodule currently has checked out. node_modules itself lives
# in a named volume (never the host bind mount), so native deps (e.g. bcrypt)
# stay Linux-built and switching branches on macOS/Windows never corrupts them.
set -e

echo "[dev-entrypoint] syncing dependencies with pnpm..."
pnpm install

exec "$@"
