if which hub >/dev/null
    eval (hub alias -s)
    complete -c hub -w git
end
