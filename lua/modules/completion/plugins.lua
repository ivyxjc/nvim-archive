local completion = {}
local conf = require('modules.completion.config')

completion['neovim/nvim-lspconfig'] = {
    event = 'BufReadPre',
    config = conf.nvim_lsp
}

completion['glepnir/lspsaga.nvim'] = {
    cmd = 'Lspsaga'
}

completion['hrsh7th/nvim-compe'] = {
    event = 'InsertEnter',
    config = conf.nvim_compe
}

completion['hrsh7th/vim-vsnip'] = {
    event = 'InsertCharPre',
    config = conf.vim_vsnip
}

return completion
