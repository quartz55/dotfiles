# Set environment variables
if status is-login
    if functions -q bass; and not set -q FISH_LOGIN
        printf (set_color cyan)"Not this time mofo <:(\n"(set_color normal)
        # bass 'source /etc/profile'
    else
        echo (set_color yellow)"WARNING: Make sure 'bass' is available for '/etc/profile' compatibility!"(set_color normal)
    end
    set -l login_counter (set -q FISH_LOGIN[1]; and echo $FISH_LOGIN[1]; or echo 0)
    set -gx FISH_LOGIN (math "1 + $login_counter") $FISH_LOGIN
end
