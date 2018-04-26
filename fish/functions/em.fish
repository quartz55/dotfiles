function __em_frame_count
    set -l sexpr "(length (frame-list))"
    emacsclient -n -e $sexpr 2>/dev/null; or echo 0
end

function em
    set -l opts (fish_opt -s h -l help)
    set opts $opts (fish_opt -s t -l terminal)
    set opts $opts (fish_opt -s c -l frame)
    set opts $opts (fish_opt -s w -l wait)
    argparse -n em -x t,c $opts -- $argv 2>&1 >/dev/null | read -l parse_err
    if test -n "$parse_err"
        set_color red
        printf "%s\n" $parse_err
        set_color normal
        return $status
        breakpoint
    end
    set -l client_flags (begin not set -q _flag_wait; and not set -q _flag_terminal; end; and echo -- '-n')
    set client_flags $client_flags (set -q _flag_terminal; and echo -- '-t')
    if set -q _flag_frame; or test ! (__em_frame_count) -ge 1
        set client_flags $client_flags '-c'
    end
    set -l cmd "emacsclient -a ''" $client_flags $argv
    eval $cmd
end
