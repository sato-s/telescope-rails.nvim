test
# telescope-rails.nvim

[ctrlp-rails](https://github.com/iurifq/ctrlp-rails.vim) for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## Installation

```
Plug 'nvim-telescope/telescope.nvim'
Plug 'sato-s/telescope-rails.nvim'
```

## Setup

Load this extension.

```
require("telescope").load_extension("rails")
```

(optional) Add shortcuts.
```
nnoremap <leader>rs :Telescope rails specs<CR>
nnoremap <leader>rc :Telescope rails controllers<CR>
nnoremap <leader>rm :Telescope rails models<CR>
```

## Usage


```
:Telescope rails controllers
:Telescope rails specs
:Telescope rails models
```

