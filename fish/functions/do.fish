function do
	set -l pattern "{(\w+)(?:,(\w+))*}"
set -l cmd
set -l cmd_args
for arg in $argv
if set -l expansions (string match -r -e $pattern $arg)
set -e expansions[1]
printf "Found expansion:\n"
printf (set_color green)"  %s\n"(set_color normal) $expansions
set cmd $cmd "%s"
set cmd_args $cmd_args $expansions
else
set cmd $cmd $arg
end
printf (set_color yellow)"Building cmd: %s\n"(set_color normal) (string join " " $cmd)
end
set final_cmds (printf (string join " " $cmd)"\n" $cmd_args)
set_color cyan
printf "Expanded commands:\n"
printf "  %s\n" $final_cmds
set_color normal
for e in $final_cmds
eval $e
end
end
