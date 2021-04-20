local api = vim.api
local lspconfig = require 'lspconfig'
local global = require 'core.global'
local format = require('modules.completion.format')

if not packer_plugins['lspsaga.nvim'].loaded then
    vim.cmd [[packadd lspsaga.nvim]]
end

local saga = require 'lspsaga'
saga.init_lsp_saga({
    code_action_icon = '💡'
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function _G.reload_lsp()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    vim.cmd [[edit]]
end

function _G.open_lsp_log()
    local path = vim.lsp.get_log_path()
    vim.cmd("edit " .. path)
end

vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = true,
    signs = {
        enable = true,
        priority = 20
    },
    -- Disable a feature
    update_in_insert = false
})

local enhance_attach = function(client, bufnr)
    if client.resolved_capabilities.document_formatting then
        format.lsp_before_save()
    end
    local opts = {
        noremap = true,
        silent = false
    }
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    api.nvim_buf_set_keymap(0, 'n', '<m-d>', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    api.nvim_buf_set_keymap(0, 'i', '<m-d>', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    api.nvim_buf_set_keymap(0, 'n', '<m-b>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    api.nvim_buf_set_keymap(0, 'n', '<m-h>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    api.nvim_buf_set_keymap(0, 'n', '<m-i>', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    api.nvim_buf_set_keymap(0, 'n', '<c-p>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    api.nvim_buf_set_keymap(0, 'i', '<c-p>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    api.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    api.nvim_buf_set_keymap(0, 'i', '<m-u>', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

lspconfig.gopls.setup {

    cmd = {"gopls", "--remote=auto"},
    on_attach = enhance_attach,
    capabilities = capabilities,
    init_options = {
        usePlaceholders = true,
        completeUnimported = true
    }
}

lspconfig.clojure_lsp.setup {
    cmd = {"clojure-lsp"},
    on_attach = enhance_attach,
    filetypes = {"clojure", "edn", "clj", "cljs", "cljc"},
    root_dir = lspconfig.util.root_pattern("project.clj", "deps.edn")
}

lspconfig.sumneko_lua.setup {
    cmd = {global.home .. "/workstation/lua-language-server/bin/macOS/lua-language-server", "-E",
           global.home .. "/workstation/lua-language-server/main.lua"},
    settings = {
        Lua = {
            diagnostics = {
                enable = true,
                globals = {"vim", "packer_plugins"}
            },
            runtime = {
                version = "LuaJIT"
            },
            workspace = {
                library = vim.list_extend({
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true
                }, {})
            }
        }
    }
}

lspconfig.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        enhance_attach(client)
    end
}

lspconfig.clangd.setup {
    cmd = {"clangd", "--background-index", "--suggest-missing-includes", "--clang-tidy", "--header-insertion=iwyu"}
}

local servers = {'dockerls', 'bashls', 'rust_analyzer', 'pyright'}

for _, server in ipairs(servers) do
    lspconfig[server].setup {
        on_attach = enhance_attach
    }
end