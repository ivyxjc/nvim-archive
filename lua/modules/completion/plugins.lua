local completion = {}
local conf = require('modules.completion.config')

completion['neovim/nvim-lspconfig'] = {
    event = 'BufReadPre',
    config = conf.nvim_lsp
}

completion['glepnir/lspsaga.nvim'] = {
    cmd = 'Lspsaga'
}

return completion
