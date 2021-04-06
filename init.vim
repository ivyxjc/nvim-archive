lua require('core')
let g:nvim_config_root=expand('<sfile>:p:h')
execute printf('source %s/%s',g:nvim_config_root,'keymap.vim')
