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

# 3. 升级官方 Feed 中的 sing-box 至最新的 1.14.0
sed -i 's/PKG_VERSION:=1.12.25/PKG_VERSION:=1.14.0/g' feeds/packages/net/sing-box/Makefile
sed -i 's/PKG_HASH:=881435f07b5ab8170ccf3cb69e87130759521dc0ed1ae4bfeacbe7772a93a158/PKG_HASH:=87baf6852e37941cbe40bdd94bec81c957c88a56751cecd6bbf0e6108bc69398/g' feeds/packages/net/sing-box/Makefile

# 4. 修复 GNU Make 4.4+ 下 Ninja 被误限为单核 -j1 的问题，释放全核并发
sed -i 's/\$(if \$(MAKE_JOBSERVER),,-j1)//g' rules.mk

echo "[*] 官方源码适配完成。"
