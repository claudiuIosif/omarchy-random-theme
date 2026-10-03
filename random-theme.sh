#!/usr/bin/env bash
# Apply a random Omarchy theme. Theme names contain spaces and punctuation,
# so candidates are read into an array and each is passed as one argument.
# Loops until it lands on something other than the theme already active.

current="$(omarchy theme current 2>/dev/null)"

mapfile -t themes < <(omarchy theme list 2>/dev/null)

if [ "${#themes[@]}" -eq 0 ]; then
  notify-send "Random Theme" "No themes found"
  exit 1
fi

if [ "${#themes[@]}" -eq 1 ]; then
  omarchy theme set "${themes[0]}"
  omarchy-notification-send "" "<b>${themes[0]}</b> applied."
  exit 0
fi

for _ in $(seq 1 20); do
  pick="${themes[RANDOM % ${#themes[@]}]}"
  if [ "$pick" != "$current" ]; then
    omarchy theme set "$pick"
    omarchy-notification-send "" "<b>$pick</b> applied."
    exit 0
  fi
done

omarchy theme set "$current"