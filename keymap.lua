vim.g.mapleader=' '

vim.api.nvim_set_keymap('n','<leader>tt',':NvimTreeToggle<CR>',{noremap = true, silent = true})


vim.api.nvim_set_keymap('n','<leader>vv',":vsp<CR>", {noremap = true,silent = true})
vim.api.nvim_set_keymap('n','<leader>vh',":sp<CR>", {noremap = true,silent = true})


vim.api.nvim_set_keymap('','<C-s>',':w<CR>' ,{noremap = true, silent = true})
vim.api.nvim_set_keymap('n','<C-a>','ggVG' ,{noremap = true, silent = true})
vim.api.nvim_set_keymap('v','<C-c>','"*y' ,{noremap = true, silent = true})

vim.api.nvim_set_keymap('n','<leader>fm',':Move ',{noremap=true,silent=true})


vim.api.nvim_set_keymap('n','<leader>wh','<C-w>h<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<leader>j','<C-w>j<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<leader>k','<C-w>k<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<leader>l','<C-w>l<CR>',{noremap=true,silent=true})
vim.api.nvim_set_keymap('n','<leader>q',':q<CR>',{noremap=true,silent=true})

--vim.api.nvim_del_keymap('n','<C-wh>')
