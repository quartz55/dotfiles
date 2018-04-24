set -U fish_path ~/.local/share/fisherman

set -l DEBUG 1
set -l fish_config_path (set -q XDG_CONFIG_DIR
                         and echo "$XDG_CONFIG_DIR/fish"
                         or echo "$HOME/.config/fish")
function _insert_after
    if not test (count $argv) -ge 3
        set_color red
        printf "Invalid number of arguments %d (expected %d)\n" (count $argv) 3
        set_color normal
        return 2
    end
    set value $argv[1]
    set key $argv[2]
    set -e argv[1..2]
    set list $argv
    set result
    set ret
    if set index (contains -i -- $key $list)
        set result $list[0..$index] $value $list[(math $index + 1)..-1]
        set ret 0
    else
        set result $value $list
        set ret 1
    end
    for r in $result; echo $r; end
    return $ret
end

# Load functions
set fish_function_path (_insert_after $fish_path/functions $fish_config_path/functions $fish_function_path)

# Load completions
set fish_complete_path (_insert_after $fish_path/completions $fish_config_path/completions $fish_complete_path)

if test $DEBUG -eq 0
    printf (set_color green)"Functions paths:\n"(set_color normal)
    for path in $fish_function_path
        printf "\t- %s\n" $path
    end
    printf (set_color green)"Completions paths:\n"(set_color normal)
    for path in $fish_complete_path
        printf "\t- %s\n" $path
    end
end

# Load autoloads
for file in $fish_path/conf.d/*.fish
    builtin source $file
end
