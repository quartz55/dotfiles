set mpv_socket $HOME/.cache/mpvsocket

set _help_help 'Display this help'
set _help_play 'Unpause mpv if no arguments provided or play specified arguments'
set _help_pause 'Pause mpv'
set _help_toggle 'Toggle mpv paused state'
set _help_stop 'Stop and quit mpv'
set _help_queue 'Add arguments to playlist'
set _help_clear 'Clear playlist'
set _help_next 'Skip to next song in the playlist (if available)'
set _help_prev 'Skip to prev song in the playlist (if available)'
set _help_custom 'Send a custom mpv JSON RPC command'

function __mpvctl_print_help
    set commands (set --names | grep '^_help' | sed "s/_help_//")
    printf (set_color blue)"mpvctl - Command line program for controlling a running mpv instance\n"
    if not test -z $argv[1]
        if contains $argv[1] $commands
            printf (set_color green)"\t%s\t--\t%s\n"(set_color normal) $argv[1] (eval echo '$_help_'$argv[1])
        else
            printf (set_color red)"Command $argv[1] doesn't exist!\n"
            printf (set_color green)"Available commands:\n    $commands\n"(set_color normal)
            return 1
        end
    else
        for cmd in $commands
            printf (set_color green)"\t%s\t--\t%s\n"(set_color normal) $cmd (eval echo '$_help_'$cmd)
        end
    end
    return 0
end

function __mpvctl_check_connection
    echo '{ "command": ["client_name"] }' | socat - $mpv_socket >/dev/null 2>&1
    return $status
end

function __mpvctl_build_command
    set -l cmd '{ "command":'
    set cmd $cmd '[' "\"$argv[1]\"" (test (count $argv) -ge 2; and echo {', '}$argv[2..-1]) ']'
    set cmd $cmd '}'
    echo $cmd
end

function mpvctl -d 'Command line program for controlling a running mpv instance'
    if not which socat >/dev/null 2>&1
        set_color red
        echo "This program needs 'socat' to be installed"
        set_color normal
        return 2
    end
    if not test -S $mpv_socket || not __mpvctl_check_connection
        set_color red
        echo "MPV isn't running or socket path '$mpv_socket' is wrong!"
        set_color normal
        return 3
    end

    set -l options 'h/help'
    builtin argparse $options -- $argv
    set -l flags (set | grep '_flag' | sed 's/_flag_//' )

    echo "argv: $argv"
    if test (count $flags) -gt 0
        echo "Flags"
        for flag in $flags
            printf "\t$flag\n"
        end
    end

    set -l cmd $argv[1]; set -e argv[1]
    set -l mpv_cmd

    echo "cmd: $cmd"
    echo "argv: $argv"

    if set -q _flag_help
        __mpvctl_print_help $cmd
        return $status
    end

    # Defaults to help if no command is specified
    test -z $cmd; and set cmd "help"
    
    switch $cmd
        case "help"
            __mpvctl_print_help $argv[1]
            return $status
        case "stop"
            set mpv_cmd (__mpvctl_build_command stop)
        case "play"
            if test (count $argv) -ge 1
                set mpv_cmd (__mpvctl_build_command playlist_clear)
                for file_or_url in $argv
                    set mpv_cmd $mpv_cmd (__mpvctl_build_command loadfile "\"$file_or_url\"" '"append-play"')
                end
            else
                set mpv_cmd (__mpvctl_build_command set_property '"pause"' false)
            end
        case "queue"
            if test (count $argv) -ge 1
                for file_or_url in $argv
                    set mpv_cmd $mpv_cmd (__mpvctl_build_command loadfile "\"$file_or_url\"" '"append-play"')
                end
            else
                set_color red
                echo "No argument supplied for 'queue'"
                echo "Supply 1 or more file(s)/url(s)"
                set_color normal
                __mpvctl_print_help 'queue'
                return $status
            end
        case "pause"
            set mpv_cmd (__mpvctl_build_command set_property '"pause"' true)
        case "toggle"
            set mpv_cmd (__mpvctl_build_command cycle '"pause"')
        case "next"
            set mpv_cmd (__mpvctl_build_command playlist_next)
        case "prev"
            set mpv_cmd (__mpvctl_build_command playlist_prev)
        case "clear"
            set mpv_cmd (__mpvctl_build_command playlist_clear)
        case "custom"
            set mpv_cmd (__mpvctl_build_command $argv)
        case '*'
            set_color red
            echo "Invalid command '$cmd'"
            set_color normal
            __mpvctl_print_help
            return $status
    end

    for $cmd in $mpv_cmd
        set_color blue; echo "Sending command: $i"; set_color normal
        echo $i | socat - $mpv_socket
    end

    return 0
end
