set encoding=utf-8
scriptencoding utf-8
" non-ascii の文字をyankできなくなったため一時的にコメントアウトしている
" language C

set wildmenu wildmode=list:longest,full " コマンドラインモードでTABキーによるファイル名補完を有効にする
set history=1000                        " コマンドラインの履歴をXXXX件保存する
set clipboard=unnamed                   " クリップボードの共有
set backspace=indent,eol,start          " backspaceキーの制限設定
set nostartofline                       " ページアップ・ダウン時にカーソル位置を移動しない
set whichwrap+=h,l,<,>,[,],b,s          " 行末・行頭から次の行へ移動可能に
set noswapfile                          " ファイル編集中にスワップファイルを作らない
set confirm                             " 保存されていないファイルがあるときは終了前に保存確認
set formatoptions=q                     " 改行無効化
syntax enable
set background=dark
colorscheme solarized

inoremap <silent> jj <ESC>
" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
nnoremap <F1> <nop>
" タブの設定
nnoremap tt :<C-u>tabnew<CR>
nnoremap tl gT
nnoremap tr gt
nnoremap tc :tabclose<CR>
" 開いているファイルのgithubページを開く
nnoremap :og :OpenGithubFile<CR>
" fzf
nnoremap RR :Rg <CR>

"----------------------------------------------------------
" visual
"----------------------------------------------------------
set number                                                " 行番号表示
set list                                                  " 不可視文字の表示
set listchars=tab:»･,trail:-,extends:»,precedes:«,nbsp:%  " 不可視文字の表示形式指定
set ambiwidth=double                                      " □や○文字が崩れる問題を解決

let g:airline_powerline_fonts = 1 " airlineでかっこよく
set laststatus=2                  " ステータスラインを常に表示
let g:airline_theme = 'raven'     " テーマの指定

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
" pythonファイルを編集する際はshiftwidthを4にする
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

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
"" dein Settings
"----------------------------------------------------------
if &compatible
  set nocompatible
endif
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  let s:toml_dir = expand('~/dotfiles/.vim/toml')

  " 起動時に読み込む
  call dein#load_toml(s:toml_dir . '/default.toml', {'lazy': 0})
  " 遅延読み込みする
  call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

let g:python3_host_prog = expand('~/.pyenv/shims/python')
