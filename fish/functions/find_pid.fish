# Defined in /home/jcosta/.config/fish/config.fish @ line 18
function find_pid
	ps axww -o pid,user,%cpu,%mem,start,time,command | fzy -q "$LBUFFER" | awk '{print $1}'
end
