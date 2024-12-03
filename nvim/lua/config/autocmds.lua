-- Flag to track if the maximize feature is enabled
local maximize_enabled = false

-- Augroup names
local maximize_group = "MaximizeWindow"
local balance_group = "BalanceWindows"

-- Function to maximize the current window
local function maximize_current_window()
  local win_id = vim.api.nvim_get_current_win()
  vim.cmd("wincmd =") -- Balance windows first
  vim.api.nvim_win_set_height(win_id, vim.o.lines - 2) -- Max height
  vim.api.nvim_win_set_width(win_id, vim.o.columns) -- Max width
end

-- Function to equalize all window sizes
local function equalize_windows()
  vim.cmd("wincmd =")
end

-- Function to toggle the maximize feature
local function toggle_maximize()
  maximize_enabled = not maximize_enabled
  if maximize_enabled then
    -- Enable maximize on focus
    vim.api.nvim_create_augroup(maximize_group, { clear = true }) -- Ensure the group is clear
    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
      group = maximize_group,
      callback = maximize_current_window,
    })
    -- Enable balance on leave
    vim.api.nvim_create_augroup(balance_group, { clear = true }) -- Ensure the group is clear
    vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
      group = balance_group,
      callback = equalize_windows,
    })
    -- Maximize the current window immediately upon enabling
    maximize_current_window()
    print("Window maximize feature enabled")
  else
    -- Disable maximize and balance by clearing the augroups
    pcall(vim.api.nvim_del_augroup_by_name, maximize_group) -- Remove maximize autocommand group
    pcall(vim.api.nvim_del_augroup_by_name, balance_group) -- Remove balance autocommand group
    -- Equalize all windows immediately upon disabling
    equalize_windows()
    print("Window maximize feature disabled and windows equalized")
  end
end

-- Keybinding to toggle the maximize feature
vim.keymap.set("n", "<leader>wt", toggle_maximize, { desc = "Toggle Maximize Focused Window" })
