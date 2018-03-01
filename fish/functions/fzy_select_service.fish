function fzy_select_service
    set -l service (systemctl | fzy | cut -d ' ' -f1) 
    echo $service
end
