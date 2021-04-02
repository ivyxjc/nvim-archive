vim.g.mapleader=' '
vim.api.nvim_set_keymap('n','<leader>tt',':NvimTreeToggle',{noremap = true, silent = true})


vim.api.nvim_set_keymap('n','<leader>vv',":vsp<CR>", {noremap = true,silent = true})
vim.api.nvim_set_keymap('n','<leader>vh',":sp<CR>", {noremap = true,silent = true})


vim.api.nvim_set_keymap('','<C-s>',':w<CR>' ,{noremap = true, silent = true})
vim.api.nvim_set_keymap('n','<C-a>','ggVG' ,{noremap = true, silent = true})
vim.api.nvim_set_keymap('v','<C-c>','"*y' ,{noremap = true, silent = true})

vim.api.nvim_del_keymap('n','<C-wh>')
