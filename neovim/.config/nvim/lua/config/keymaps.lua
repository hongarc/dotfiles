-- Keymaps are automatically loaded on the VeryLazy event
-- Default LazyVim keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add custom keymaps below

-- =========================================================
-- Colemak Layout Navigation Remapping
-- =========================================================

-- Remap hnei -> hjkl for normal and visual modes
vim.keymap.set({ "n", "v" }, "n", "j") -- Move down
vim.keymap.set({ "n", "v" }, "e", "k") -- Move up
vim.keymap.set({ "n", "v" }, "i", "l") -- Move right
-- h stays the same (move left)

-- Remap Shift + hnei -> Shift + hjkl
vim.keymap.set({ "n", "v" }, "H", "<cmd>bprevious<cr>") -- Previous buffer
vim.keymap.set({ "n", "v" }, "N", "J") -- Move line down
vim.keymap.set({ "n", "v" }, "E", "K") -- Move line up
vim.keymap.set({ "n", "v" }, "I", "<cmd>bnext<cr>") -- Next buffer

-- Remap hjkl -> hnei for consistency
vim.keymap.set({ "n", "v" }, "j", "n") -- Alias j -> n
vim.keymap.set({ "n", "v" }, "k", "e") -- Alias k -> e
vim.keymap.set({ "n", "v" }, "l", "i") -- Alias l -> i
-- h stays the same

-- Remap Shift + hjkl -> Shift + hnei
vim.keymap.set({ "n", "v" }, "J", "N") -- Alias J -> N
vim.keymap.set({ "n", "v" }, "K", "E") -- Alias K -> E
vim.keymap.set({ "n", "v" }, "L", "I") -- Alias L -> I
-- H stays the same

-- =========================================================
-- Window Navigation (Normal + Terminal modes)
-- =========================================================

-- Right split
vim.keymap.set("n", "<C-i>", "<C-w>l", { desc = "Go to Right Window" })

-- Normal mode navigation
vim.keymap.set("n", "<C-n>", "<C-w>j", { desc = "Go to Lower Window (alias of <C-j>)", remap = true })
vim.keymap.set("n", "<C-e>", "<C-w>k", { desc = "Go to Upper Window (alias of <C-k>)", remap = true })

-- Terminal mode navigation (must exit insert first)
vim.keymap.set("t", "<C-n>", [[<C-\><C-n><C-w>j]], { desc = "Go to Lower Window (alias of <C-j>)" })
vim.keymap.set("t", "<C-e>", [[<C-\><C-n><C-w>k]], { desc = "Go to Upper Window (alias of <C-k>)" })

-- =========================================================
-- Miscellaneous
-- =========================================================

-- Scroll down (alias Ctrl+l)
vim.keymap.set("n", "<C-l>", "<C-d>", { desc = "Scroll Down (alias of <C-d>)" })
