set -euo pipefail

WALL_DIR="$HOME/Pictures"
THUMB_DIR="$HOME/.cache/wallpick/thumbs"
SIZE=256

mkdir -p "$THUMB_DIR"

entries=()

while IFS= read -r img; do
  base="$(basename "$img")"
  thumb="$THUMB_DIR/$base.png"

  # Generate thumbnail once
  if [[ ! -f "$thumb" ]]; then
    magick "$img" -resize ${SIZE}x${SIZE}^ -gravity center -extent ${SIZE}x${SIZE} "$thumb"
  fi

  entries+=("$base"$'\0'"icon"$'\x1f'"$thumb"$'\0'"info"$'\x1f'"$img")
done < <(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

choice="$(printf '%s\n' "${entries[@]}" | rofi -dmenu -i -show-icons -p "Wallpaper")"
[[ -n "$choice" ]] || exit 0

wall="$WALL_DIR/$choice"

# Apply wallpaper + theme
swww img "$wall" --transition-type any --transition-duration 0.6
wal -i "$wall" -n
kitty @ --to unix:/tmp/kitty-wal set-colors --all --configured ~/.cache/wal/colors-kitty.conf
