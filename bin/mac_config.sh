### 基本設定 ###
# クラッシュレポートの無効化
defaults write com.apple.CrashReporter DialogType -string "none"
# ネットワークディスクで、`.DS_Store` ファイルを作らない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# 日付表示設定、曜日を表示
defaults write com.apple.menuextra.clock 'DateFormat' -string 'EEE H:mm'

### Dock設定 ###
# Dockで開いているアプリケーションのインジケータライトを表示する
defaults write com.apple.dock show-process-indicators -bool true
# do not show recently used apps
defaults write com.apple.dock "show-recents" -bool "false"

defaults write com.apple.dock "orientation" -string "right"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-time-modifier" -float "0.3"
defaults write com.apple.dock "autohide-delay" -float "0"
defaults write com.apple.dock "mineffect" -string "scale"

killall Dock

### Safari設定(safari使わないけど念の為) ###
# 検索クエリをAppleへ送信しない
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
