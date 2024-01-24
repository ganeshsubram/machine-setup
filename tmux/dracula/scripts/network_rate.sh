#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source $current_dir/utils.sh

interface="eth0"

# Set the path to the cache file in the /tmp directory
cache_file="/tmp/network_stats_cache"

# Function to get the current TX and RX values for wlan0
get_tx_rx_values() {
    rx=$(cat /sys/class/net/$interface/statistics/rx_bytes)
    tx=$(cat /sys/class/net/$interface/statistics/tx_bytes)
}

# Function to read and compare values from cache
read_cache_and_compare() {
    if [ -f "$cache_file" ]; then
        # Read previous values from cache file
        read -r prev_rx prev_tx prev_time <"$cache_file"

        # Calculate the time difference
        current_time=$(date +%s)
        time_diff=$((current_time - prev_time))

        # Calculate the rate in bps
        rx_rate=$(expr \( $rx - $prev_rx \) / $time_diff)
        tx_rate=$(expr \( $tx - $prev_tx \) / $time_diff)
        rx_units="b/s"
        tx_units="b/s"

        # Scale down to Kbps, Mbps and Gbps
        if [ "$rx_rate" -ge 1000 ]; then
            rx_rate=$(expr $rx_rate / 1000)
            rx_units="kb/s"

            if [ "$rx_rate" -ge 1000 ]; then
                rx_rate=$(expr $rx_rate / 1000)
                rx_units="mb/s"

                if [ "$rx_rate" -ge 1000 ]; then
                    rx_rate=$(expr $rx_rate / 1000)
                    rx_units="gb/s"
                fi
            fi
        fi
        if [ "$tx_rate" -ge 1000 ]; then
            tx_rate=$(expr $tx_rate / 1000)
            tx_units="kb/s"

            if [ "$tx_rate" -ge 1000 ]; then
                tx_rate=$(expr $tx_rate / 1000)
                tx_units="mb/s"

                if [ "$tx_rate" -ge 1000 ]; then
                    tx_rate=$(expr $tx_rate / 1000)
                    tx_units="gb/s"
                fi
            fi
        fi
    fi
}

# Function to update cache with current values
update_cache() {
    echo "$rx $tx $(date +%s)" >"$cache_file"
}

main() {
    # Main script logic
    get_tx_rx_values
    read_cache_and_compare
    update_cache

    RATE=$(get_tmux_option "@dracula-refresh-rate" 5)

    padded_rx_rate=$(normalize_string_left "$rx_rate $rx_units" 9)
    padded_tx_rate=$(normalize_string_left "$tx_rate $tx_units" 9)

    echo "↓$padded_rx_rate↓ ↑$padded_tx_rate↑"

    sleep $RATE
}

#run main driver
main
