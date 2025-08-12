return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                'c',
                'cpp',
                'rust',
                'disassembly',
                -- 'x86asm',
                'nasm',
                -- 'wasm',
                'python',
                'javascript',
                'jq',
                'json',
                'json5',
                'jsonc',
                'sql',
                'html',
                'css',
                'markdown',
                'markdown_inline', -- markview
                -- 'latex',           -- markview
                'typst',           -- markview
                'htmldjango',
                -- 'jinja2',
                'pug',
                'lua',
                'vim',
                'bash',
                'powershell',
                'dockerfile',
                'ssh_config',
                'toml',
                'yaml',
            }, -- add more as needed
            highlight = { enable = true },
            indent = { enable = true },
            -- parser_install_dir = "~/.cache/treesitter/parsers"
        }
    end
}
