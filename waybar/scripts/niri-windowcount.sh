#!/usr/bin/env bash

set -euo pipefail

windows_json="$(niri msg -j windows 2>/dev/null || true)"

if [[ -z "$windows_json" ]]; then
  echo ""
  exit 0
fi

printf '%s\n' "$windows_json" | python3 - <<'PY'
import json
import sys

try:
    windows = json.load(sys.stdin)
except Exception:
    print("")
    sys.exit(0)

def workspace_id(win):
    for key in ("workspace", "workspace-id", "workspace_id"):
        if key in win:
            val = win[key]
            if isinstance(val, dict):
                for sub in ("id", "workspace-id", "workspace", "index", "idx"):
                    if sub in val:
                        return val[sub]
            else:
                return val
    for key in ("workspace-name", "workspace_name", "name"):
        if key in win:
            return win[key]
    return None

focused_ws = None
for win in windows:
    if win.get("focused") or win.get("is-focused") or win.get("active"):
        focused_ws = workspace_id(win) or win.get("workspace-name") or win.get("workspace_name") or win.get("workspace")
        break

if focused_ws is None and windows:
    focused_ws = workspace_id(windows[0])

if focused_ws is None:
    print(len(windows))
else:
    count = sum(1 for win in windows if workspace_id(win) == focused_ws)
    print(count)
PY
