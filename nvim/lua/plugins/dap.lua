return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap-python',
      'theHamsta/nvim-dap-virtual-text',
    },
    keys = {
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
      { '<leader>dB', function()
          vim.ui.input({ prompt = 'Condition: ' }, function(cond)
            if cond then require('dap').set_breakpoint(cond) end
          end)
        end, desc = 'Conditional breakpoint' },
      { '<leader>dc', function() require('dap').continue()    end, desc = 'Continue' },
      { '<leader>di', function() require('dap').step_into()   end, desc = 'Step into' },
      { '<leader>dn', function() require('dap').step_over()   end, desc = 'Step over (next)' },
      { '<leader>do', function() require('dap').step_out()    end, desc = 'Step out' },
      { '<leader>dr', function() require('dap').repl.open()   end, desc = 'Open REPL' },
      { '<leader>dl', function() require('dap').run_last()    end, desc = 'Run last' },
      { '<leader>dt', function() require('dap').terminate()   end, desc = 'Terminate' },
      { '<leader>du', function() require('dapui').toggle()    end, desc = 'Toggle DAP UI' },
      { '<leader>dp', function() require('dap-python').test_method() end, desc = 'Python: test method' },
      { '<leader>dP', function() require('dap-python').test_class()  end, desc = 'Python: test class' },
    },
    config = function()
      local dap   = require('dap')
      local dapui = require('dapui')

      dapui.setup()
      require('nvim-dap-virtual-text').setup({})

      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config']     = function() dapui.close() end

      -- Python: prefer mason-installed debugpy
      local mason_debugpy = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python'
      local py = vim.fn.executable(mason_debugpy) == 1 and mason_debugpy or 'python3'
      require('dap-python').setup(py)
    end,
  },
}
