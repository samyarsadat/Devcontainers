#!/usr/bin/env bash
set -Eeuo pipefail

# shellcheck source=/dev/null
. /usr/local/lib/dev-environments/feature-lib.sh

install -d -m 0755 .vscode
install -m 0644 "$FEATURE_SHARE"/pico/vscode/* .vscode/

echo "VS Code configuration copied!"
