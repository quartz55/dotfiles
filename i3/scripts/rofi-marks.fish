#!/usr/bin/env fish

set new_mark "Alt+n" "Create mark"
set del_mark "Alt+d" "Delete mark"

set msg \
"<b>$new_mark[1]</b> <small><i>($new_mark[2])</i></small>"\n\
"<b>$del_mark[1]</b> <small><i>($del_mark[2])</i></small>"

function get_marks
    printf "%s\n" (i3-msg -t get_marks | jq .[] | sed 's/\"//g')
end

function _rofi
    command rofi -dmenu -i -mesg "$msg" -p "Marks" \
                 -kb-custom-1 "$new_mark[1]" \
                 -kb-custom-2 "$del_mark[1]"
end

function main
    set -l marks (get_marks)
    set -l selection (printf "%s\n" $marks | _rofi)
    set -l rofi_exit $status

    switch $rofi_exit
        case 1
            exit 1
        case 10 # New mark
            if contains $selection $marks
                i3-msg (printf 'unmark %s' $selection) >/dev/null
            end
            i3-msg (printf 'mark %s' $selection) >/dev/null
        case 11 # Del mark
            if contains $selection $marks
                i3-msg (printf 'unmark %s' $selection) >/dev/null
            end
        case '*' # Go to mark
            if contains $selection $marks
                i3-msg (printf '[con_mark="%s"] focus' $selection) >/dev/null
            end
    end
end

main