local ui = {}
local config = {}

function config.nvim_tree()
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback
    vim.g.nvim_tree_side = 'left'
    vim.g.nvim_tree_width = 30
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_auto_open = 1
    vim.g.nvim_tree_hide_dotfiles = 0
    vim.g.nvim_tree_git_hl = 1

    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_bindings = {
        ["l"] = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
        ["s"] = ":lua require'nvim-tree'.on_keypress('vsplit')<CR>",
        ["i"] = ":lua require'nvim-tree'.on_keypress('split')<CR>",
        ["o"] = tree_cb("edit"),
        ["<CR>"] = tree_cb("edit"),
        ["<C-]>"] = tree_cb("cd"),
        ["c"] = tree_cb("copy"),
        ["p"] = tree_cb("paste"),
        ["<Tab>"] = tree_cb("preview")
    }
    vim.g.nvim_tree_icons = {
        default = '',
        symlink = '',
        git = {
            unstaged = "✚",
            staged = "✚",
            unmerged = "≠",
            renamed = "≫",
            untracked = "★"
        }
    }
end
ui['kyazdani42/nvim-tree.lua'] = {
    cmd = {'NvimTreeToggle', 'NvimTreeOpen'},
    config = config.vim_tree,
    requires = {'kyazdani42/nvim-web-devicons'}
}

ui['joshdick/onedark.vim'] = {
    config = [[vim.cmd('colorscheme onedark')]]
}

-- ui['doums/darcula']={
--     config = [[vim.cmd('colorscheme darcula')]]
-- }

return ui
