#!/usr/bin/env bash

options=(
  "󰍁"
  ""
  "󰗽"
  "󰜉"
  "󰐥"
)

rofi_cmd() {
  rofi -dmenu \
    -p "Goodbye ${USER}" \
    -mesg "Uptime:$(uptime | tr "," " " | cut -f6-8 -d" ")" \
    -no-click-to-exit \
    -theme @theme@
}

chosen=$(printf "%s\n" "${options[@]}" | rofi_cmd)

case $chosen in
"󰐥")
  systemctl poweroff
  ;;
"󰜉")
  systemctl reboot
  ;;
"󰍁")
  ScreenLocker
  ;;
"")
  mpc -q pause
  amixer set Master mute
  systemctl suspend
  ;;
"󰗽")
  bspc quit
  ;;
esac
