function! ChangeTabStopLength(l1, l2)
    let &l:tabstop = a:l1
    let &l:expandtab = 0
    exe 'retab!'
    let &l:tabstop = a:l2
    let &l:expandtab = 1
    exe 'retab!'
endfunction
