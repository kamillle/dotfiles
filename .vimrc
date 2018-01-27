set encoding=utf-8
scriptencoding utf-8
language C
"----------------------------------------------------------
" operation
"----------------------------------------------------------
set wildmenu wildmode=list:longest,full " コマンドラインモードでTABキーによるファイル名補完を有効にする
set history=1000                        " コマンドラインの履歴をXXXX件保存する
set clipboard=unnamed,unnamedplus       " クリップボードをOSと共有
set scrolloff=8                         " 上下8行の視界を確保
set sidescrolloff=16                    " 左右スクロール時の視界を確保
set sidescroll=1                        " 左右スクロールは一文字づつ行う
set whichwrap+=h,l,<,>,[,],b,s          " 行末・行頭から次の行へ移動可能に
set backspace=indent,eol,start          " Backspaceキーの影響範囲に制限を設けない
set nostartofline                       " ページアップ・ダウン時にカーソル位置を移動しない
set hidden                              " 変更中のファイルでの、保存しないで他のファイルを表示する
set autoread                            " 編集中のファイルが変更されたら自動で読み直す
set noswapfile                          " ファイル編集中にスワップファイルを作らない
set confirm                             " 保存されていないファイルがあるときは終了前に保存確認
" インサートモードにてffでエスケープ
inoremap ff <Esc>
" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

"----------------------------------------------------------
" visual
"----------------------------------------------------------
set number                                                " 行番号表示
set showmatch                                             " 括弧入力時の対応する括弧を表示
set list                                                  " 不可視文字の表示
set listchars=tab:»･,trail:-,extends:»,precedes:«,nbsp:%  " 不可視文字の表示形式指定
set ambiwidth=double                                      " □や○文字が崩れる問題を解決
"syntax enable

"----------------------------------------------------------
" tab function
"----------------------------------------------------------
set smarttab
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2  " smartindentで増減する幅

"----------------------------------------------------------
"" search function
"----------------------------------------------------------
set incsearch  " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase  " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch   " 検索結果をハイライト
set wrapscan   " 最後まで検索したら頭に戻る
" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
"" others
"----------------------------------------------------------
"set visualbell  " ビープ音を可視化
set vb t_vb=     " ビープ音を消す
set noerrorbells " エラーメッセージの表示時にビープを鳴らさない
set showmatch    " 対応括弧をハイライト表示する
set matchtime=3  " 対応カッコの表示秒数を3秒に

" クリップボードからのペーストの場合、自動インデントを無効
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"==========================================================
" NEO BUNDLE
"==========================================================
""" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

"----------------------------------------------------------
" インストール
"----------------------------------------------------------
NeoBundle 'gosukiwi/vim-atom-dark'          " color-theme
NeoBundle 'bronson/vim-trailing-whitespace' " 末尾の全角と半角の空白文字を赤くハイライト
NeoBundle 'itchyny/lightline.vim'           " ステータスラインの表示内容強化
NeoBundle 'ctrlpvim/ctrlp.vim'              " 多機能セレクタ
NeoBundle 'tacahiroy/ctrlp-funky'           " CtrlPの拡張プラグイン. 関数検索
NeoBundle 'suy/vim-ctrlp-commandline'       " CtrlPの拡張プラグイン. コマンド履歴検索
NeoBundle 'Yggdroot/indentLine'             " インデントの可視化
"NeoBundle 'Shougo/unite.vim'                " Unite検索
NeoBundle 'cohama/lexima.vim'               " 閉じ括弧の補完
if has('lua')
    NeoBundle 'Shougo/neocomplete.vim'      " コード自動補完
    NeoBundle "Shougo/neosnippet"           " スニペットの補完機能
    NeoBundle 'Shougo/neosnippet-snippets'  " スニペット集
endif

"----------------------------------------------------------
" setting atom-dark
"----------------------------------------------------------
syntax enable
set t_Co=256
colorscheme atom-dark-256

"----------------------------------------------------------
" ステータスラインの設定
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode     " 現在のモードを表示
set showcmd      " 打ったコマンドをステータスラインの下に表示
set ruler        " ステータスラインの右側にカーソルの現在位置を表示する

"----------------------------------------------------------
" CtrlPの設定
"----------------------------------------------------------
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100'  " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
let g:ctrlp_show_hidden = 1                                       " .(ドット)から始まるファイルも検索対象にする
let g:ctrlp_types = ['fil']                                       " ファイル検索のみ使用
let g:ctrlp_extensions = ['funky', 'commandline']                 " CtrlPの拡張として「funky」と「commandline」を使用
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id()) " CtrlPCommandLineの有効化
let g:ctrlp_funky_matchtype = 'path'                              " CtrlPFunkyの有効化

"----------------------------------------------------------
" neocomplete・neosnippetの設定
"----------------------------------------------------------
if neobundle#is_installed('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

"----------------------------------------------------------
" unite * ag setting
"----------------------------------------------------------
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_max_candidates = 200
let g:unite_source_grep_recursive_opt = ''
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,aa :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
" unite-grepの便利キーマップ
vnoremap /g y:Unite grep::-iRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
