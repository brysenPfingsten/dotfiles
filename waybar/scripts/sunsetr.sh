#!/usr/bin/env bash

set -euo pipefail

sunsetr_bin="sunsetr"

if ! command -v "$sunsetr_bin" >/dev/null 2>&1; then
  printf '{"text":"?","class":["missing"]}\n'
  exit 0
fi

status_out="$("$sunsetr_bin" status 2>&1 || true)"

status_is_on() {
  grep -Eiq 'running|active|enabled|on|started' <<<"$status_out"
}

if [[ ${1:-} == "toggle" ]]; then
  if status_is_on; then
    "$sunsetr_bin" stop >/dev/null 2>&1 || true
  else
    "$sunsetr_bin" >/dev/null 2>&1 || true
  fi
  status_out="$("$sunsetr_bin" status 2>&1 || true)"
fi

if status_is_on; then
  icon="󰖨" # sun
  class="on"
else
  icon="󰽤" # moon
  class="off"
fi

printf '{"text":"%s","class":["%s"]}\n' "$icon" "$class"
