# map global insert <backspace> '<a-;>:insert-bs<ret>'

hook global InsertChar \t %{
    exec -draft h@
}

def -hidden insert-bs %{
    try %{
        exec -draft -no-hooks h %opt{indentwidth}H <a-k>\A<space>+\Z<ret> d
    } catch %{
        exec <backspace>
    }
}
