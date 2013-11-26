call pathogen#infect()
call pathogen#helptags()
set relativenumber
set nocompatible
set hidden
set history=1000
set wildmenu
set ignorecase
set smartcase
set scrolloff=3
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set t_ti= t_te=

set iskeyword+=- " words with dashes count as single words for autocompletion
set iskeyword+=? " words with dashes count as single words for autocompletion

set backspace=indent,eol,start

if has("vms")
  set nobackup
else
  set backup
endif
set ruler
set showcmd

map Q qq

syntax on
set hlsearch
set guifont=Inconsolata:h14
set guioptions-=T
set guioptions-=L
set guioptions-=L
set guioptions-=r
set guioptions-=R


augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 
  autocmd! BufRead,BufNewFile *.jbuilder setfiletype ruby 

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off
augroup END

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch
set incsearch
set hls

" :set t_Co=256 " 256 colors
:color solarized
set background=light

let mapleader=","
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
:hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

function! RunTests(target, args)
    silent ! echo
    exec 'silent ! echo -e "\033[1;36mRunning tests in ' . a:target . '\033[0m"'
    silent w
    exec "make " . a:target . " " . a:args
endfunction

set cursorline
set cmdheight=2

autocmd! BufRead,BufNewFile *.sass setfiletype sass
autocmd BufRead,BufNewFile *.html source ~/.vim/indent/html.vim

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'))
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>


command! W :w
command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

set showtabline=2

map <leader>gr :topleft :split config/routes.rb<cr>

" map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
" map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
" map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
" map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
" map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
" map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
" map <leader>gs :CommandTFlush<cr>\|:CommandT app/assets/stylesheets<cr>
" map <leader>gj :CommandTFlush<cr>\|:CommandT app/assets/javascripts<cr>
" map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
" map <leader>gg :topleft 100 :split Gemfile<cr>
" map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

let g:ctrlp_working_path_mode = 2
let g:ctrlp_max_height = 20
" let g:ctrlp_user_command = 'find %s -type f'       " MacOSX/Linux
" let g:ctrlp_dotfiles = 0

let g:ctrlp_custom_ignore = {
    \ 'dir':  'log$\|tmp$\|\.sass-cache$\|\.git$\|\.hg$\|\.svn$\|vendor$',
    \ 'file': '\.DS_STORE$\|tags',
    \ 'link': '',
    \ }

" On OSX
" vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
" nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>p

" Better copy paste integration
map <leader>v :r !pbpaste<cr>

set winwidth=84

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

imap <c-l> <space>=><space>

function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\)" | cut -d " " -f 3')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

if &diff
  nmap <c-h> :diffget 1<cr>
  nmap <c-l> :diffget 3<cr>
  nmap <c-k> [cz.
  nmap <c-j> ]cz.
  set nonumber
endif

map <c-c> <esc>


set ttimeoutlen=50  " Make Esc work faster

" Enable > indent and < unindent
vnoremap <silent> > >gv
vnoremap <silent> < <gv

" " " Switch between buffers
" noremap <silent> <c-]> :bn<CR>
" noremap <silent> <c-[> :bp<CR>
 
" Close buffer
nmap <leader>d :bprevious<CR>:bdelete #<CR>
 
" Close all buffers
nmap <leader>D :bufdo bd<CR>
 
" Switch between last two buffers
nnoremap <leader><leader> <C-^>
 
" Map ESC
imap jj <ESC>

let coffee_compile_vert = 1
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
au BufNewFile,BufReadPost *.scss setl foldmethod=indent
au BufNewFile,BufReadPost *.sass setl foldmethod=indent
au BufRead,BufNewFile *.scss set filetype=scss

" Execute current buffer as Ruby
map <S-r> :w !ruby<CR> 

nnoremap <leader>c :set background=dark<cr>

set colorcolumn=80
:nnoremap <leader><space> :nohlsearch<cr>

iabbrev rdebug    require 'ruby-debug'; Debugger.start; Debugger.settings[:autoeval] = 1; Debugger.settings[:autolist] = 1; debugger

set shell=/bin/sh
set nofoldenable " Say no to code folding...

set grepprg=ag

map <C-n> :cn<CR>
map <C-p> :cp<CR>

vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

let g:ctrlp_map = '<Leader>f'

au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" let g:snips_trigger_key='<c-\>'
:imap <C-\> <Plug>snipMateNextOrTrigger
:smap <C-\> <Plug>snipMateNextOrTrigger
:imap <C-J> <Plug>snipMateShow

" Poweline customizations
let g:html_indent_tags = 'p\|li\|nav'

" map <leader>r :w\|:!ruby %<cr>
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

"load ftplugins and indent files
filetype plugin on
filetype indent on

set tags=.tags;/

set complete=.,b,u,]
" let g:vroom_map_keys = 0
" map <leader>t VroomRunTestFile()
" map <leader>T VroomRunNearestTest()

:nmap <silent> <leader>d <Plug>DashGlobalSearch
autocmd Filetype gitcommit setlocal spell textwidth=72

map <Leader>i mmgg=G`m<CR>
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>


if has("mouse")
  set mouse=a
endif

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
