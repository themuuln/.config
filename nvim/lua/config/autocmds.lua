-- disable conceal level on json
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "json", "jsonc", "markdown" },
--   callback = function()
--     vim.opt.conceallevel = 1
--   end,
-- })

local last_env = nil
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local filetype = vim.bo.filetype
    if filetype ~= "http" then
      return
    end

    local filename = vim.fn.expand("%:t"):lower()
    local kulala = require("kulala")

    local selected_env = filename:match("sso") and "testsso" or "test"

    if selected_env ~= last_env then
      kulala.set_selected_env(selected_env)

      vim.notify("🌱 Kulala: Switched to `" .. selected_env .. "` environment", vim.log.levels.INFO, {
        title = "kulala.nvim",
      })

      last_env = selected_env
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "http",
  callback = function()
    vim.keymap.set("n", "<CR>", function()
      require("kulala").run()
    end, { buffer = true, desc = "Run HTTP request with kulala" })
  end,
})
