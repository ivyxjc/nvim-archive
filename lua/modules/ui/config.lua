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

function config.galaxyline()
    require('modules.ui.eviline')
end

function config._gitsigns()
    if not packer_plugins['plenary.nvim'].loaded then
        vim.cmd [[packadd plenary.nvim]]
    end
    require('gitsigns').setup {
        signs = {
            add = {
                hl = 'GitGutterAdd',
                text = '▋'
            },
            change = {
                hl = 'GitGutterChange',
                text = '▋'
            },
            delete = {
                hl = 'GitGutterDelete',
                text = '▋'
            },
            topdelete = {
                hl = 'GitGutterDeleteChange',
                text = '▔'
            },
            changedelete = {
                hl = 'GitGutterChange',
                text = '▎'
            }
        },
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,

            ['n ]g'] = {
                expr = true,
                "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"
            },
            ['n [g'] = {
                expr = true,
                "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"
            },

            -- ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
            -- ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            -- ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
            -- ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
            -- ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

            -- Text objects
            ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
            ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
        }
    }
end

return config
