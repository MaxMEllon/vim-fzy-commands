scriptencoding utf-8
" Version: 0.1.0
" Author:  maxmellon
" License: MIT License

if exists('g:loaded_vim_fzy_commands')
  finish
endif

let g:loaded_vim_fzy_commands = 1

let s:save_cpo = &cpo
set cpo&vim

command! FzyCommand call fzy#commands#list()
command! FzyCommandHelp call fzy#commands#help()

let &cpo = s:save_cpo
unlet s:save_cpo
