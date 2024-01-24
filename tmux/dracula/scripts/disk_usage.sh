#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $current_dir/utils.sh

get_usage()
{
 used_over_available=$(df -hB 1G --output=avail,size / | awk 'NR==2 {print $1 "GB/"$2 "GB"}')
 echo $used_over_available left
}

main()
{
  # storing the refresh rate in the variable RATE, default is 5
  RATE=$(get_tmux_option "@dracula-refresh-rate" 5)
  disk_label=$(get_tmux_option "@dracula-disk-usage-label" "DISK")
  disk_usage=$(get_usage)
  echo "$disk_label $disk_usage"
  sleep $RATE
}

#run main driver
main
