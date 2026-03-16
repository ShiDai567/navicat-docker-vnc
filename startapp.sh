#!/bin/sh

# 重置试用期
# dconf reset -f /com/premiumsoft/navicat-premium/ 2>/dev/null
# rm -f ~/.config/navicat/Premium/preferences.json
# rm -f ~/.config/navicat/Premium/preferences.json.lock
 
# echo "✅ 已重置试用期！"

exec /opt/navicat/AppRun
