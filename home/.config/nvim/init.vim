" Old configurations from vim. Not sure if needed in nvim.
" syntax on
" " Wrap gitcommit file types at the appropriate length
" filetype indent plugin on

call plug#begin()

" https://github.com/doums/darcula
Plug 'doums/darcula'

call plug#end()

" https://github.com/doums/darcula
colorscheme darcula
set termguicolors

call darcula#Hi('comment', darcula#palette.comment, darcula#palette.null, 'italic')
call darcula#Hi('Normal', darcula#palette.fg, [ '#000000', 250 ])
