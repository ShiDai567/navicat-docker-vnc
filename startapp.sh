#!/bin/sh

# 重置试用期
# dconf reset -f /com/premiumsoft/navicat-premium/ 2>/dev/null
# rm -f ~/.config/navicat/Premium/preferences.json
# rm -f ~/.config/navicat/Premium/preferences.json.lock
 
# echo "✅ 已重置试用期！"

# 修复 SSH: 基础镜像 HOME=/dev/null 导致无法写入 known_hosts
export HOME=/config
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# 确保配置目录权限
# chmod -R 777 /root/.config/navicat 2>/dev/null || true

exec /opt/navicat/AppRun
