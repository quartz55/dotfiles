set -gx fish_path ~/.local/share/fisherman

set fish_function_path $fish_path/functions $fish_function_path
set fish_complete_path $fish_path/completions $fish_complete_path

for file in $fish_path/conf.d/*.fish
    builtin source $file ^ /dev/null
end
