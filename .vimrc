" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END


set fileencodings=utf-8,iso-2022-jp,cp932,sjis,euc-jp
set encoding=utf-8
set nocompatible
scriptencoding utf-8
" scriptencodingと、このファイルのエンコーディングが一致するよう注意！
" scriptencodingは、vimの内部エンコーディングと同じものを推奨します。
" 改行コードは set fileformat=unix に設定するとunixでも使えます。

" Windowsで内部エンコーディングを cp932以外にしていて、
" 環境変数に日本語を含む値を設定したい場合は Let を使用します。
" Letは vimrc(オールインワンパッケージの場合)と encode.vim で定義されます。
" Let $HOGE=$USERPROFILE.'/ほげ'

"----------------------------------------
" ユーザーランタイムパス設定
"----------------------------------------
" Windows, unixでのruntimepathの違いを吸収するためのもの。
" $MY_VIMRUNTIMEはユーザーランタイムディレクトリを示す。
" :echo $MY_VIMRUNTIMEで実際のパスを確認できます。
if isdirectory($HOME . '/.vim')
  let $MY_VIMRUNTIME = $HOME.'/.vim'
elseif isdirectory($HOME . '\vimfiles')
  let $MY_VIMRUNTIME = $HOME.'\vimfiles'
elseif isdirectory($VIM . '\vimfiles')
  let $MY_VIMRUNTIME = $VIM.'\vimfiles'
endif

if has('win32')
  let g:vimproc_dll_path = $MY_VIMRUNTIME . '/bundle/vimproc/autoload/vimproc_win32.dll'
endif
if has('win64')
  let g:vimproc_dll_path = $MY_VIMRUNTIME . '/bundle/vimproc/autoload/vimproc_win64.dll'
endif

let g:rc_dir=$MY_VIMRUNTIME . '/rc'


"au BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))


if has('gui_macvim')
  map ¥ <leader>
endif

if has('multi_byte_ime') || has('xim') || has('gui_macvim' || has('gui_running'))
  " Insert mode: lmap off, IME ON
  set iminsert=2
  " Serch mode: lmap off, IME ON
  set imsearch=2
  " Normal mode: IME off
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
set noundofile          " .un~ファイルを無効化
set tags=tags;/,codex.tags;/  " tagsの設定

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
  " set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
  set clipboard+=unnamedplus,unnamed 
else
  " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
  set clipboard+=unnamed
endif


" ファイルの上書きの前にバックアップを作る/作らない
" set writebackupを指定してもオプション 'backup' がオンでない限り、
" バックアップは上書きに成功した後に削除される。
set nowritebackup
" バックアップ/スワップファイルを作成する/しない
set nobackup
if version >= 703
  " 再読込、vim終了後も継続するアンドゥ(7.3)
  " set undofile
  " アンドゥの保存場所(7.3)
  " set undodir=.
endif
set noswapfile
" viminfoを作成しない


" クリップボードを共有
set clipboard+=unnamed
" 8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal
" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeout timeoutlen=3000 ttimeoutlen=100
" 編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない
set history=50
" 日本語の行の連結時には空白を入力しない
set formatoptions+=mM
" 改行をしない
set formatoptions-=tc
" Visual blockモードでフリーカーソルを有効にする
set whichwrap=b,s,[,],<,>
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
" コマンドライン補完するときに強化されたものを使う
set wildmenu
set wildmode=list:longest,full

"自動改行を無効にする
autocmd BufRead * set textwidth=0
set textwidth=0
set tw=0
autocmd FileType text setlocal textwidth=0

autocmd BufRead .vimrc set filetype=vim
autocmd BufRead .vimrc set syntax=vim
autocmd BufRead .vim set filetype=vim
autocmd BufRead .vimrc set syntax=vim
autocmd BufRead .toml set syntax=toml
autocmd BufNewFile,BufRead *.hs set filetype=haskell
autocmd BufNewFile,BufRead *.yml set filetype=yaml

" マウスを有効にする
if has('mouse')
  set mouse=a
endif
" pluginを使用可能にする
filetype plugin indent on

if !has('gui_running')
  set notimeout
  set ttimeout
  set timeoutlen=100
endif


" 検索 {{{
" 検索の時に大文字小文字を区別しない
" ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set ignorecase
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan
" インクリメンタルサーチ
set incsearch
" 検索文字の強調表示
set hlsearch
" w,bの移動で認識する文字
" set iskeyword=a-z,A-Z,48-57,_,.,-,>
" vimgrep をデフォルトのgrepとする場合internal
" set grepprg=internal

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" }}}

