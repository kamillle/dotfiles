### 基本設定 ###
# クラッシュレポートの無効化
defaults write com.apple.CrashReporter DialogType -string "none"
# ネットワークディスクで、`.DS_Store` ファイルを作らない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# 日付表示設定、曜日を表示
defaults write com.apple.menuextra.clock 'DateFormat' -string 'EEE H:mm'
# スクリーンショット保存形式をPNGにする
defaults write com.apple.screencapture type -string "png"


### Dock設定 ###
# Dockで開いているアプリケーションのインジケータライトを表示する
defaults write com.apple.dock show-process-indicators -bool true

# Dockが早く表示されるようにする
defaults write com.apple.dock autohide-delay -float 0 && killall Dock
# NOTE: 元に戻す場合は下記を実行する
# defaults delete com.apple.dock autohide-delay;killall Dock
# defaults delete com.apple.dock autohide-time-modifier;killall Dock

### Finder設定 ###
defaults irite com.apple.finder AppleShowAllFiles -bool true

# 全ての拡張子のファイルを表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

### Safari設定(safari使わないけど念の為) ###
# 検索クエリをAppleへ送信しない
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# アドレスバーに表示されるURLを全表示
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

defaults write com.apple.mouse.tapBehavior 1
defaults write com.apple.trackpad.enableSecondaryClick 1
defaults write com.apple.trackpad.fiveFingerPinchSwipeGesture 2
defaults write com.apple.trackpad.fourFingerHorizSwipeGesture 2
defaults write com.apple.trackpad.fourFingerPinchSwipeGesture 2
defaults write com.apple.trackpad.fourFingerVertSwipeGesture 2
defaults write com.apple.trackpad.momentumScroll 1
defaults write com.apple.trackpad.pinchGesture 1
defaults write com.apple.trackpad.rotateGesture 1
defaults write com.apple.trackpad.scrollBehavior 2
defaults write com.apple.trackpad.threeFingerDragGesture 1
defaults write com.apple.trackpad.threeFingerHorizSwipeGesture 0
defaults write com.apple.trackpad.threeFingerTapGesture 2
defaults write com.apple.trackpad.threeFingerVertSwipeGesture 0
defaults write com.apple.trackpad.twoFingerDoubleTapGesture 1
defaults write com.apple.trackpad.twoFingerFromRightEdgeSwipeGesture 3
defaults write com.apple.trackpad.version 5
defaults write PKSecureElementAvailableFlagsByHost 3
