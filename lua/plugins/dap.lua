return {
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require("dap")
        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }

        dap.adapters.lldb = {
            type = "executable",
            command = "/run/current-system/sw/bin/lldb-dap",
            args = {}
        }

        dap.configurations.rust = {
            {
                name = "Attach to gdbserver",
                type = "gdb",
                request = "attach",
                target = "127.0.0.1:1234",
                program = "${command:pickFile}",
                cwd = '${workspaceFolder}',
            },
            {
                name = 'Attach to gdbserver via LLDB',
                type = 'lldb',
                request = 'launch',
                initCommands = {
                    -- "platform select remote-linux",
                    -- "platform connect connect://127.0.0.1:1234"
                    "gdb-remote 1234"
                },
                program = "${command:pickFile}",
                cwd = '${workspaceFolder}',
                console = "integratedTerminal"
            },
            {
                name = "Pick",
                type = "lldb",
                request = "launch",
                program = "${command:pickFile}",
                cwd = "${workspaceFolder}",
                console = "externalTerminal"
            },
            {
                name = "Select and attach to process",
                type = "rustgdb",
                request = "attach",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                pid = function()
                    local name = vim.fn.input('Executable name (filter): ')
                    return require("dap.utils").pick_process({ filter = name })
                end,
                cwd = '${workspaceFolder}'
            },
        }

        vim.cmd(":DapSetLogLevel DEBUG")
        vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
        vim.keymap.set('n', '<leader>dr', require('dap').repl.toggle, { desc = '[DAP] Toggle REPL' })
        vim.keymap.set('n', '<leader>dl', require('dap').run_last, { desc = '[DAP] Run last' })

        vim.keymap.set('n', '<leader>b', require('dap').toggle_breakpoint, { desc = '[DAP] Toggle breakpoint' })

        vim.keymap.set('n', '<F5>', require('dap').continue, { desc = '[DAP] Continue' })
        vim.keymap.set('n', '<F6>', require('dap').step_out, { desc = '[DAP] Step out' })
        vim.keymap.set('n', '<F7>', require('dap').step_into, { desc = '[DAP] Step into' })
        vim.keymap.set('n', '<F8>', require('dap').step_over, { desc = '[DAP] Step over' })

        vim.keymap.set('n', '<F9>', require('dap').terminate, { desc = '[DAP] Terminate' })
    end
}
