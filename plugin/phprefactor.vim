if !exists("g:php_refactor_patch_command")
    let g:php_refactor_patch_command='patch --silent --input - --output - --dir="/tmp"'
endif

func! PhpRefactorShowMenu() range
    echohl Title
    echo 'Available Refactorings:'
    echohl None
    echo '(em) Extract Method'
    echo '(lv) rename Local Variable'
    echo '(li) Local variable to Instance variable'
    echo '(ou) Optimize Use'
    echo ''
    echo '(c) Cancel'
    echo ''

    let choice = nr2char(getchar())
    if choice == 'c'
        return
    endif
    let choice = choice . nr2char(getchar())

    if choice == 'em'
        call PhpRefactorExtractMethod(a:firstline, a:lastline)
    elseif choice == 'lv'
        call PhpRefactorRenameLocalVariable()
    elseif choice == 'li'
        call PhpRefactorLocalVariableToInstanceVariable()
    elseif choice == 'ou'
        call PhpRefactorOptimizeUse()
    endif
endfunc

func! PhpRefactorExtractMethod(startline, endline)
    let method = input('Enter extracted method name: ')

    let range = a:startline . '-' . a:endline

    let args = [range, method]

    call PhpRefactorRunCommand('extract-method', args)

    " todo : exit visual mode
endfunc

func! PhpRefactorLocalVariableToInstanceVariable()
    set iskeywordOptionOld = &iskeyword
    set iskeyword-=$
    let variable = expand('<cword>')
    set iskeyword = iskeywordOptionOld

    let lineNo = line('.')

    let args = [lineNo, variable]

    call PhpRefactorRunCommand('convert-local-to-instance-variable', args)
endfunc

func! PhpRefactorRenameLocalVariable()
    let oldName = expand('<cword>')
    let lineNo = line('.')
    let newName = input('Enter new variable name: ')

    let args = [lineNo, oldName, newName]

    call PhpRefactorRunCommand('rename-local-variable', args)
endfunc

func! PhpRefactorOptimizeUse()
    call PhpRefactorRunCommand('optimize-use', [])
endfunc

func! PhpRefactorRunCommand(refactoring, args)
    if !exists("g:php_refactor_command")
        echom 'You need to set g:php_refactor_command in your .vimrc'
        return
    endif

    let command = ':%!' . g:php_refactor_command
        \ . ' ' . a:refactoring . ' -'

    for arg in a:args
        let command = command . ' ' . arg
    endfor

    exec command . ' | ' . g:php_refactor_patch_command
    exec ':redraw!'
    echo command . ' | ' . g:php_refactor_patch_command
endfunc
