local M = {}

M.cfg = {
	skip_filetypes = {},
	enabled = true, -- takes precedence over `active`
	active = true, -- for internally disabling plugin behavior
	allow_scroll_move = true,
	disable_on_mouse = true,
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
	if type(ctx.disable_on_mouse) == "boolean" then
		M.cfg.disable_on_mouse = ctx.disable_on_mouse
	end

	if M.cfg.disable_on_mouse then
		M.mcb_id = vim.on_key(M.mouse_callback)
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

M.activate = function()
	M.cfg.active = true
end

M.deactivate = function()
	M.cfg.active = false
end

M.mouse_callback = function(key, typed)
	if not M.cfg.enabled then
		return
	end

	if key == vim.api.nvim_replace_termcodes("<LeftMouse>", true, true, true) then
		M.deactivate()
	end
	if key == vim.api.nvim_replace_termcodes("<LeftDrag>", true, true, true) then
	end
	if key == vim.api.nvim_replace_termcodes("<LeftRelease>", true, true, true) then
		vim.b.last_line = vim.api.nvim_win_get_cursor(0)[1]
		M.activate()
	end
end

return M
