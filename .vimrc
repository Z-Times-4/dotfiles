
"=============================================================================
"    Description: .vimrcサンプル設定
"         Author: anonymous
"  Last Modified: 0000-00-00 00:00
"        Version: 7.40
"=============================================================================

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

"au BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))

" ランタイムパスを通す必要のあるプラグインを使用する場合、
" $MY_VIMRUNTIMEを使用すると Windows/Linuxで切り分ける必要が無くなります。
" 例) vimfiles/qfixapp (Linuxでは~/.vim/qfixapp)にランタイムパスを通す場合
" set runtimepath+=$MY_VIMRUNTIME/qfixapp

"----------------------------------------
" 内部エンコーディング指定
"----------------------------------------
" 内部エンコーディングのUTF-8化と文字コードの自動認識設定をencode.vimで行う。
" オールインワンパッケージの場合 vimrcで設定されます。
" エンコーディング指定や文字コードの自動認識設定が適切に設定されている場合、
" 次行の encode.vim読込部分はコメントアウトして下さい。
" silent! source $MY_VIMRUNTIME/pluginjp/encode.vim
" scriptencodingと異なる内部エンコーディングに変更する場合、
" 変更後にもscriptencodingを指定しておくと問題が起きにくくなります。
" scriptencoding cp932

"----------------------------------------
" システム設定
"----------------------------------------
" mswin.vimを読み込む
" source $VIMRUNTIME/mswin.vim
" behave mswin


"----------------------------------------
" 編集設定
"----------------------------------------

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

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
  " set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
  set clipboard& clipboard+=unnamedplus,unnamed 
else
  " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
  set clipboard& clipboard+=unnamed
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
autocmd BufWinEnter * setlocal textwidth=0

" マウスを有効にする
if has('mouse')
  set mouse=a
endif
" pluginを使用可能にする
filetype plugin indent on


"----------------------------------------
" 検索
"----------------------------------------
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


"----------------------------------------
" 表示設定
"----------------------------------------

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

"----------------------------------------
" diff/patch
"----------------------------------------
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

if has('win32')
  let g:vimproc_dll_path = $MY_VIMRUNTIME . '/bundle/vimproc/autoload/vimproc_win32.dll'
endif

" 現バッファの差分表示(変更箇所の表示)
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif
" パッチコマンド
set patchexpr=MyPatch()
function! MyPatch()
  call system($VIM."\\'.'patch -o " . v:fname_out . " " . v:fname_in . " < " . v:fname_diff)
endfunction

"----------------------------------------
" ノーマルモード
"----------------------------------------
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

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

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

"折りたたみ方法をインデントに指定
set foldmethod=indent
set foldcolumn=3
set foldlevel=100

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

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



"----------------------------------------
" 挿入モード
"----------------------------------------

"----------------------------------------
" ビジュアルモード
"----------------------------------------

"----------------------------------------
" コマンドモード
"----------------------------------------

"----------------------------------------
" Vimスクリプト
"----------------------------------------
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

