#!/bin/bash

# automatically recompile markdown and refresh browser on file change

mdh=$(dirname $(realpath "${BASH_SOURCE[0]}"))/mdh

input="$1"
if [[ ! -e "$input" ]]; then
    # find newest markdown file in cwd
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

echo "Watching $input"
while true; do
    inotifywait -qq -e CLOSE_WRITE "$input"
    $mdh "$input" "$output"
    echo "Rendered $output"

    if [[ $shown == false ]]; then
        vivaldi-stable "$output" &>/dev/null &
        shown=true
    else
        active_window=$(xdotool getactivewindow)
        # assume only a single browser window exists in the current desktop (workspace)
        xdotool search --onlyvisible --all --desktop `xdotool get_desktop` --class Vivaldi windowfocus key 'F5'
        xdotool windowfocus $active_window
    fi
done
