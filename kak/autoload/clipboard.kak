# Clipboard keybinds (using xsel) for kakoune
map global user p !xsel<space>-bo<ret> -docstring "Paste from clipboard"
map global user y <a-|>xsel<space>-bi<ret> -docstring "Copy selection to clipboard"
