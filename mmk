#!/bin/bash

# Automatically recompile markdown and refresh browser on file change

mdh=$(dirname $(realpath "${BASH_SOURCE[0]}"))/mdh

input="$1"
if [[ ! -e "$input" ]]; then
    # Find most recently modified markdown file in cwd
    unset -v input
    for file in *.md *.mkd *.markdown; do
        [[ "$file" -nt "$input" ]] && input=$file
    done
fi

if [[ -z "$input" ]]; then
    echo "Can't find a markdown input!"
    exit 1
fi

output=${input%.*}.html
shown=false

browser_desktop=$(xdg-settings get default-web-browser)
browser=${browser_desktop%.*}  # strip the .desktop extension
if [[ -z "$browser" ]]; then
    echo "Please set a default browser via 'xdg-settings set default-web-browser'"
    exit 2
fi
if [[ ! -x $(command -v $browser) ]]; then
    echo "Can't find an executable for $browser!"
    exit 3
fi

echo "Watching $input"
while true; do
    $mdh "$input" "$output"
    echo "Rendered $output"

    if [[ $shown == false ]]; then
        $browser "$output" &>/dev/null &
        shown=true
    else
        active_window=$(xdotool getactivewindow)
        # Assume only a single browser window exists in the current desktop (workspace),
        # and its class name is simply $browser
        xdotool search --onlyvisible --all --desktop `xdotool get_desktop` --class $browser windowfocus key 'F5'
        xdotool windowfocus $active_window
    fi

    inotifywait -qq -e CLOSE_WRITE "$input"
done
