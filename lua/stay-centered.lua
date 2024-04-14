local M = {}

M.cfg = {
	skip_filetypes = {},
	enabled = true,
	allow_scroll_move = true,
}

M.setup = function(ctx)
	if ctx == nil then
		return
	end

	M.cfg.skip_filetypes = ctx.skip_filetypes or {}
	if type(ctx.enabled) == "boolean" then
		M.cfg.enabled = ctx.enabled
	end
	if type(ctx.allow_scroll_move) == "boolean" then
		M.cfg.allow_scroll_move = ctx.allow_scroll_move
	end
end

local mode = require("mode")
local plugin = require("plugin")

local add_group = vim.api.nvim_create_augroup
local group = add_group("StayCentered", { clear = true })

local add_command = vim.api.nvim_create_autocmd
add_command("CursorMovedI", {
	group = group,
	callback = function()
		plugin.stay_centered({ mode = mode.insert, cfg = M.cfg })
	end,
})
add_command("CursorMoved", {
	group = group,
	callback = function()
		plugin.stay_centered({ mode = mode.other, cfg = M.cfg })
	end,
})
add_command("BufEnter", {
	group = group,
	callback = function()
		plugin.stay_centered({ mode = mode.other, cfg = M.cfg })
	end,
})

M.enable = function()
	M.cfg.enabled = true

	plugin.stay_centered({ mode = mode.other, cfg = M.cfg })
end

M.disable = function()
	M.cfg.enabled = false
end

M.toggle = function()
	if M.cfg.enabled then
		M.disable()
	else
		M.enable()
	end
end

return M
