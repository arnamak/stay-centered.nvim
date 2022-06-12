local ac = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
local getCursor = vim.api.nvim_win_get_cursor

function StayCentered(inInsert)
    local line = getCursor(0)[1]
    if line ~= vim.b.last_line then
        vim.cmd('norm! zz')
        vim.b.last_line = line
        if inInsert then
            local column = vim.fn.getcurpos()[5]
            vim.fn.cursor(line, column)
        end
    end
end

local group = ag('StayCentered', { clear = true })
ac('CursorMovedI', {
    group = group,
    callback = function()
        StayCentered(true)
    end,
})
ac('CursorMoved', {
    group = group,
    callback = function()
        StayCentered(false)
    end,
})
