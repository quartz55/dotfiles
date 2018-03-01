function fzy_z
    z -l 2>/dev/null | cut -c 12- | fzy | read -l dir
    test -n dir; and cd $dir
    commandline -f repaint
end
