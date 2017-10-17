scriptencoding utf-8
" Version: 0.1.0
" Author:  maxmellon
" License: MIT License

let s:save_cpo = &cpo
set cpo&vim

function! s:get_output(command)
  try
    let output = system(a:command . ' | fzy')
  catch /Vim:Interrupt/
  endtry
  redraw!
  return substitute(output, "\n", '', 'g')
endfunction

function! s:base(command, Callback)
  let output = s:get_output(a:command)
  redraw!
  if v:shell_error == 0 && !empty(output)
    call a:Callback(output)
  endif
endfunction

function! s:get_command()
  let helpfile = expand(findfile('doc/index.txt', &runtimepath))
  if !filereadable(helpfile) | return | endif
  let cmd = 'cat ' . helpfile . " | grep -E '^\\|:' | awk -F ' ' '{print $1}' | tr -d '|'"
  return cmd
endfunction

function! s:execute(command)
  execute a:command
endfunction

function! s:help(command)
  execute 'help ' . a:command
endfunction

function! fzy#commands#list()
  let cmd = s:get_command()
  if cmd ==# '' | return | endif
  let Callback = { command -> s:execute(command) }
  call s:base(cmd, Callback)
endfunction

function! fzy#commands#help()
  let cmd = s:get_command()
  if cmd ==# '' | return | endif
  let Callback = { command -> s:help(command) }
  call s:base(cmd, Callback)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
