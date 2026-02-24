#!/bin/bash
DISPLAY_TOOL="${DISPLAY_TOOL:-btop}"
TERMINAL="${TERMINAL:-xfce4-terminal}"
LOCK_FILE="/tmp/i3-empty-ws-display.lock"

if [ -f "$LOCK_FILE" ]; then
    old_pid=$(cat "$LOCK_FILE")
    if kill -0 "$old_pid" 2>/dev/null; then
        exit 0
    fi
fi
echo $$ > "$LOCK_FILE"

get_current_workspace() {
    i3-msg -t get_workspaces | jq -r '.[] | select(.focused == true) | .num'
}

get_workspace_window_count() {
    local ws_num=$1
    i3-msg -t get_tree | jq -r --argjson ws "$ws_num" '
        [.nodes[], .nodes[].nodes[], .nodes[].nodes[].nodes[]] | 
        .[] | select(.type == "workspace" and .num == $ws) | 
        .nodes | length
    '
}

start_display() {
    if pgrep -f "sysinfo-(btop|fastfetch)" > /dev/null 2>&1; then
        return
    fi
    
    case "$DISPLAY_TOOL" in
        btop)
            $TERMINAL --fullscreen --title="sysinfo-btop" -e btop &
            ;;
        fastfetch)
            $TERMINAL --fullscreen --title="sysinfo-fastfetch" -e ~/.config/i3/scripts/sysinfo-fastfetch.sh &
            ;;
    esac
}

prev_ws=""
prev_count=0

while true; do
    current_ws=$(get_current_workspace)
    window_count=$(get_workspace_window_count "$current_ws")
    
    if [ -z "$window_count" ]; then
        window_count=0
    fi
    
    if [ "$window_count" -eq 0 ] && [ "$prev_count" -gt 0 ]; then
        pkill -f "sysinfo-(btop|fastfetch)" 2>/dev/null
        sleep 0.3
        start_display
    elif [ "$window_count" -gt 0 ]; then
        pkill -f "sysinfo-(btop|fastfetch)" 2>/dev/null
    fi
    
    prev_ws="$current_ws"
    prev_count="$window_count"
    sleep 0.5
done
