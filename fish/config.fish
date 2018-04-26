set -gx EDITOR "em -t"
set -gx VISUAL "em"
set -g theme_nerd_fonts yes

# Merge keybindings
if status is-interactive
    functions -q fish_user_key_bindings
    functions -q fish_user_key_bindings
    and not functions -q __original_fish_user_key_bindings
    and functions -c fish_user_key_bindings __original_fish_user_key_bindings
    function fish_user_key_bindings
        functions -q __original_fish_user_key_bindings
        and __original_fish_user_key_bindings
        bind \cf forward-char
        bind \ct fzy_select_directory
        bind \ez fzy_z
    end
end

set -l scripts_folder (dirname (status -f))/scripts

############
# Anaconda #
############
function __get_conda_root
    set -l opt /opt/anaconda
    set -l home $HOME/.anaconda3

    if test -d $home; echo $home
    else if test -d $opt; echo $opt
    end
end

set -l conda_root (__get_conda_root)
if test -n $conda_root
    set -l conda_bin $conda_root/bin
    not contains $conda_bin $PATH; and set -gx PATH $PATH $conda_bin
    # If conda is in path source fish integration
    if command which conda >/dev/null 2>&1
        set -l file $conda_root/etc/fish/conf.d/conda.fish
        test -e $file; and builtin source $file
    end
end

