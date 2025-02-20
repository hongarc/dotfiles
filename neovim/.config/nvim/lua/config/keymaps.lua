-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Basic remapping for navigation with Colemak layout

-- Map hnei to behave as hjkl in both normal and visual modes
-- vim.keymap.set({ "n", "v" }, "h", "h") -- Move left
vim.keymap.set({ "n", "v" }, "n", "j") -- Move down
vim.keymap.set({ "n", "v" }, "e", "k") -- Move up
vim.keymap.set({ "n", "v" }, "i", "l") -- Move right

-- Map Shift + hnei to behave as Shift + hjkl in both normal and visual modes
vim.keymap.set({ "n", "v" }, "H", "<cmd>bprevious<cr>") -- Move left (Shift)
vim.keymap.set({ "n", "v" }, "N", "J") -- Move down (Shift)
vim.keymap.set({ "n", "v" }, "E", "K") -- Move up (Shift)
vim.keymap.set({ "n", "v" }, "I", "<cmd>bnext<cr>") -- Move right (Shift)

-- Map hjkl back to behave as hnei in both normal and visual modes
vim.keymap.set({ "n", "v" }, "j", "n") -- Move down
vim.keymap.set({ "n", "v" }, "k", "e") -- Move up
vim.keymap.set({ "n", "v" }, "l", "i") -- Move right

-- Map Shift + hjkl back to behave as Shift + hnei in both normal and visual modes
vim.keymap.set({ "n", "v" }, "J", "N") -- Move down (Shift)
vim.keymap.set({ "n", "v" }, "K", "E") -- Move up (Shift)
vim.keymap.set({ "n", "v" }, "L", "I") -- Move right (Shift)

-- Map Ctrl + h to move to the left split in normal mode
-- vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-n>", "<C-w>j") -- Move to the split below
vim.keymap.set("n", "<C-e>", "<C-w>k") -- Move to the split above
vim.keymap.set("n", "<C-i>", "<C-w>l") -- Move to the right split