filetype off
let s:noplugin = 0
let s:bundle_root = expand('$HOME/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
if !isdirectory(s:neobundle_root) || v:version < 702
  " NeoBundleが存在しない、もしくはVimのバージョンが古い場合はプラグインを一切
  " 読み込まない
  let s:noplugin = 1
else
  " NeoBundleを'runtimepath'に追加し初期化を行う
  if has('vim_starting')
    execute "set runtimepath+=" . s:neobundle_root
  endif
  call neobundle#rc(s:bundle_root)

  " NeoBundle自身をNeoBundleで管理させる
  NeoBundleFetch 'Shougo/neobundle.vim'

  "タブで開けるように設定
  if has('clientserver')
    NeoBundle 'thinca/vim-singleton'
    call singleton#enable()
  endif

  " 非同期通信を可能にする
  " 'build'が指定されているのでインストール時に自動的に
  " 指定されたコマンドが実行され vimproc がコンパイルされる
  NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}

  NeoBundleLazy 'Shougo/neocomplete.vim', {
        \ "autoload": {"insert": 1}}
  " neocompleteのhooksを取得
  let s:hooks = neobundle#get_hooks("neocomplete.vim")
  " neocomplete用の設定関数を定義。下記関数はneocompleteロード時に実行される
  function! s:hooks.on_source(bundle)
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
          \ 'default' : '',
          \ 'vimshell' : $MY_VIMRUNTIME.'/.vimshell_hist',
          \ 'scheme' : $MY_VIMRUNTIME.'/.gosh_completions'
          \ }
    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: closels popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " " Close popup by <Space>.
    inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'

    "NeoCompleteEnable
  endfunction


  NeoBundleLazy 'Shougo/neosnippet.vim', {
        \ "autoload": {"insert": 1}}
  NeoBundleLazy "Shougo/neosnippet-snippets", {
        \ "autoload": {"insert": 1}}      
  " 'GundoToggle'が呼ばれるまでロードしない
  NeoBundleLazy 'sjl/gundo.vim', {
        \ "autoload": {"commands": ["GundoToggle"]}}
  " '<Plug>TaskList'というマッピングが呼ばれるまでロードしない
  NeoBundleLazy 'vim-scripts/TaskList.vim', {
        \ "autoload": {"mappings": ['<Plug>TaskList']}}
  " HTMLが開かれるまでロードしない
  NeoBundleLazy 'mattn/zencoding-vim', {
        \ "autoload": {"filetypes": ['html']}}
  NeoBundleLazy "Shougo/unite.vim", {
        \ "autoload": {
        \   "commands": ["Unite", "UniteWithBufferDir"]
        \ }}

  "unite設定
  NeoBundleLazy 'h1mesuke/unite-outline', {
        \ "autoload": {
        \   "unite_sources": ["outline"],
        \ }}
  nnoremap [unite] <Nop>
  nmap U [unite]
  nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]r :<C-u>Unite register<CR>
  nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
  nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
  nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
  nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
  nnoremap <silent> [unite]w :<C-u>Unite window<CR>       

  "現在のファイルをブックマークします。
  nnoremap <silent> [unite]d :UniteBookmarkAdd<CR>


  let s:hooks = neobundle#get_hooks("unite.vim")
  function! s:hooks.on_source(bundle)
    " start unite in insert mode
    let g:unite_enable_start_insert = 1
    " use vimfiler to open directory
    call unite#custom_default_action("source/bookmark/directory", "vimfiler")
    call unite#custom_default_action("directory", "vimfiler")
    call unite#custom_default_action("directory_mru", "vimfiler")
    autocmd MyAutoCmd FileType unite call s:unite_settings()
    function! s:unite_settings()
      imap <buffer> <Esc><Esc> <Plug>(unite_exit)
      nmap <buffer> <Esc> <Plug>(unite_exit)
      nmap <buffer> <C-n> <Plug>(unite_select_next_line)
      nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
    endfunction
  endfunction

  "vimfiler設定
  NeoBundleLazy "Shougo/vimfiler", {
        \ "depends": ["Shougo/unite.vim"],
        \ "autoload": {
        \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
        \   "mappings": ['<Plug>(vimfiler_switch)'],
        \   "explorer": 1,
        \ }}
  nnoremap <Leader>e :VimFilerExplorer  -split -no-quit -auto-cd<CR>
  " close vimfiler automatically when there are only vimfiler open
  autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
  let s:hooks = neobundle#get_hooks("vimfiler")
  function! s:hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_enable_auto_cd = 1

    " .から始まるファイルおよび.pycで終わるファイルを不可視パターンに
    " 2013-08-14 追記
    let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$\)"

    " vimfiler specific key mappings
    autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
    function! s:vimfiler_settings()
      " ^^ to go up
      nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
      " use R to refresh
      nmap <buffer> R <Plug>(vimfiler_redraw_screen)
      " overwrite C-l
      nmap <buffer> <C-l> <C-w>l
    endfunction
  endfunction

  "vimshell
  NeoBundle 'Shougo/vimshell'

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

  "テキスト編集関係
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'vim-scripts/Align'
  NeoBundle 'vim-scripts/YankRing.vim'

  "インデント可視化
  NeoBundle "nathanaelkane/vim-indent-guides"
  " let g:indent_guides_enable_on_vim_startup = 1 2013-06-24 10:00 削除
  let s:hooks = neobundle#get_hooks("vim-indent-guides")
  function! s:hooks.on_source(bundle)
    let g:indent_guides_guide_size = 1
    if isdirectory($MY_VIMRUNTIME . '/bundle/vim-indent-guides')
      IndentGuidesEnable " 2013-06-24 10:00 追記
    endif
  endfunction

  "todo設定
  NeoBundleLazy "sjl/gundo.vim", {
        \ "autoload": {
        \   "commands": ['GundoToggle'],
        \}}
  nnoremap <Leader>g :GundoToggle<CR>

  NeoBundleLazy "thinca/vim-quickrun", {
        \ "autoload": {
        \   "mappings": [['nxo', '<Plug>(quickrun)']]
        \ }}
  nmap <Leader>r <Plug>(quickrun)
  let s:hooks = neobundle#get_hooks("vim-quickrun")
  function! s:hooks.on_source(bundle)
    let g:quickrun_config = {
          \ "*": {"runner": "remote/vimproc"},
          \ }
  endfunction
  "Python補完
  "NeoBundleLazy "davidhalter/jedi-vim", {
  "      \ "autoload": {
  "      \   "filetypes": ["python", "python3", "djangohtml"],
  "      \   "build": {
  "      \     "mac": "pip install jedi",
  "      \     "unix": "pip install jedi",
  "      \   }
  "      \ }}
  NeoBundleLazy "davidhalter/jedi-vim", {
        \ "autoload": {
        \   "filetypes": ["python", "python3", "djangohtml"],
        \ },
        \ "build": {
        \   "mac": "pip install jedi",
        \   "unix": "pip install jedi",
        \ }}
  let s:hooks = neobundle#get_hooks("jedi-vim")
  function! s:hooks.on_source(bundle)
    " jediにvimの設定を任せると'completeopt+=preview'するので
    " 自動設定機能をOFFにし手動で設定を行う
    let g:jedi#auto_vim_configuration = 0
    " 補完の最初の項目が選択された状態だと使いにくいためオフにする
    let g:jedi#popup_select_first = 0
    " quickrunと被るため大文字に変更
    let g:jedi#rename_command = '<Leader>R'
    " gundoと被るため大文字に変更 (2013-06-24 10:00 追記）
    let g:jedi#goto_command = '<Leader>G'
  endfunction

  "前回のセッション回復
  NeoBundle 'xolox/vim-session', {
        \ 'depends' : 'xolox/vim-misc',
        \ }
  if isdirectory($MY_VIMRUNTIME . '/bundle/vim-session')
    " 現在のディレクトリ直下の .vimsessions/ を取得 
    let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
    " 存在すれば
    if isdirectory(s:local_session_directory)
      " session保存ディレクトリをそのディレクトリの設定
      let g:session_directory = s:local_session_directory
      " vimを辞める時に自動保存
      let g:session_autosave = 'yes'
      " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
      let g:session_autoload = 'yes'
      " 1分間に1回自動保存
      let g:session_autosave_periodic = 1
    else
      let g:session_autosave = 'no'
      let g:session_autoload = 'no'
    endif
    unlet s:local_session_directory
  endif

  NeoBundle 'kana/vim-tabpagecd'

  NeoBundle 'tpope/vim-rails', { 'autoload' : {
        \ 'filetypes' : ['haml', 'ruby', 'eruby'] }}

  NeoBundleLazy 'alpaca-tc/vim-endwise.git', {
        \ 'autoload' : {
        \   'insert' : 1,
        \ }}

  
  " NeoBundleLazy 'edsono/vim-matchit', { 'autoload' : {
  "       \ 'filetypes': 'ruby',
  "       \ 'mappings' : ['nx', '%'] }}

  NeoBundleLazy 'basyura/unite-rails', {
        \ 'depends' : 'Shougo/unite.vim',
        \ 'autoload' : {
        \   'unite_sources' : [
        \     'rails/bundle', 'rails/bundled_gem', 'rails/config',
        \     'rails/controller', 'rails/db', 'rails/destroy', 'rails/features',
        \     'rails/gem', 'rails/gemfile', 'rails/generate', 'rails/git', 'rails/helper',
        \     'rails/heroku', 'rails/initializer', 'rails/javascript', 'rails/lib', 'rails/log',
        \     'rails/mailer', 'rails/model', 'rails/rake', 'rails/route', 'rails/schema', 'rails/spec',
        \     'rails/stylesheet', 'rails/view'
        \   ]
        \ }}

  NeoBundleLazy 'alpaca-tc/neorspec.vim', {
        \ 'depends' : ['alpaca-tc/vim-rails', 'tpope/vim-dispatch'],
        \ 'autoload' : {
        \   'commands' : ['RSpec', 'RSpecAll', 'RSpecCurrent', 'RSpecNearest', 'RSpecRetry']
        \ }}

  NeoBundleLazy 'alpaca-tc/alpaca_tags', {
        \ 'depends': 'Shougo/vimproc',
        \ 'autoload' : {
        \   'commands': ['TagsUpdate', 'TagsSet', 'TagsBundle']
        \ }}

  NeoBundleLazy 'tsukkee/unite-tag', {
        \ 'depends' : ['Shougo/unite.vim'],
        \ 'autoload' : {
        \   'unite_sources' : ['tag', 'tag/file', 'tag/include']
        \ }}


  NeoBundle 'AndrewRadev/switch.vim'

  function! s:separate_defenition_to_each_filetypes(ft_dictionary) 
    let result = {}

    for [filetypes, value] in items(a:ft_dictionary)
      for ft in split(filetypes, ",")
        if !has_key(result, ft)
          let result[ft] = []
        endif

        call extend(result[ft], copy(value))
      endfor
    endfor

    return result
  endfunction

  " ------------------------------------
  " switch.vim
  " ------------------------------------
  nnoremap ! :Switch<CR>
  let s:switch_definition = {
        \ '*': [
        \   ['is', 'are']
        \ ],
        \ 'ruby,eruby,haml' : [
        \   ['if', 'unless'],
        \   ['while', 'until'],
        \   ['.blank?', '.present?'],
        \   ['include', 'extend'],
        \   ['class', 'module'],
        \   ['.inject', '.delete_if'],
        \   ['.map', '.map!'],
        \   ['attr_accessor', 'attr_reader', 'attr_writer'],
        \ ],
        \ 'Gemfile,Berksfile' : [
        \   ['=', '<', '<=', '>', '>=', '~>'],
        \ ],
        \ 'ruby.application_template' : [
        \   ['yes?', 'no?'],
        \   ['lib', 'initializer', 'file', 'vendor', 'rakefile'],
        \   ['controller', 'model', 'view', 'migration', 'scaffold'],
        \ ],
        \ 'erb,html,php' : [
        \   { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' },
        \ ],
        \ 'rails' : [
        \   [100, ':continue', ':information'],
        \   [101, ':switching_protocols'],
        \   [102, ':processing'],
        \   [200, ':ok', ':success'],
        \   [201, ':created'],
        \   [202, ':accepted'],
        \   [203, ':non_authoritative_information'],
        \   [204, ':no_content'],
        \   [205, ':reset_content'],
        \   [206, ':partial_content'],
        \   [207, ':multi_status'],
        \   [208, ':already_reported'],
        \   [226, ':im_used'],
        \   [300, ':multiple_choices'],
        \   [301, ':moved_permanently'],
        \   [302, ':found'],
        \   [303, ':see_other'],
        \   [304, ':not_modified'],
        \   [305, ':use_proxy'],
        \   [306, ':reserved'],
        \   [307, ':temporary_redirect'],
        \   [308, ':permanent_redirect'],
        \   [400, ':bad_request'],
        \   [401, ':unauthorized'],
        \   [402, ':payment_required'],
        \   [403, ':forbidden'],
        \   [404, ':not_found'],
        \   [405, ':method_not_allowed'],
        \   [406, ':not_acceptable'],
        \   [407, ':proxy_authentication_required'],
        \   [408, ':request_timeout'],
        \   [409, ':conflict'],
        \   [410, ':gone'],
        \   [411, ':length_required'],
        \   [412, ':precondition_failed'],
        \   [413, ':request_entity_too_large'],
        \   [414, ':request_uri_too_long'],
        \   [415, ':unsupported_media_type'],
        \   [416, ':requested_range_not_satisfiable'],
        \   [417, ':expectation_failed'],
        \   [422, ':unprocessable_entity'],
        \   [423, ':precondition_required'],
        \   [424, ':too_many_requests'],
        \   [426, ':request_header_fields_too_large'],
        \   [500, ':internal_server_error'],
        \   [501, ':not_implemented'],
        \   [502, ':bad_gateway'],
        \   [503, ':service_unavailable'],
        \   [504, ':gateway_timeout'],
        \   [505, ':http_version_not_supported'],
        \   [506, ':variant_also_negotiates'],
        \   [507, ':insufficient_storage'],
        \   [508, ':loop_detected'],
        \   [510, ':not_extended'],
        \   [511, ':network_authentication_required'],
        \ ],
        \ 'rspec': [
        \   ['describe', 'context', 'specific', 'example'],
        \   ['before', 'after'],
        \   ['be_true', 'be_false'],
        \   ['get', 'post', 'put', 'delete'],
        \   ['==', 'eql', 'equal'],
        \   { '\.should_not': '\.should' },
        \   ['\.to_not', '\.to'],
        \   { '\([^. ]\+\)\.should\(_not\|\)': 'expect(\1)\.to\2' },
        \   { 'expect(\([^. ]\+\))\.to\(_not\|\)': '\1.should\2' },
        \ ],
        \ 'markdown' : [
        \   ['[ ]', '[x]']
        \ ]
        \ }

  let s:switch_definition = s:separate_defenition_to_each_filetypes(s:switch_definition)
  function! s:define_switch_mappings()
    if exists('b:switch_custom_definitions')
      unlet b:switch_custom_definitions
    endif

    let dictionary = []
    for filetype in split(&ft, '\.')
      if has_key(s:switch_definition, filetype)
        let dictionary = extend(dictionary, s:switch_definition[filetype])
      endif
    endfor

    if exists('b:rails_root')
      let dictionary = extend(dictionary, s:switch_definition['rails'])
    endif

    if has_key(s:switch_definition, '*')
      let dictionary = extend(dictionary, s:switch_definition['*'])
    endif

    if !empty('dictionary')
      "call alpaca#let_b:('switch_custom_definitions', dictionary)
    endif
  endfunction

  augroup SwitchSetting
    autocmd!
    autocmd Filetype * if !empty(split(&ft, '\.')) | call <SID>define_switch_mappings() | endif
  augroup END

  "grepのヘルパー
  NeoBundle 'fuenor/qfixgrep'

  "デフォルトで使用する外部grep
  set grepprg=grep

  "grepに含めたくない拡張子
  let MyGrep_ExcludeReg = '[~#]$\|\.dll$\|\.exe$\|\.lnk$\|\.o$\|\.obj$\|\.pdf$\|\.xls$'

  "大文字、小文字を気にせずに検索する。
  let g:MyGrepDefault_Ignorecase = 1

  "カラースキーマ定義
  " solarized カラースキーム
  NeoBundle 'altercation/vim-colors-solarized'
  " mustang カラースキーム
  NeoBundle 'croaker/mustang-vim'
  " wombat カラースキーム
  NeoBundle 'jeffreyiacono/vim-colors-wombat'
  " jellybeans カラースキーム
  NeoBundle 'nanotech/jellybeans.vim'
  " lucius カラースキーム
  NeoBundle 'vim-scripts/Lucius'
  " zenburn カラースキーム
  NeoBundle 'vim-scripts/Zenburn'
  " mrkn256 カラースキーム
  NeoBundle 'mrkn/mrkn256.vim'
  " railscasts カラースキーム
  NeoBundle 'jpo/vim-railscasts-theme'
  " pyte カラースキーム
  NeoBundle 'therubymug/vim-pyte'
  " molokai カラースキーム
  NeoBundle 'tomasr/molokai'

  " カラースキーム一覧表示に Unite.vim を使う
  NeoBundle 'ujihisa/unite-colorscheme'

  "デフォルトのカラースキーマ
  set background=light
  let g:solarized_contrast="hight"
  let g:solarized_italic=0
  colorscheme solarized


  "NeoBundleここまで
  " (ry

  " インストールされていないプラグインのチェックおよびダウンロード
  NeoBundleCheck
endif

" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on
"----------------------------------------
" 一時設定
"----------------------------------------
