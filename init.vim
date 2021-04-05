lua require('core')
"lua require('keymap')
let g:nvim_config_root=expand('<sfile>:p:h')
execute printf('source %s/%s',g:nvim_config_root,'keymap2.vim')
