return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "flash_500",
      windows = { ask = { floating = true } },
      vendors = {
        pro = {
          __inherited_from = "gemini",
          model = "gemini-2.5-pro-preview-03-25",
          api_key_name = "GEMINI_API",
          timeout = 30000,
          temperature = 0,
        },
        flash_500 = {
          __inherited_from = "gemini",
          model = "gemini-2.5-flash-preview-04-17",
          api_key_name = "GEMINI_API",
          timeout = 30000,
          temperature = 0,
        },
        flash_1500 = {
          __inherited_from = "gemini",
          model = "gemini-2.0-flash",
          api_key_name = "GEMINI_API",
          timeout = 30000,
          temperature = 0,
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = true,
        minimize_diff = false,
        enable_token_counting = true,
        enable_cursor_planning_mode = true,
        enable_claude_text_editor_tool_mode = true,
      },
    },
    build = "make",
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
}
