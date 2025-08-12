require("config.lazy")

vim.g.mapleader = " "

-- Go back to visual mode in terminal by using ESC
vim.cmd([[:tnoremap <Esc> <C-\><C-n>]])

-- Make diagnostics float on hover
vim.o.updatetime = 250

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end
})

vim.wo.number = true
vim.opt.swapfile = false
vim.o.smartindent = true        -- Enable smart indentation
vim.o.autoindent = true         -- Auto indent when new lines are added
vim.o.expandtab = true          -- Use spaces instead of tabs. Keep it for markview.
vim.o.tabstop = 4               -- Set the width of a tab character
vim.o.shiftwidth = 4            -- Number of spaces to use for each indent level

vim.o.clipboard = 'unnamedplus' -- Use the system clipboard for copy-paste

vim.wo.cursorline = true        -- Highlight the current line

vim.o.hlsearch = true           -- Highlight search results
vim.o.incsearch = true          -- Incrementally highlight as you type

vim.o.ignorecase = true         -- Ignore case in search
vim.o.smartcase = true          -- Respect case when at least one uppercase letter is searched
vim.o.mouse = ""                -- Disable mouse

-- Switch buffers with Tab and Shift+Tab
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })

-- Use Ctrl+[h,l] or Ctrl+[Left,Right] to navigate between buffers
vim.keymap.set('n', '<A-h>', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-l>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Left>', ':bprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Right>', ':bnext<CR>', { noremap = true, silent = true })

-- Navigate between windows using Ctrl+[h,j,k,l]
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Navigate between windows using Ctrl+[Left,Down,Up,Right] arrows
vim.keymap.set('n', '<C-Left>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { noremap = true, silent = true })

-- Easy buffer closing
vim.keymap.set('n', '<leader>x', ':bd<CR>', { noremap = true, silent = true, desc = "Close current buffer" })
vim.keymap.set('n', '<leader>X', ':bd!<CR>', { noremap = true, silent = true, desc = "Force close current buffer" })
vim.keymap.set('n', '<leader>w', ':bw<CR>', { noremap = true, silent = true, desc = "Wipeout current buffer" })
vim.keymap.set('n', '<leader>W', ':bw!<CR>', { noremap = true, silent = true, desc = "Force wipeout current buffer" })

-- Close window
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = "Close current window" })

vim.keymap.set("n", "<leader>t", ':terminal<CR>', { desc = "Open Terminal" })
vim.keymap.set("n", "<leader>lg", function() require('snacks').lazygit() end, { desc = "Open lazygit" })
vim.keymap.set("n", "<leader>e", function() require('snacks').explorer() end, { desc = "Toggle Explorer" })

vim.filetype.add({ -- Disable htmldjango for bug in treesitter
    extension = {
        html = "html",
    },
})

-- Automatically change directory to the path provided when opening Neovim
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local args = vim.fn.argv()
        local last_arg = args[#args]
        if #args > 0 and vim.fn.isdirectory(last_arg) == 1 then
            vim.cmd("cd " .. last_arg)
        end
    end,
})
