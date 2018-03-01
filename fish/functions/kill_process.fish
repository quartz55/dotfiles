# Defined in /home/jcosta/.config/fish/config.fish @ line 22
function kill_process
	find_pid | xargs kill
end