" 表示設定 {{{

set guioptions-=T
set guioptions-=m

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell
" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" スプラッシュ(起動時のメッセージ)を表示しない
" set shortmess+=I
" エラー時の音とビジュアルベルの抑制(gvimは.gvimrcで設定)
set noerrorbells
set novisualbell
set visualbell t_vb=
" マクロ実行中などの画面再描画を行わない
" WindowsXpまたはWindowテーマが「Windowsクラシック」で
" Google日本語入力を使用するとIビームカーソルが残る場合にも有効
" set lazyredraw
" Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set shellslash
" 行番号表示
set number
if version >= 703
  " 相対行番号表示(7.3)
  " set relativenumber
endif
" 括弧の対応表示時間

" タブを設定
" set ts=4 sw=4 sts=4
" 自動的にインデントする
set autoindent
" Cインデントの設定
set cinoptions+=:0
" タイトルを表示
set title
" コマンドラインの高さ (gvimはgvimrcで指定)
" set cmdheight=2
set laststatus=2
" コマンドをステータス行に表示
set showcmd
" 画面最後の行をできる限り表示する
set display=lastline
" Tab、行末の半角スペースを明示的に表示する
set list

" ハイライトを有効にする
if &t_Co > 2 || has('gui_running')
  syntax on
endif
" 色テーマ設定
" gvimの色テーマは.gvimrcで指定する
" colorscheme mylight

""""""""""""""""""""""""""""""
" ステータスラインに文字コード等表示
" iconvが使用可能の場合、カーソル上の文字コードをエンコードに応じた表示にするFencB()を使用
""""""""""""""""""""""""""""""
if has('iconv')
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=[0x%{FencB()}]\ (%v,%l)/%L%8P\ 
else
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 
endif

" FencB() : カーソル上の文字コードをエンコードに応じた表示にする
function! FencB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return s:Byte2hex(s:Str2byte(c))
endfunction

function! s:Str2byte(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

function! s:Byte2hex(bytes)
  return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction

" }}}

" diff/patch {{{

" diffの設定
if has('win32') || has('win64')
  set diffexpr=MyDiff()
  function! MyDiff()
    " 7.3.443 以降の変更に対応
    silent! let saved_sxq=&shellxquote
    silent! set shellxquote=
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let cmd = '!diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    silent execute cmd
    silent! let &shellxquote = saved_sxq
  endfunction
endif

" シンボリックリンクのファイル元を開く
command! FollowSymlink call s:SwitchToActualFile()
function! s:SwitchToActualFile()
  let l:fname = resolve(expand('%:p'))
  let l:pos = getpos('.')
  let l:bufname = bufname('%')
  enew
  exec 'bw '. l:bufname
  exec "e" . fname
  call setpos('.', pos)
endfunction

" 現バッファの差分表示(変更箇所の表示)
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif
" パッチコマンド
set patchexpr=MyPatch()
function! MyPatch()
  call system($VIM."\\'.'patch -o " . v:fname_out . " " . v:fname_in . " < " . v:fname_diff)
endfunction

"}}}

" ノーマルモード {{{
" ヘルプ検索
nnoremap <F1> K
" 現在開いているvimスクリプトファイルを実行
nnoremap <F8> :source %<CR>
" 強制全保存終了を無効化
nnoremap ZZ <Nop>
" カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>
" キーボードマクロには物理行移動を推奨
" h l は行末、行頭を超えることが可能に設定(whichwrap)
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>zv
nnoremap j gj
nnoremap k gk
nnoremap l <Right>zv


" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" vを二回で行末まで選択
vnoremap v $h

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

"タブ移動関連 
nnoremap <C-Tab> gt
nnoremap <C-S-Tab> gT
nnoremap <S-tab> gt
nnoremap <tab><tab> gT

  "プレフィックス
nnoremap t; t
nnoremap t <Nop>

"新しいバッファを開く
nnoremap to :<C-u>edit<Space>
nnoremap tt :<C-u>tabnew<Space>

"カレントバッファのディレクトリを元に新しいバッファを開く
nnoremap <expr> tO ':<C-u>edit ' . GetRelativePath()
nnoremap <expr> tT ':<C-u>tabnew ' . GetRelativePath()

function! GetRelativePath()
  let path = expand('%:~:.:h')
  if path == '.'
    return ""
  else
    return path . '/'
  endif
endfunction

"画面分割
nnoremap ts :<C-u>split<Space>
nnoremap <expr> tS ':<C-u>split ' . GetRelativePath()
nnoremap tv :<C-u>vsplit<Space>
nnoremap <expr> tV ':<C-u>vsplit ' . GetRelativePath()

"タブを閉じる
nnoremap <silent> td :<C-u>tabclose<CR>

"ウィンドウ・バッファをタブに移動する
nnoremap <silent> tm :<C-u>call MoveToNewTab()<CR>

function! MoveToNewTab()
  tab split
  tabprevious

  if winnr('$') > 1
    close
  elseif bufnr('$') > 1
    buffer #
  endif

  tabnext
endfunction

nnoremap <silent> t] :buffer<CR>
nnoremap <silent> tn :bnext<CR>
nnoremap <silent> tp :bprevious<CR>
nnoremap <silent> tD :<C-u>bdelete<CR>
nnoremap <silent> tl :<C-u>buffers<CR>

