## 
## Show relative cursor position in buffer (percentage)
## 

decl str modeline_pos_percent

hook global WinCreate .* %{
    hook window NormalIdle .* %{ %sh{
        echo "set window modeline_pos_percent '$(($kak_cursor_line * 100 / $kak_buf_line_count))'"
    } }
}
