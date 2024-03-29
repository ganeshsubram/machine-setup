#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $current_dir/utils.sh

get_gpu_platforms() {
  case $(uname -s) in
  Linux)
    gpu_platforms=$(lspci -v | grep VGA | head -n 5 | awk '{print $5}')
    echo "${gpu_platforms}"
    ;;

  Darwin)
    # TODO - Darwin/Mac compatability
    ;;

  CYGWIN* | MINGW32* | MSYS* | MINGW*)
    # TODO - windows compatability
    ;;
  esac
}

get_gpu_usages() {
  gpu_platforms=($(get_gpu_platforms))
  for platform in "${gpu_platforms[@]}"; do
    :
    echo "GPU(${platform})"
    if [[ "$platform" == Intel ]]; then
      usage=$( (timeout -s SIGKILL 1.1 sudo intel_gpu_top -o -) | sed '4q;d' | awk '{printf("%.2f%%%", $7)}')
      usage=$(normalize_string_left "$usage" 7) # 100.00% == 7 places
      echo "$usage"
    elif [[ "$platform" == NVIDIA ]]; then
      usage=$(nvidia-smi | grep '%' | awk '{ print $13 }')
      usage=$(normalize_string_left "$usage" 3) # 100% == 3 places

      power=$(nvidia-smi | grep '%' | awk '{ print $5 }')
      power=$(normalize_string_right "$power" 4) # 100W == 4 places
      echo "${usage} ${power} "
    else
      usage='unknown'
    fi
    echo "|"
  done
}

main() {
  # storing the refresh rate in the variable RATE, default is 5
  RATE=$(get_tmux_option "@dracula-refresh-rate" 5)
  gpu_label=$(get_gpu_usages | tr '\n' ' ')
  gpu_label=${gpu_label::-4} # remove trailing '  |'
  echo "${gpu_label}"
  sleep $RATE
}

# run the main driver
main
