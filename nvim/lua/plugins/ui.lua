return {
  require("treesitter-context").setup({
    multiwindow = true,
    trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
  }),

  -- -- turn off inlay hint by default
  -- { "neovim/nvim-lspconfig", opts = { inlay_hints = { enabled = false } } },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local LazyVim = require("lazyvim.util")
      opts.sections.lualine_c[1] = {}
    end,
  },
}
