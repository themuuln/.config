return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- toggle comments based on project
      ensure_installed = {
        -- must
        "lua",
        "regex",
        "vim",
        "yaml",
        "json",
        -- Web Development
        "html",
        "javascript",
        "typescript",
        "tsx",
        "astro",
        "css",
        -- other
        "http",
        "graphql",
        "markdown",
        "markdown_inline",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- 1. web development
        "prettier",
        "tailwindcss-language-server",
        "typescript-language-server",
        -- 2. must
        "json-lsp",
        "lua-language-server",
        -- 3. other
        "stylua",
        "prettier",
      },
    },
  },
  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
    },
  },
}
