return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "dart" },
    config = function()
      require("flutter-tools").setup({
        debugger = {
          enabled = true,
          run_via_dap = true,
          exception_breakpoints = "default",
          evaluate_to_string_in_debug_views = true,
          register_configurations = function(_)
            local dap = require("dap")
            dap.adapters.dart = {
              type = "executable",
              command = "/Users/ict/development/flutter/bin/flutter",
              args = { "debug_adapter" },
            }
            dap.configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch Flutter",
                dartSdkPath = "/Users/ict/development/flutter/bin/cache/dart-sdk/bin/dart",
                flutterSdkPath = "/Users/ict/development/flutter/bin/flutter",
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
                args = { "development" },
              },
            }
          end,
        },
        root_patterns = { ".git", "pubspec.yaml" },
        flutter_path = "/Users/ict/development/flutter/bin/flutter",
        widget_guides = { enabled = true },
        closing_tags = { highlight = "Comment", prefix = "󰜬 " },
        dev_log = { enabled = false },
        dev_tools = { autostart = true, auto_open_browser = false },
        lsp = {
          color = {
            enabled = true,
            foreground = true,
            virtual_text = true,
            virtual_text_str = "■",
          },
          settings = {
            lineLength = vim.o.textwidth,
            showTodos = false,
            completeFunctionCalls = true,
            enableSnippets = false,
            updateImportsOnRename = true,
            renameFilesWithClasses = "prompt",
            enableSdkFormatter = false,
            analysisExcludedFolders = { os.getenv("HOME") .. "/development/flutter/packages" },
          },
        },
      })
    end,
  },
}
