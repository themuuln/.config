local function countLspRefs()
  local icon = "󰈿" -- CONFIG

  local client = vim.lsp.get_clients({ method = "textDocument/references", bufnr = 0 })[1]
  if not client then
    return ""
  end

  -- prevent multiple requests on still cursor without the need of autocmds
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local sameCursorPos = row == vim.b.lspReference_lastRow and col == vim.b.lspReference_lastCol

  if not sameCursorPos then
    vim.b.lspReference_lastRow, vim.b.lspReference_lastCol = row, col

    local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
    params.context = { includeDeclaration = true } ---@diagnostic disable-line: inject-field
    local thisFile = params.textDocument.uri

    client:request("textDocument/references", params, function(error, refs)
      if error or not refs then -- not on a valid symbol, etc.
        vim.b.lspReference_count = nil
        return
      end
      local refsInFile = vim
        .iter(refs)
        :filter(function(r)
          return thisFile == r.uri
        end)
        :totable()
      local inFile, inWorkspace = #refsInFile - 1, #refs - 1 -- -1 for current occurrence
      local text = inFile == inWorkspace and inFile or (inFile .. "(" .. inWorkspace .. ")")

      vim.b.lspReference_count = inWorkspace > 0 and vim.trim(icon .. " " .. text) or nil
    end)
  end

  return vim.b.lspReference_count or "" -- returns empty string at first and later the count
end

--------------------------------------------------------------------------------

return {
  "nvim-lualine/lualine.nvim",
  event = "UIEnter",
  opts = {
    options = {
      globalstatus = true,
      always_divide_middle = false,
      ignore_focus = { "snacks_input", "snacks_picker_input" },
    },
    sections = {
      lualine_a = {
        {
          "branch",
          icon = "",
          cond = function() -- only if not on main or master
            local curBranch = require("lualine.components.branch.git_branch").get_branch()
            return curBranch ~= "main" and curBranch ~= "master" and vim.bo.buftype == ""
          end,
        },
      },
      lualine_b = { { "buffers" } },
      lualine_c = { { countLspRefs } },
      lualine_x = {
        { -- recording status
          function()
            return ("Recording [%s]…"):format(vim.fn.reg_recording())
          end,
          icon = "󰑊",
          cond = function()
            return vim.fn.reg_recording() ~= ""
          end,
          color = "ErrorMsg",
        },
        { -- Quickfix counter
          function()
            local qf = vim.fn.getqflist({ idx = 0, title = true, items = true })
            if #qf.items == 0 then
              return ""
            end
            return (" %d/%d (%s)"):format(qf.idx, #qf.items, qf.title)
          end,
        },
        {
          "fileformat",
          icon = "󰌑",
          cond = function()
            return vim.bo.fileformat ~= "unix"
          end,
        },
        {
          "diagnostics",
          symbols = { error = "󰅚 ", warn = " ", info = "󰋽 ", hint = "󰘥 " },
          cond = function()
            return vim.diagnostic.is_enabled({ bufnr = 0 })
          end,
        },
        {
          "lsp_status",
          icon = "",
          ignore_lsp = { "typos_lsp", "efm" },
          -- only show component if LSP is active
          cond = function()
            if vim.g.lualine_lsp_active ~= nil then
              return vim.g.lualine_lsp_active
            end
            vim.g.lualine_lsp_active = false
            -- ^ so autocmd is only created once

            vim.api.nvim_create_autocmd("LspProgress", {
              desc = "User: Hide LSP progress component after 2s",
              callback = function()
                vim.g.lualine_lsp_active = true
                vim.defer_fn(function()
                  vim.g.lualine_lsp_active = false
                end, 2000)
              end,
            })
          end,
        },
      },
      lualine_y = {
        {
          function()
            return vim.api.nvim_buf_line_count(0) .. " "
          end,
          cond = function()
            return vim.bo.buftype == ""
          end,
        },
        {
          function()
            return vim.o.foldlevel
          end,
          icon = "󰘖",
          cond = function()
            return vim.o.foldlevel > 0 and vim.o.foldlevel ~= 99
          end,
        },
      },
      lualine_z = {
        { "selectioncount", icon = "󰒆" },
        { "location" },
      },
    },
  },
}
