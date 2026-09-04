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

# 3. 保证 luci-app-sing-box 可用 (若上游 feed 未自带则自动补充)
if [ ! -d "package/feeds/luci/luci-app-sing-box" ] && [ ! -d "package/luci-app-sing-box" ]; then
    echo "[*] 拉取 luci-app-sing-box..."
    git clone --depth 1 https://github.com/satflow/luci-app-sing-box.git package/luci-app-sing-box 2>/dev/null || true
fi

echo "[*] 官方源码适配完成。"
