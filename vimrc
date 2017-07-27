" 定义快捷键的前缀，即<Leader>
let mapleader=";"

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 定义快捷键到行首和行尾
nmap lb 0
nmap le $
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>
" 依次遍历子窗口
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j
" 定义快捷键在结对符之间跳转，助记pair
nmap <Leader>pa %

" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu

" 将 pathogen 自身也置于独立目录中，需指定其路径
runtime bundle/pathogen/autoload/pathogen.vim
" 运行 pathogen
execute pathogen#infect()

" 配色方案
set background=dark
"set background=light
"colorscheme solarized
colorscheme molokai
"colorscheme phd
"colorscheme Tomorrow-Night
"colorscheme github

" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch

" 设置 gvim 显示字体
set guifont=YaHei\ Consolas\ Hybrid\ 11.5

" 禁止折行
set nowrap

" 设置状态栏主题风格
let g:Powerline_colorscheme='solarized256'

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
"set expandtab
" 设置编辑时制表符占用空格数
set tabstop=8
" 设置格式化时制表符占用空格数
set shiftwidth=8
" 让 vim 把连续数量的空格视为一个制表符
"set softtabstop=4
set cino+=:0

" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=0
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle

" 基于缩进或语法进行代码折叠
set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" *.cpp 和 *.h 间切换
nmap <Leader>ch :A<CR>
" 子窗口中显示 *.cpp 或 *.h
nmap <Leader>sch :AS<CR>

let g:SignatureMap = {
  \ 'Leader'         :  "m",
  \ 'PlaceNextMark'      :  "m,",
  \ 'ToggleMarkAtLine'   :  "m.",
  \ 'PurgeMarksAtLine'   :  "m-",
  \ 'DeleteMark'     :  "dm",
  \ 'PurgeMarks'     :  "mda",
  \ 'PurgeMarkers'       :  "m<BS>",
  \ 'GotoNextLineAlpha'  :  "']",
  \ 'GotoPrevLineAlpha'  :  "'[",
  \ 'GotoNextSpotAlpha'  :  "`]",
  \ 'GotoPrevSpotAlpha'  :  "`[",
  \ 'GotoNextLineByPos'  :  "]'",
  \ 'GotoPrevLineByPos'  :  "['",
  \ 'GotoNextSpotByPos'  :  "mn",
  \ 'GotoPrevSpotByPos'  :  "mp",
  \ 'GotoNextMarker'     :  "[+",
  \ 'GotoPrevMarker'     :  "[-",
  \ 'GotoNextMarkerAny'  :  "]=",
  \ 'GotoPrevMarkerAny'  :  "[=",
  \ 'ListLocalMarks'     :  "ms",
  \ 'ListLocalMarkers'   :  "m?"
\ }

" 正向遍历同名标签
nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
nmap <Leader>tp :tprevious<CR>

" 设置插件 indexer 调用 ctags 的参数
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"
let g:indexer_disableCtagsWarning=1

" 设置ctags路径
let g:tagbar_ctags_bin = 'ctags'
" 设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=1 
" 设置显示／隐藏标签列表子窗口的快捷键。速记：tag list 
nnoremap <Leader>tl :TagbarToggle<CR>
autocmd VimEnter * Tagbar
" 设置标签子窗口的宽度 
let tagbar_width=28 
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
" 不排序
let g:tagbar_sort=0
" 设置 ctags 对哪些代码元素生成标签
let g:tagbar_type_cpp = {
  \ 'kinds' : [
    \ 'd:macros:1',
    \ 'g:enums',
    \ 't:typedefs:0:0',
    \ 'e:enumerators:0:0',
    \ 'n:namespaces',
    \ 'c:classes',
    \ 's:structs',
    \ 'u:unions',
    \ 'f:functions',
    \ 'm:members:0:0',
    \ 'v:global:0:0',
    \ 'x:external:0:0',
    \ 'l:local:0:0'
   \ ],
   \ 'sro'      : '::',
   \ 'kind2scope' : {
     \ 'g' : 'enum',
     \ 'n' : 'namespace',
     \ 'c' : 'class',
     \ 's' : 'struct',
     \ 'u' : 'union'
   \ },
   \ 'scope2kind' : {
     \ 'enum'     : 'g',
     \ 'namespace' : 'n',
     \ 'class'   : 'c',
     \ 'struct' : 's',
     \ 'union'   : 'u'
   \ }
\ }

