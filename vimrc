" ==========自动下载插件管理工具==========
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ==========插件管理工具==========
call plug#begin('~/.vim/plugged')

" Ag的VIM插件
Plug 'rking/ag.vim'
" 快速打开文件的插件，使用C+P
Plug 'ctrlpvim/ctrlp.vim'
" 补全插件
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
Plug 'vim-scripts/javacomplete'
Plug 'vim-scripts/JavaBrowser'
Plug 'vim-scripts/taglist.vim'

" 装13用的
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 加强？\
Plug 'haya14busa/incsearch.vim'
" 当前跳转查件
Plug 'Lokaltog/vim-easymotion'
" git加亮
Plug 'mhinz/vim-signify'
" 括号之类的快速插入，主要命令cs替换, ds删除, ys插入
Plug 'tpope/vim-surround'
" 快速注释, 使用gc
Plug 'tpope/vim-commentary'
" 异步插件
Plug 'tpope/vim-dispatch'
" 平滑移动插件
Plug 'yonchu/accelerated-smooth-scroll'
" 文件树
Plug 'vim-scripts/The-NERD-tree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" 变量查看窗口
Plug 'majutsushi/tagbar'
" lua
Plug 'vim-scripts/lua.vim'
Plug 'xolox/vim-misc'

" Python的自动缩进，支持PEP8
Plug 'vim-scripts/indentpython.vim'

Plug 'jlanzarotta/bufexplorer'


call plug#end()


" ==========插件配置==========

" Ag插件
let g:ag_prg="ag --vimgrep"
let g:ag_highlight=1

" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

" YouCompleteMe
let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_strings = 1
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_confirm_extra_conf=0

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

" 加强\?
set hlsearch
let g:incsearch#auto_nohlsearch = 1

" easymotion
nnoremap s <Plug>(easymotion-overwin-f2)

" The-NERD-tree
let g:NERDTreeDirArrows = 1
let NERDTreeIgnore=['\.pyc','\~$','\.swp','\.o', '\.so']
" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let NERDTreeWinSize=31
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" TagbarToggle
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_width=30
" 不自动打开tarbar
" autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.py call tagbar#autoopen()

" lua
let g:lua_compiler_name = '/usr/local/bin/luac'


"Quickly Run
""""""""""""""""""""""
map <C-r> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!ctags -R --languages=c,c++ --c-kinds=+cdefglmnpstuvx --fields=+aiKSz --extra=+q"
    elseif &filetype == 'cpp'
        exec "!ctags -R --languages=c,c++ --c++-kinds=+cdefglmnpstuvx --fields=+aiKSz --extra=+q"
    elseif &filetype == 'java'
        exec "!ctags -R --languages=java --java-kinds=+cefgilmp --fields=+aiKSz --extra=+q"
    elseif &filetype == 'sh'
        exec "!ctags -R *"
    elseif &filetype == 'scala'
        exec "!ctags -R *"
    elseif &filetype == 'lua'
        exec "!ctags -R --lua-kinds=+f --fields=+aiKSz --extra=+q"
    elseif &filetype == 'python'
        exec "!ctags -R --languages=python --python-kinds=+cfmvi --fields=+aiKSz --extra=+q"
    elseif &filetype == 'html'
        exec "!ctags -R --languages=html --html-kinds=+af --fields=+aiKSz --extra=+q"
    elseif &filetype == 'go'
        exec "!ctags -R *"
    endif
endfunc


" ==========常规配置==========
let mapleader = "\<Space>"
set number
set nobackup
set ignorecase smartcase
set incsearch
set hlsearch
set showmatch
set matchtime=1
set tabstop=4
set softtabstop=4
set shiftwidth=4
set laststatus=2
set expandtab
set autoindent
set fileformat=unix
set encoding=utf-8
let python_highlight_all=1

" ==========bufexplorer=========
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowNoName=0        " Do not 'No Name' buffers.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split Vertical.

" ==========按键映射==========
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>a :Ag<Space>
map <Leader>y "+y
map <Leader>p "+p
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
nmap    w=  :resize +3<CR>
nmap    w-  :resize -3<CR>
nmap    w,  :vertical resize -3<CR>
nmap    w.  :vertical resize +3<CR>
nnoremap <Leader>D :Dispatch<Space>
nnoremap <Leader>F :FocusDispatch<Space>
nnoremap <Leader>1 :NERDTreeToggle<CR>
nnoremap <Leader>2 :TagbarToggle<CR>
nnoremap <leader>3 :YcmToggleLogs stderr<CR>
nnoremap <Leader>d :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>g :YcmCompleter GoToDefinition<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ====模板
autocmd BufNewFile *.py 0r ~/.vim/template/python
