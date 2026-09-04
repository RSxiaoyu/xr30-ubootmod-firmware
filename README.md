# XR30 UbootMod Firmware

面向 **中国移动 XR30 (MT7981B / 256M RAM / 128M NAND / UbootMod)** 的极简、前沿 OpenWrt/ImmortalWrt 固件构建工程。

## 技术栈

- **内核**：Linux 6.6 LTS
- **无线**：开源 `mt76` (mac80211) + WED 硬件分流，5GHz 默认 160MHz (信道 36)
- **硬件加速**：PPE 硬件 NAT 卸载 (跑满 0% CPU) + BBR 拥塞控制
- **内存防护**：ZRAM 128MB (`zstd` 极速动态压缩)，防 256MB 内存 OOM
- **现代网络栈**：`sing-box` (TProxy + Fake-IP) + `fw4` (nftables)
- **管理界面**：Argon 主题

## 刷机说明

1. 路由器长按 Reset 键开机进入 **UbootMod** 控制台 (`192.168.1.1`)。
2. 上传 [Releases](../../releases) 中的 `*sysupgrade.bin` 固件直接刷入。
3. 默认管理地址：`192.168.1.1`（无密码，Wi-Fi 默认启用）。

## 配置调整

- **软件增减**：编辑 [`config/xr30-seed.config`](config/xr30-seed.config)
- **首次开机预设**：编辑 [`files/etc/uci-defaults/99-default-settings`](files/etc/uci-defaults/99-default-settings)
