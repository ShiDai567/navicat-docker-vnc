#!/bin/sh

# 重置试用期
# dconf reset -f /com/premiumsoft/navicat-premium/ 2>/dev/null
# rm -f ~/.config/navicat/Premium/preferences.json
# rm -f ~/.config/navicat/Premium/preferences.json.lock
 
# echo "✅ 已重置试用期！"

# 确保配置目录权限
chmod -R 777 /root/.config/navicat 2>/dev/null || true

exec /opt/navicat/AppRun
