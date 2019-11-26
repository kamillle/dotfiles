"-------------------------------------------------------------------------------------------------
"  ________   _______   ________  ___      ___ ___  _____ ______           ________  ________     
" |\   ___  \|\  ___ \ |\   __  \|\  \    /  /|\  \|\   _ \  _   \        |\   __  \|\   ____\    
" \ \  \\ \  \ \   __/|\ \  \|\  \ \  \  /  / | \  \ \  \\\__\ \  \       \ \  \|\  \ \  \___|    
"  \ \  \\ \  \ \  \_|/_\ \  \\\  \ \  \/  / / \ \  \ \  \\|__| \  \       \ \   _  _\ \  \       
"   \ \  \\ \  \ \  \_|\ \ \  \\\  \ \    / /   \ \  \ \  \    \ \  \       \ \  \\  \\ \  \____  
"    \ \__\\ \__\ \_______\ \_______\ \__/ /     \ \__\ \__\    \ \__\       \ \__\\ _\\ \_______\
"     \|__| \|__|\|_______|\|_______|\|__|/       \|__|\|__|     \|__|        \|__|\|__|\|_______|
"-------------------------------------------------------------------------------------------------

"-------------------------------------------------------------------------------------------------
" Include below setting
"  - command
"  - visual
"  - search
"  - dein
"  - language(ex: ruby, python)
"-------------------------------------------------------------------------------------------------

set encoding=utf-8
scriptencoding utf-8
" non-ascii の文字をyankできなくなったため一時的にコメントアウトしている
" language C
autocmd InsertLeave * set nopaste " off paste mode

set wildmenu wildmode=list:longest,full " コマンドラインモードでTABキーによるファイル名補完を有効にする
set history=1000                        " コマンドラインの履歴をXXXX件保存する
set clipboard=unnamedplus               " クリップボードの共有
set backspace=indent,eol,start          " backspaceキーの制限設定
set nostartofline                       " ページアップ・ダウン時にカーソル位置を移動しない
set whichwrap+=h,l,<,>,[,],b,s          " 行末・行頭から次の行へ移動可能に
set noswapfile                          " ファイル編集中にスワップファイルを作らない
set confirm                             " 保存されていないファイルがあるときは終了前に保存確認
set formatoptions=q                     " 改行無効化
set splitright                          " vsplitで新規画面を右に開く

"-------------------------------------------------------------------------------------------------
" command
"-------------------------------------------------------------------------------------------------
" set Leader
let mapleader = "\<Space>"

" : の代わりに leader で主要な操作を置き換える
nnoremap <Leader>w :w<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>qq :q!<CR>
nnoremap <Leader>vs :vs<CR>

" Y でカーソル位置から行末までコピー
nnoremap Y y$

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
" 開いているファイルのvisualモードで選択している行のgithubページを開く
xnoremap :og :OpenGithubFile<CR>
" alias fzf commands
nnoremap RR :Rg<CR>
nnoremap <Leader>b :Fzfbuffer<CR>
nnoremap <Leader>h :Fzfhistory<CR>
" sudo write の alias
nnoremap <Leader>sudow :w !sudo tee %<CR>
" start terminal mode by `sh`
nnoremap sh :belowright :terminal<CR>
tnoremap <silent> <C-q> <C-\><C-n>
" visualモードの選択範囲にペーストした際に、置き換えた文字列がクリップボードに入らないようにする
xnoremap <expr> p 'pgv"'.v:register.'y`>'

"-------------------------------------------------------------------------------------------------
" visual
"-------------------------------------------------------------------------------------------------
syntax enable
set background=dark
colorscheme solarized

set number                                                " 行番号表示
set list                                                  " 不可視文字の表示
set listchars=tab:»･,trail:-,extends:»,precedes:«,nbsp:%  " 不可視文字の表示形式指定
set ambiwidth=double                                      " □や○文字が崩れる問題を解決
set laststatus=2                                          " ステータスラインを常に表示
set updatetime=250                                        " vim-gitgutterによる差分マーカーの反映する時間の調節(default: 4000)
set lazyredraw                                            " マクロやコマンドを実行する間、画面を再描画しない(スクロールが重くなる対策)
set ttyfast                                               " 高速ターミナル接続を行う(スクロールが重くなる対策)

" 以降インデントの設定
set smarttab
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2  " smartindentで増減する幅
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.go setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.go set nolist " go fmt がタブを使うので可視化しないようにしておく
augroup END
filetype plugin on " gocodeの設定

"-------------------------------------------------------------------------------------------------
"" search
"-------------------------------------------------------------------------------------------------
set incsearch  " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase  " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch   " 検索結果をハイライト
set wrapscan   " 最後まで検索したら頭に戻る
set cscopetag  " ctags で <C-]> した時に候補が複数ある場合はリストを表示する
" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"-------------------------------------------------------------------------------------------------
"" dein
"-------------------------------------------------------------------------------------------------
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

  " TOML ファイルがあるディレクトリ
  let s:toml_dir = expand('~/dotfiles/neovim/toml')

  " 起動時に読み込む
  call dein#load_toml(s:toml_dir . '/default.toml', {'lazy': 0})
  " 遅延読み込みする
  call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" vim起動時にinstallされていないプラグインを見つけたらinstallする
if dein#check_install()
  call dein#install()
endif

"-------------------------------------------------------------------------------------------------
"" Language
"-------------------------------------------------------------------------------------------------
" .rb ファイルを開く際に ruby_path, ruby_host_progを指定しておくことでvimの起動を早くできるので指定している
" ruby2.6.2 と 2.6.2にinstallしてあるneovim-ruby-host(neovimgem)を利用している
let g:ruby_path="~/.rbenv/versions/2.6.2/bin/ruby" " provider/ruby.vim に効果あり。デメリットもあるらしいので注意
let g:ruby_host_prog='~/.rbenv/versions/2.6.2/bin/neovim-ruby-host' "ftplugin/ruby.vim に効果あり

let g:python3_host_prog = expand('~/.pyenv/shims/python')

let g:go_fmt_command        = 'goimports'
let g:go_def_mode           = 'gopls'
let g:go_metalinter_command = 'golangci-lint'
