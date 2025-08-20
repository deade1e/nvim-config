return {
    "neovim/nvim-lspconfig",
    config = function()
        local on_attach = function(client, bufnr)
            local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            map('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, '[LSP] Format')
            map('n', '<leader>rn', vim.lsp.buf.rename, '[LSP] Rename symbol')
            map('n', 'gd', vim.lsp.buf.definition, '[LSP] Go to definition')
            map('n', 'gD', vim.lsp.buf.declaration, '[LSP] Go to declaration')
            map('n', 'gR', '<cmd>Telescope lsp_references<CR>', '[LSP] Show references (Telescope)')
            map('i', '<C-s>', vim.lsp.buf.signature_help, 'Signature Help')
        end

        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format()
            end,
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local bufnr = ev.buf

                on_attach(client, bufnr)
            end,

        })

        vim.lsp.enable('nixd')
        vim.lsp.enable('clangd')
        vim.lsp.enable('html')
        vim.lsp.enable('pyright')
        vim.lsp.enable('yamlls')
        vim.lsp.enable('bashls')

        vim.lsp.config('lua_ls', {
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- Depending on the usage, you might want to add additional paths here.
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                })
            end,
            settings = {
                Lua = {}
            }
        })
        vim.lsp.enable('lua_ls')

        vim.lsp.config('jsonls', {
            settings = {
                json = {
                    schemas = {
                        {
                            fileMatch = { 'package.json' },
                            url = 'https://json.schemastore.org/package.json'
                        }
                    },
                    validate = { enable = true },
                    format = { enable = true },
                    allowComments = true, -- critical for JSONc support,
                }
            },
        })
        vim.lsp.enable('jsonls')

        vim.lsp.config('rust_analyzer', {
            settings = {
                ["rust-analyzer"] = {
                    inlayHints = {
                        enable = true,
                        -- Customize hint appearances
                        parameterHints = { suffix = ": ", useNamedParameters = true },
                        typeHints = {
                            hideClosureInitialization = false,
                            typeHintsPattern = ".*",
                            separator = " ➔ ",
                            mode = "always"
                        },
                        chainingHints = { enable = true },
                        closingBraceHints = { enable = true },
                        lifetimeElisionHints = { enable = "skip_trivial" },
                        reborrowHints = { enable = "never" },
                    },
                    checkOnSave = true
                }
            },

        })

        vim.lsp.enable('rust_analyzer')
        vim.lsp.enable('ts_ls')
        vim.lsp.inlay_hint.enable()
    end

}
