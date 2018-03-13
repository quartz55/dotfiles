function lss --description 'List directory with sizes'
	du -h -d 1 $argv | sort -rh
end
