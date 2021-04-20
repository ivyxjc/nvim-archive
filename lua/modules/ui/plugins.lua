local ui = {}
local config = require('modules.ui.config')

ui['kyazdani42/nvim-tree.lua'] = {
    cmd = {'NvimTreeToggle', 'NvimTreeOpen'},
    config = config.vim_tree,
    requires = {'kyazdani42/nvim-web-devicons'}
}

ui['joshdick/onedark.vim'] = {
    config = [[vim.cmd('colorscheme onedark')]]
}

ui['romgrk/barbar.nvim'] = {
    requires = {'kyazdani42/nvim-web-devicons'}
}

ui['glepnir/galaxyline.nvim'] = {
    branch = 'main',
    config = config.galaxyline,
    requires = {'kyazdani42/nvim-web-devicons'}
}

ui['lewis6991/gitsigns.nvim'] = {
    config = config._gitsigns,
    requires = {'nvim-lua/plenary.nvim'}
}

ui['rhysd/accelerated-jk'] = {}

return ui