" 使用 ctrlsf.vim 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
nnoremap <Leader>sp :CtrlSF<CR>

" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction

" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'),'/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' .
    replace . '/' . flag . '| update'
endfunction
" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0,input('Replace '.expand('<cword>').'with: '))<CR>
" 不确认、整词
nnoremap <Leader>rw :call Replace(0,1, input('Replace'.expand('<cword>').' with: '))<CR>
" 确认、非整词
nnoremap <Leader>rc :call Replace(1,0, input('Replace'.expand('<cword>').' with: '))<CR>
" 确认、整词
nnoremap <Leader>rcw :call Replace(1,1, input('Replace'.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1,1, input('Replace'.expand('<cword>').' with: '))<CR>

" UltiSnips 的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"

" 设置C++库函数智能补全
"let OmniCpp_DefaultNamespaces = ["_GLIBCXX_STD"]
"set tags+=/usr/include/c++/4.8.2/stdcpp.tags
"set tags+=/usr/include/sys.tags

" 设置 pullproto.pl 脚本路径
let g:protodefprotogetter='~/.vim/bundle/plugin_protodef/pullproto.pl'
" 成员函数的实现顺序与声明顺序一致
let g:disable_protodef_sorting=1
" pullproto.pl 是 protodef 自带的 perl 脚本，默认位于 ~/.vim 目录，由于改用pathogen 管理插件，所以路径需重新设置。

" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=28
" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
" vim启动时默认打开 NERDtree
"autocmd VimEnter * NERDTree
" 当打开 NERDTree 窗口时，自动显示 Bookmarks
let NERDTreeShowBookmarks=1

" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>bl :MBEToggle<cr>
" buffer 切换快捷键
map <C-C> :MBEbn<cr>
map <C-X> :MBEbp<cr>
" 关闭当前buff
map <Leader>bd :MBEbd<cr>

" 自动格式化C++文档
map <Leader>kf :Autoformat<cr>:%s/\s\+$//<cr>

nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" powerline
set encoding=utf-8
set laststatus=2
set t_Co=256
let g:Powerline_symbols="fancy"

set fillchars+=stl:\ ,stlnc:\

" 设置cscope
set nocscopeverbose

if has("cscope") && filereadable("cscope")
	set csprg=cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		" cs add cscope.out
		" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

if has("cscope")
	set csprg=cscope
	set csto=0
	set cst
	set csverb
	set cspc=3
	" 添加当前目录内的cscope.out
	if filereadable("cscope.out")
		" cs add cscope.out
	" 否则在上层目录查找cscops.out
	else
		let cscope_file=findfile("cscope.out", ".;")
		let cscope_pre=matchstr(cscope_file, ".*/")
		if !empty(cscope_file) && filereadable(cscope_file)
			" silent 前缀解决了打开文件时提示 cs add信息的问题
			exe "silent cs add" cscope_file cscope_pre
		endif
	endif
endif

nmap<Leader>s :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap<Leader>g :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap<Leader>c :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap<Leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap<Leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap<Leader>sf :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap<Leader>si :cs find i <C-R>=expand("<cfile>")<cr><cr>
nmap<Leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>

"智能识别格式编码
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936

" 打开后自动切到编辑区
wincmd l

"wincmd w
"wincmd w
"autocmd VimEnter * wincmd w
"autocmd VimEnter * wincmd w

" 显示行尾多余的TAB键 空格等空白字符
set list
set listchars=tab:>-,trail:-
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" list 开关，方便复制代码,关闭开发tagbar和显示行数
nmap<Leader>le :set list<CR>:TagbarOpen<CR>:wincmd l<CR>:set number<CR>
nmap<Leader>ld :set nolist<CR>:TagbarClose<CR>:set nonumber<CR>
nmap<Leader>ll :set nolist<CR>:TagbarClose<CR>

let g:persistentBehaviour=0             "只剩一个窗口时, 退出vim.

"让vim记忆上次编辑的位置
autocmd BufReadPost * if line("'\"")>0&&line("'\"")<=line("$") | exe "normal g'\"" | endif

"设置粘贴板寄存器最大行数
set viminfo='10,<500
