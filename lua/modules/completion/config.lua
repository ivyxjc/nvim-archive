local config = {}

function config.nvim_lsp()
    require('modules.completion.lspconfig')
end

function config.nvim_compe()
    require'compe'.setup {
        enabled = true,
        debug = false,
        min_length = 1,
        preselect = 'always',
        allow_prefix_unmatch = false,
        source = {
            path = true,
            buffer = true,
            calc = true,
            vsnip = true,
            nvim_lsp = true,
            nvim_lua = true,
            spell = true,
            tags = true,
            snippets_nvim = false,
        }
    }
end

function config.vim_vsnip()
    vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/snippets'
end

return config
