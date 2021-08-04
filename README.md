# stay-centered.nvim

## Install

Using Packer:
```
use "arnamak/stay-centered.nvim"
```

## Enable
**Note**: You will probably want to disable scrolloff (`set scrolloff=0`)
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

Will update to lua once we can do `autocmd` natively. Until then, vimscript seems slightly more performant.
