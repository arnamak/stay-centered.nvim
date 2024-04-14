# stay-centered.nvim

A simple `autocmd` that keeps your cursor at the center of the screen in all contexts.
No jerkiness when changing modes or jumping to different LOCs.

Replacement for what you might typically do in keybindings such as:
```vim
nnoremap "j" "jzz"
nnoremap "n" "nzzzv"
" ...
" etc
```

Using `autocmd` and `CursorMoved`/`CursorMovedI` events, `zz` is applied to every keystroke that would change the cursor position.
Minorly optimized by only applying `zz` to vertical line movement.

Should not get in the way of plugins like `auto-pairs` or `nvim-cmp`, which tend to have their own mappings for `<CR>`.

## Install

Using Lazy:
```lua
{
  'arnamak/stay-centered.nvim'
}
```

Using Packer:
```lua
use 'arnamak/stay-centered.nvim'
```

## Options

```lua
require('stay-centered').setup({
  -- The filetype is determined by the vim filetype, not the file extension. In order to get the filetype, open a file and run the command:
  -- :lua print(vim.bo.filetype)
  skip_filetypes = {}
  -- Set to false to disable by default
  enabled = true,
})
```

### Examples

In Lazy:
```lua
{
  'arnamak/stay-centered.nvim'
  opts = {
    skip_filetypes = { 'lua', 'typescript' },
  }
}
```

In Packer
```lua
use {
  'arnamak/stay-centered.nvim',
  config = function()
    require('stay-centered').setup({
      skip_filetypes = { 'lua', 'typescript' }
    })
  end
}
```

## Enabling/Disabling with Keymap

`stay-centered.nvim` has built in functions `enable`, `disable`, and `toggle` to handle this behaviour.

Example for toggling on keymap:

```lua
vim.keymap.set({ 'n', 'v' }, '<leader>st', require('stay-centered').toggle, { desc = 'Toggle stay-centered.nvim' })
```

## Alternatives

Setting `scrolloff=1000` will achieve similar effects, albeit with a few key differences:
- Scrolling (e.g. mouse, `<C-e>`, `<C-y>`, etc.) will always move the cursor
- Padding on the bottom of the screen will not be added
- Using this large of a scroll off prevents commands like `zt`, `zb`, `H`, `L` from doing anything
