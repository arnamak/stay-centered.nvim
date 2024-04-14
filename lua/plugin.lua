local mode = require("mode")

local function must_skip_file(skip_filetypes, current_type)
	if skip_filetypes == nil then
		return false
	end

	for _, value in ipairs(skip_filetypes) do
		if value == current_type then
			return true
		end
	end

	return false
end

local function stay_centered(ctx)
	if not ctx.cfg.enabled then
		return
	end
	if must_skip_file(ctx.cfg.skip_filetypes, vim.bo.filetype) then
		return
	end

	local line = vim.api.nvim_win_get_cursor(0)[1]
	if vim.b.last_line == nil then
		vim.b.last_line = line
	end

	-- check if cursor moved from window scroll
	if ctx.cfg.allow_scroll_move then
		if
			(line == vim.fn.line("w0") and line > vim.b.last_line)
			or (line == vim.fn.line("w$") and line < vim.b.last_line)
		then
			vim.b.last_line = line
			return
		end
	end

	if line ~= vim.b.last_line then
		vim.cmd("norm! zz")
		vim.b.last_line = line
		if ctx.mode == mode.insert then
			local column = vim.fn.getcurpos()[5]
			vim.fn.cursor({ line, column })
		end
	end
end

return {
	stay_centered = stay_centered,
}
