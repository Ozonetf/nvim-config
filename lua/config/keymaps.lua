-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open)
vim.keymap.set("n", "<leader>rn", ":IncRename ")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("x", "p", '"_dP')
vim.keymap.set("i", "lkj", "<Esc>")
