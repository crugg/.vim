if ! has("gui_running")
  set t_Co=256
endif
set background=dark
colors peaksea
syntax on

set ruler
set mouse=a
set hlsearch
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

let g:black_linelength = 99
let g:black_skip_string_normalization = ""

set backspace=indent,eol,start

iab pdb import pdb; pdb.set_trace()

" CTRL-X, CTRL-C, CTRL-V for Cut, Copy, Paste
vnoremap <C-X> "+x
vnoremap <C-C> "+y
map <C-V>   	"+gP
cmap <C-V>  	<C-R>+

" CTRL-S for Save
map <C-S> "+w

" CTRL-Z for Undo
map <C-Z> "+undo
map <C-Y> "+redo

" Q to quit
map Q :qa<CR>

"j, i, k, l for Left Arrow, Up Arrow, Down Arrow, and Right Arrow
map a <Insert>
map i <Up>
map k <Down>
map j <Left>

" Set Left & Right to wrap around lines
set ww+=<,>,[,]
set ve=onemore

:highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkRed
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkRed
:match ExtraWhitespace /\s\+$/

" XCode-style auto-indentation
map <Tab> "+=l
" the following isn't quite working properly just yet
" imap <Tab> <Esc>:norm mz<CR>=l:norm `z<CR>li
set shiftwidth=4
set expandtab
set softtabstop=4
if has("autocmd")
  filetype plugin indent on
  filetype plugin on
endif

" Shift-arrows to select
nmap <S-Up> vi
nmap <S-Down> vk
nmap <S-Left> vj
nmap <S-Right> vl
vmap <S-Up> i
vmap <S-Down> k
vmap <S-Left> j
vmap <S-Right> l

" autocmd VimEnter * NERDTree | wincmd p

"set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P
set laststatus=2
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

"set statusline=
"set statusline+=%#PmenuSel#
"set statusline+=%{StatuslineGit()}
"set statusline+=%#LineNr#
"set statusline+=\ %f
"set statusline+=%m\
"set statusline+=%=
"set statusline+=%#CursorColumn#
"set statusline+=\ %y
"set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
"set statusline+=\[%{&fileformat}\]
"set statusline+=\ %p%%
"set statusline+=\ %l:%c
"set statusline+=\ 

" Status line - changes colors depending on insert mode
hi StatusLine     cterm=reverse guifg=#666666   guibg=#1b1b1b   gui=none  ctermfg=245 ctermbg=236
hi StatusLineNC   cterm=none    guifg=#444444   guibg=#1b1b1b   gui=none  ctermfg=239 ctermbg=235
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guifg=#DA4939   guibg=#1b1b1b   gui=none  ctermfg=167 ctermbg=236
  elseif a:mode == 'r'
    hi statusline guifg=#0b0b0b   guibg=#DA4939   gui=none  ctermfg=236 ctermbg=167
  else
    hi statusline guifg=#666666   guibg=#1b1b1b   gui=none  ctermfg=245 ctermbg=236
  endif
endfunction
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline    guifg=#666666   guibg=#1b1b1b   gui=none  ctermfg=245 ctermbg=236

au filetype cucumber setlocal mp=bundle\ exec\ cucumber\ -c\ -f\ pretty\ %

set scrolloff=5

" Better keybinding for NERDCommenter toggle
vmap <silent> / :call NERDComment('nx', 'Toggle')<CR>

" Allow ESC to cancel autocomplete popup
" (commented out for now, it's not working quite right)
"inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"

" Map Ctrl-K to Command-T popup
nmap <C-k> "+:CommandT<CR>
let g:CommandTCancelMap=['<C-c>', '<C-e>']

" Set nowrap with fancy indicator characters
set nowrap
"set listchars+=precedes:←,extends:→
set sidescroll=20
hi NonText     guifg=#ffffff

" Turn off annoying backup and swap files
set nobackup
set noswapfile

:filetype plugin on

" CSV plugin default delimiters, to eliminate warning
let b:col='\%([^,]*,\|$\)'
