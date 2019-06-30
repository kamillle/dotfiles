# TODO
## fix denite setting
https://qiita.com/delphinus/items/de15250b39ac08e9c0b9
https://github.com/Shougo/denite.nvim/blob/master/doc/denite.txt

## ref documentation from vim
https://qiita.com/alpaca_taichou/items/ab2ad83ddbaf2f6ce7fb#vim-ref-vim-ref-ri
https://gist.github.com/alpaca-tc/4521470

# memo
## remove plugins

```
# check not used plugins
:echo dein#check_clean()

# remove not used plugins
:call map(dein#check_clean(), "delete(v:val, 'rf')")


# return empty list
:echo dein#check_clean()
```

# plugins list
- https://github.com/szw/vim-tags
  - メソッドの定義元にジャンプする
- https://github.com/osyo-manga/vim-anzu
  - 検索結果の数とかを表示する
- https://github.com/tomtom/tcomment_vim
  - 複数行コメントアウト
