-- import nvim-cmp plugin safely
local setup, nim = pcall(require, "nim")
if not nim then
	return
end
