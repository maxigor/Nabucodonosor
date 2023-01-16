opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & identation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
-- opt.background = "dark"
opt.signcolumn = "yes"

opt.hlsearch = false
opt.incsearch = true

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.o.clipboard = "unnamed,unnamedplus"
