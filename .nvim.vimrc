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
"" plugin's setting
"-------------------------------------------------------------------------------------------------
" .rb ファイルを開く際に ruby_path, ruby_host_progを指定しておくことでvimの起動を早くできるので指定している
" ruby2.6.2にinstallしてあるneovim-ruby-host(neovimgem)を利用している
let g:ruby_path="~/.rbenv/versions/2.7.1/bin/ruby" " provider/ruby.vim に効果あり。デメリットもあるらしいので注意
let g:ruby_host_prog='~/.rbenv/versions/2.7.1/bin/neovim-ruby-host' "ftplugin/ruby.vim に効果あり

let g:python3_host_prog = expand('~/.pyenv/shims/python')

let g:go_fmt_command        = 'goimports'
let g:go_def_mode           = 'gopls'
let g:go_metalinter_command = 'golangci-lint'

colorscheme solarized

" 開いているファイルのgithubページを開く
nnoremap :og :OpenGithubFile<CR>
" 開いているファイルのvisualモードで選択している行のgithubページを開く
xnoremap :og :OpenGithubFile<CR>
" alias fzf commands
nnoremap RR :Rg<CR>
nnoremap Fz :Fzfbuffer<CR>
nnoremap Fh :Fzfhistory<CR>
