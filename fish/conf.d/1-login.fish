# Set environment variables
if status is-login
    if functions -q bass
        if not set -q FISH_LOGIN
            printf (set_color cyan)"Not sourcing (for now :<)\n"(set_color normal)
            # bass 'source /etc/profile'
        end
    else
        set_color yellow
        printf "WARNING: '/etc/profile' not sourced\n"
        printf "Install 'bass' and make sure it is available"
        set_color normal
    end
    set -l login_counter (set -q FISH_LOGIN[1]; and echo $FISH_LOGIN[1]; or echo 0)
    set -gx FISH_LOGIN (math "1 + $login_counter") $FISH_LOGIN
end
