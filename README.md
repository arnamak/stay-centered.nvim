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

This is a really simple replacement for what you might typically do in a keybinding such as:
```
nnoremap "j" "jzz"
nnoremap "n" "nzzzv"
...
etc
```

Instead, using `autocmd` and `CursorMove`/`CursorMoveI`, `zz` is applied to every keystroke.
Minorly optimized by only applying `zz` to vertical movement.

Should not get in the way of plugins like `auto-pairs` or `compe` (which can be problematic in insert mode)

Should stay centered with minimal jerky-ness no matter what.

Will update to lua once we can do `autocmd`. Until then, vimscript seems slightly more performant.
