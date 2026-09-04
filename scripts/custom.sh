#!/bin/bash
# --------------------------------------------------------
# 现代化极简自定义脚本
# 负责修剪不必要的 Feed、注入前沿轻量组件
# --------------------------------------------------------

echo "[*] 开始执行自定义构建调整..."

# 1. 默认管理 IP 设置 (按需修改，默认 192.168.1.1)
sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# 2. 保证 sing-box 与 argon 主题源可用 (若上游 feed 未自带则按需 clone)
if [ ! -d "package/feeds/luci/luci-app-sing-box" ] && [ ! -d "package/luci-app-sing-box" ]; then
    echo "[*] 拉取 luci-app-sing-box..."
    git clone --depth 1 https://github.com/satflow/luci-app-sing-box.git package/luci-app-sing-box 2>/dev/null || true
fi

echo "[*] 自定义脚本执行完成。"
