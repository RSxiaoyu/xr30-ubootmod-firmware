#!/bin/bash
# --------------------------------------------------------
# 现代化极简自定义脚本 (针对官方 ImmortalWrt)
# 负责：UbootMod 122.5MB 大分区设备树动态微调、组件源补充
# --------------------------------------------------------

echo "[*] 开始执行官方源码自定义适配..."

# 1. 动态微调设备树，将 UBI 分区扩展为 UbootMod 122.5MB (0x7a80000)
echo "[*] 正在扫描并适配 UbootMod 122.5MB 分区偏移量..."
find target/linux/mediatek/ -name "*rax3000m*.dts*" -exec sed -i 's/0x580000 0x7200000/0x580000 0x7a80000/g' {} + 2>/dev/null || true

# 2. 默认管理 IP 设置 (192.168.1.1)
sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# 3. 动态探查 SagerNet/sing-box 最新正式版 (latest)，自动平滑接入官方 Feed
echo "[*] 正在动态探查 SagerNet/sing-box 最新官方 Release..."
LATEST_SB_TAG=$(curl -sL --connect-timeout 5 --retry 3 https://api.github.com/repos/SagerNet/sing-box/releases/latest | grep '"tag_name":' | head -n 1 | sed -E 's/.*"v?([^"]+)".*/\1/' || true)
if [ -n "$LATEST_SB_TAG" ]; then
    echo "[*] 动态解析到最新 Sing-Box 版本: v$LATEST_SB_TAG"
    sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=$LATEST_SB_TAG/g" feeds/packages/net/sing-box/Makefile
    sed -i "s/PKG_HASH:=.*/PKG_HASH:=skip/g" feeds/packages/net/sing-box/Makefile
else
    echo "[!] 动态探查超时，保留 Feed 默认版本"
fi

# 4. 修复 GNU Make 4.4+ 下 Ninja 被误限为单核 -j1 的问题，释放全核并发
sed -i 's/\$(if \$(MAKE_JOBSERVER),,-j1)//g' rules.mk

echo "[*] 官方源码适配完成。"