nnoremap tgf <C-w>gf
nnoremap tgF <C-w>gF
for n in range(1, 9)
  exe 'nnoremap <silent> t' . n ' :<C-u>tabnext ' . n . '<CR>'
endfor

" }}}

" インサートモード {{{
" IM起動時にカーソル入力が出来ない問題対応
imap <ESC>OA <Up>
imap <ESC>OB <Down>
imap <ESC>OC <Right>
imap <ESC>OD <Left>
" }}}

"タブ表示ラベル
set tabline=%!MakeTabLine()

function! MakeTabLine()
  let s = ''

  for n in range(1, tabpagenr('$'))
    if n == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    let s .= '%' . n . 'T'

    let s .= ' %{MakeTabLabel(' . n . ')} '

    let s .= '%#TabLineFill#%T'
    let s .= '|'
  endfor

  let s .= '%#TabLineFill#%T'
  let s .= '%=%#TabLine#'
  let s .= '%{fnamemodify(getcwd(), ":~:h")}%<'
  return s
endfunction

function! MakeTabLabel(n)
  let bufnrs = tabpagebuflist(a:n)
  let bufnr = bufnrs[tabpagewinnr(a:n) - 1]

  let bufname = bufname(bufnr)
  if bufname == ''
    let bufname = '[No Name]'
  else
    let bufname = fnamemodify(bufname, ":t")
  endif

  let no = len(bufnrs)
  if no == 1
    let no = ''
  endif

  let mod = len(filter(bufnrs, 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let sp = (no . mod) == '' ? '' : ' '

  let s = no . mod . sp . bufname
  return s
endfunction


"コピペ用
vnoremap <silent> <C-p> "0p<CR>

"以下デフォルトの値
set expandtab
set tabstop=2
set shiftwidth=2

set foldmethod=marker
set foldcolumn=3
set foldlevel=100

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" grep詳細設定
"デフォルトで使用する外部grep
set grepprg=grep

"grepに含めたくない拡張子
let MyGrep_ExcludeReg = '[~#]$\|\.dll$\|\.exe$\|\.lnk$\|\.o$\|\.obj$\|\.pdf$\|\.xls$'

"大文字、小文字を気にせずに検索する。
let g:MyGrepDefault_Ignorecase = 1


" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
"autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
  execute 'source ' . s:local_vimrc
endif

""""""""""""""""""""""""""""""
" ファイルを開いたら前回のカーソル位置へ移動
" $VIMRUNTIME/vimrc_example.vim
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインのカラー変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
" if has('unix') && !has('gui_running')
"   " ESCですぐに反映されない対策
"   inoremap <silent> <ESC> <ESC>
" endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
    redraw
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

""""""""""""""""""""""""""""""
" 全角スペースを表示
""""""""""""""""""""""""""""""
" コメント以外で全角スペースを指定しているので、scriptencodingと、
" このファイルのエンコードが一致するよう注意！
" 強調表示されない場合、ここでscriptencodingを指定するとうまくいく事があります。
" scriptencoding cp932
function! ZenkakuSpace()
  silent! let hi = s:GetHighlight('ZenkakuSpace')
  if hi =~ 'E411' || hi =~ 'cleared$'
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
  endif
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

""""""""""""""""""""""""""""""
" grep,tagsのためカレントディレクトリをファイルと同じディレクトリに移動する
""""""""""""""""""""""""""""""
if exists('+autochdir')
  "autochdirがある場合カレントディレクトリを移動しない
  set noautochdir
else
  "autochdirが存在しないが、カレントディレクトリを移動したい場合
endif

"ファイル読み込み時にタブのディレクトリを移動
au BufEnter * execute ":lcd " . substitute((isdirectory(expand("%:p:h")) ? expand("%:p:h") : "")," ","\\\\ ","g")
"----------------------------------------
" 各種プラグイン設定
"----------------------------------------

"dein.vim設定 {{{
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = $MY_VIMRUNTIME . '/bundle'
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" }}}


" 各プラグインの設定 {{{

let s:bundle_root = expand('$HOME/.vim/bundle')

"タブで開けるように設定
if has('clientserver')
  if isdirectory(s:bundle_root . 'vim-singleton')
    call singleton#enable()
  endif
endif

" 各プラグインのキーマップ

"vimshell
nmap <Leader>v :sp<cr><c-w><c-w>:VimShell<cr>
nmap <Leader>V :vs<cr><c-l><c-l>:VimShell<cr>

let g:vimshell_no_default_keymappings = 1
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '
autocmd FileType vimshell call s:vimshell_settings()
function! s:vimshell_settings()
  " overwrite C-l
  nmap  <buffer> <CR> <Plug>(vimshell_enter)
  nmap <buffer> q <Plug>(vimshell_hide)
  nmap <buffer> Q <Plug>(vimshell_exit)
  nmap <buffer> <C-p> <Plug>(vimshell_previous_prompt)
  nmap <buffer> <C-n> <Plug>(vimshell_next_prompt)
  nmap <buffer> <C-S-k> <Plug>(vimshell_delete_previous_output)
  nmap <buffer> <C-k> <C-w>k
  nmap <buffer> <C-y> <Plug>(vimshell_paste_prompt)
  nmap <buffer> E <Plug>(vimshell_move_end_argument)
  nmap <buffer> cc <Plug>(vimshell_change_line)
  nmap <buffer> dd <Plug>(vimshell_delete_line)
  nmap <buffer> I <Plug>(vimshell_insert_head)
  nmap <buffer> A <Plug>(vimshell_append_end)
  nmap <buffer> i <Plug>(limshell_insert_enter)
  nmap <buffer> a <Plug>(vimshell_append_enter)
  nmap <buffer> ^ <Plug>(vimshell_move_head)
  nmap <buffer> <C-c> <Plug>(vimshell_interrupt) 
  "nmap <buffer> <C-l> <Plug>(vimshell_clear)
  nmap  <buffer> <C-z> <Plug>(vimshell_execute_by_background)
  imap  <buffer> <CR> <Plug>(vimshell_enter)
  imap <expr> <buffer> <C-l> pumvisible() ? "\<C-n>" : "\<Plug>(vimshell_history_neocomplete)"
  imap <buffer> <TAB> <Plug>(vimshell_command_complete)
  imap <buffer> <C-a> <Plug>(vimshell_move_head)
  imap <buffer> <C-u> <Plug>(vimshell_delete_backward_line)
  imap <buffer> <C-w> <Plug>(vimshell_delete_backward_word)
  imap <buffer> <C-t> <Plug>(vimshell_insert_last_word)
  imap <buffer> <C-x><C-h> <Plug>(vimshell_run_help)
  imap <buffer> <C-c> <Plug>(vimshell_interrupt)
  imap <buffer> <C-h> <Plug>(vimshell_delete_backward_char)
  imap <buffer> <BS> <Plug>(vimshell_delete_backward_char)
  imap <buffer> <C-k> <Plug>(vimshell_delete_forward_line)
  imap <buffer> <C-x> <Plug>(vimshell_move_previous_window)
endfunction

nnoremap <Leader>e :VimFilerExplorer  -split -no-quit -auto-cd<CR>
" ^^ to go up
nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
" use R to refresh
nmap <buffer> R <Plug>(vimfiler_redraw_screen)
" overwrite C-l
nmap <buffer> <C-l> <C-w>l
" close vimfiler automatically when there are only vimfiler open
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_enable_auto_cd = 1

autocmd FileType vimfiler nmap <buffer> <C-l> <Nop>

" .pycで終わるファイルを不可視パターンに
" 2013-08-14 追記
let g:vimfiler_ignore_pattern = "\%(\.pyc$\)"

" vimfiler specific key mappings


" カラースキーム
"デフォルトのカラースキーマ
set background=dark
let g:solarized_contrast="hight"
let g:solarized_italic=0
let g:solarized_termcolors=256
let g:solarized_termtrans=1
if isdirectory(s:bundle_root . '/vim-colors-solarized')
  colorscheme solarized
endif

"}}}
