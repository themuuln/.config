return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "html",
        "javascript",
        "lua",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "http",
        "graphql",
        "json",
        "json5",
        "dart",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "astro",
        "css",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "prettier",
        "dart-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "prettier",
        "tailwindcss-language-server",
        "typescript-language-server",
      },
    },
  },
  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
    },
  },
}
