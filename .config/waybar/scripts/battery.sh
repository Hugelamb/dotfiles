#!/bin/sh

battLevelIcons=("  " "  " "  " "  " "  ")

get_batt_status () {
  status=$(cat /sys/class/power_supply/BAT1/status)
  echo $status
}

fmt_charging () {
  # return format for charging battery animation
  fmt=""
  echo $fmt
}

refresh() {
   
}

