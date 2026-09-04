#!/bin/bash
set -e

# 设置本地代理以加速下载
export http_proxy=http://127.0.0.1:20122
export https_proxy=http://127.0.0.1:20122
export all_proxy=socks5://127.0.0.1:20122

cd /home/dev/xr30-build

echo "========================================="
echo "🚀 启动本地极速编译 (目标: 20 线程全核并发)"
echo "========================================="

# 1. 克隆官方 openwrt-25.12 源码
if [ ! -d "openwrt/.git" ]; then
    echo "[*] 克隆 immortalwrt/immortalwrt (openwrt-25.12)..."
    git clone --depth 1 -b openwrt-25.12 https://github.com/immortalwrt/immortalwrt.git openwrt
fi

cd openwrt

# 2. 更新与安装 Feeds
echo "[*] 更新与安装 Feeds..."
./scripts/feeds update -a
./scripts/feeds install -a

# 3. 运行适配与自定义设置
echo "[*] 应用 UbootMod 设备树微调与配置..."
chmod +x ../scripts/custom.sh
../scripts/custom.sh
if [ -d ../files ]; then
    mkdir -p files
    cp -rf ../files/* files/ 2>/dev/null || true
    chmod -R +x files/etc/uci-defaults/ 2>/dev/null || true
fi

# 4. 载入种子配置并生成完整配置
echo "[*] 合并种子配置生成编译配置..."
cp -f ../config/xr30-seed.config .config
make defconfig

# 5. 并发下载依赖
echo "[*] 多线程下载依赖包..."
make download -j$(nproc)
find dl -size -1024c -exec rm -f {} +

# 6. 全核火力全开
echo "[*] 开始 20 线程全核编译..."
make -j$(nproc) || make -j1 V=s

echo "========================================="
echo "🎉 本地编译成功！"
echo "========================================="

# 7. 整理产物
mkdir -p /home/dev/xr30-build/output
cd bin/targets/mediatek/filogic
cp -f *rax3000m* /home/dev/xr30-build/output/ 2>/dev/null || cp -f *sysupgrade* /home/dev/xr30-build/output/ 2>/dev/null || true

cd /home/dev/xr30-build/output
for f in *rax3000m*sysupgrade*; do
  if [ -f "$f" ]; then
    cp "$f" "$(echo "$f" | sed 's/cmcc_rax3000m/cmcc_xr30-ubootmod/g')" 2>/dev/null || true
  fi
done
sha256sum * > sha256sums.txt

echo "[*] 固件产物列表:"
ls -la /home/dev/xr30-build/output
