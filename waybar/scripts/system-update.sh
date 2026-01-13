#!/usr/bin/env bash
#
# Keep the system in sync with NixOS. When run with the "module" argument, emit
# a JSON status payload for Waybar. When run without arguments (e.g. on click),
# rebuild the system from the configured flake.
#
# Environment overrides:
#   NIXOS_FLAKE_PATH  - flake path (default: /etc/nixos)
#   NIXOS_HOSTNAME    - flake output name (default: $(hostname -s))
#   NIXOS_FLAKE_REF   - full flake ref (overrides the two vars above)
#   NIXOS_REBUILD_CMD - nixos-rebuild binary to use (default: nixos-rebuild)
#   NIXOS_UPGRADE     - set to 1 to pass --upgrade on rebuild

set -euo pipefail

GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[39m"

FLAKE_PATH="${NIXOS_FLAKE_PATH:-/etc/nixos}"
HOST_PART="${NIXOS_HOSTNAME:-$(hostname -s)}"
FLAKE_REF="${NIXOS_FLAKE_REF:-${FLAKE_PATH}#${HOST_PART}}"
REBUILD_CMD="${NIXOS_REBUILD_CMD:-nixos-rebuild}"
UPGRADE_FLAG=()
if [[ ${NIXOS_UPGRADE:-0} -eq 1 ]]; then
	UPGRADE_FLAG=(--upgrade)
fi

have_nixos() {
	command -v "$REBUILD_CMD" >/dev/null 2>&1
}

generation_from_link() {
	local link="$1"
	if [[ -L $link ]]; then
		local target
		target=$(readlink -f "$link")
		if [[ $target =~ system-([0-9]+)-link ]]; then
			echo "${BASH_REMATCH[1]}"
		fi
	fi
}

needs_reboot() {
	local booted current
	booted=$(readlink -f /run/booted-system 2>/dev/null || true)
	current=$(readlink -f /run/current-system 2>/dev/null || true)
	[[ -n $booted && -n $current && $booted != "$current" ]]
}

notify() {
	if command -v notify-send >/dev/null 2>&1; then
		notify-send "$@"
	fi
}

display_module() {
	if ! have_nixos; then
		echo '{ "text": "󰒑", "tooltip": "NixOS not detected. Set NIXOS_FLAKE_REF in scripts/system-update.sh." }'
		return
	fi

	local current_gen booted_gen tooltip icon
	current_gen=$(generation_from_link /nix/var/nix/profiles/system || true)
	booted_gen=$(generation_from_link /run/booted-system || true)

	if needs_reboot; then
		icon="󰜉"
		tooltip="<b>NixOS</b>: reboot to finish update"
	else
		icon="󰣇"
		tooltip="<b>NixOS</b>: in sync"
	fi

	if [[ -n $current_gen ]]; then
		tooltip+="\n<b>Generation</b>: $current_gen"
	fi

	if [[ -n $booted_gen && $booted_gen != "$current_gen" ]]; then
		tooltip+="\n<b>Booted</b>: $booted_gen"
	fi

	tooltip+="\n<b>Flake</b>: $FLAKE_REF"

	echo "{ \"text\": \"$icon\", \"tooltip\": \"$tooltip\" }"
}

rebuild_system() {
	if ! have_nixos; then
		echo "nixos-rebuild not found. Set NIXOS_REBUILD_CMD or ensure NixOS is installed."
		return 1
	fi

	printf "\n%bRebuilding NixOS from %s...%b\n" "$BLUE" "$FLAKE_REF" "$RESET"
	sudo "$REBUILD_CMD" switch --flake "$FLAKE_REF" "${UPGRADE_FLAG[@]}"

	notify "NixOS rebuild complete" "Flake: $FLAKE_REF"
	printf "\n%bRebuild complete!%b\n" "$GREEN" "$RESET"

	# Refresh the Waybar module.
	pkill -RTMIN+1 waybar 2>/dev/null || true
}

main() {
	case ${1:-module} in
		module)
			display_module
			;;
		*)
			rebuild_system
			;;
	esac
}

main "$@"
