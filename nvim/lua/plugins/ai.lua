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
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
        minimize_diff = true,
        enable_token_counting = false,
        enable_cursor_planning_mode = true,
        enable_claude_text_editor_tool_mode = true,
      },
    },
    build = "make",
    dependencies = {
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
    },
  },
}
