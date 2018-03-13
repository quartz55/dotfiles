# Merge keybindings
set -l scripts_folder (dirname (status -f))/scripts

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

set grc_wrap_commands cat cvs df diff dig gcc g++ ifconfig make mount mtr netstat ping ps tail traceroute wdiff

# Anaconda
function __get_conda_root
    set -l opt /opt/anaconda
    set -l home $HOME/.anaconda3

    if test -d $home; echo $home
    else if test -d $opt; echo $opt
    end
end

# If conda is in path source fish integration
if which conda ^/dev/null 1>/dev/null
    # set -l conda_root (__get_conda_root)
    # if test -n $conda_root
    #     set -l file $conda_root/etc/fish/conf.d/conda.fish
    #     test -e $file; and builtin source $file
    # end
    builtin source $scripts_folder/conda.fish
end

status is-interactive; and byobu-status; and byobu-launch
