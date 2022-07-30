# stay-centered.nvim

## Install

Using Packer:
```
use "arnamak/stay-centered.nvim"
```

## Enable
```
require("stay-centered")
```

## Summary

A simple `autocmd` that keeps your cursor at the center of the screen in all contexts.
No jerkiness when changing modes or jumping to different LOCs.

Replacement for what you might typically do in keybindings such as:
```
nnoremap "j" "jzz"
nnoremap "n" "nzzzv"
...
etc
```

Using `autocmd` and `CursorMoved`/`CursorMovedI` events, `zz` is applied to every keystroke that would change the cursor position.
Minorly optimized by only applying `zz` to vertical line movement.

Should not get in the way of plugins like `auto-pairs` or `compe`, which tend to have their own mappings for `<CR>`.

## Options

If there are certain filetypes you'd like to omit from this functionality, you can do so by setting the following variable before enabling `stay-centered.nvim`:

```
vim.api.nvim_set_var('stay-centered#skip_filetypes', { "lua" })
```

The filetype is determined by the vim filetype, not the file extension. In order to get the filetype, open a file and run the command:

```
:vim.bo.filetype
```

#### Example

```
// someFile.ts

const myVar
...etc

:lua print(vim.bo.filetype)
#=> typescript
```

```
// plugins.lua
vim.api.nvim_set_var('stay-centered#skip_filetypes', { "typescript" })

return packer.startup(
  function()
    use "wbthomason/packer.nvim"
    use "arnamak/stay-centered.nvim"
    ...
  end
)
```
Obviously, you can set that variable anywhere, so long as it is before you initialize `stay-centered`.

You may specify multiple filetypes, comma separated, within the table.
