#!/usr/bin/env bash

get_tmux_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo $default_value
  else
    echo $option_value
  fi
}

# normalize the percentage string to always have a length of 5
normalize_percent_len() {
  # the max length that the percent can reach, which happens for a two digit number with a decimal house: "99.9%"
  max_len=5
  percent_len=${#1}
  let diff_len=$max_len-$percent_len
  # if the diff_len is even, left will have 1 more space than right
  let left_spaces=($diff_len+1)/2
  let right_spaces=($diff_len)/2
  printf "%${left_spaces}s%s%${right_spaces}s\n" "" $1 ""
}

normalize_string_right() {
    local input="$1"
    local max_length="$2"

    # Calculate the length of padding needed
    local padding=$((max_length - ${#input}))

    # Check if padding is needed
    if [ "$padding" -gt 0 ]; then
        # Pad with spaces at the end
        local padded_string="${input}$(printf "%${padding}s")"
        echo "$padded_string"
    else
        # If input is already longer than or equal to max_length, return as is
        echo "$input"
    fi
}

normalize_string_left() {
    local input="$1"
    local max_length="$2"

    # Calculate the length of padding needed
    local padding=$((max_length - ${#input}))

    # Check if padding is needed
    if [ "$padding" -gt 0 ]; then
        # Prepend spaces to the left
        local padded_string="$(printf "%${padding}s")${input}"
        echo "$padded_string"
    else
        # If input is already longer than or equal to max_length, return as is
        echo "$input"
    fi
}
