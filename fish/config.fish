# Merge keybindings
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
if which conda ^/dev/null 1>/dev/null
    set -l file (conda info --root)/etc/fish/conf.d/conda.fish
    test -e $file; and builtin source $file
end
