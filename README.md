# XR30 官方开源纯血固件构建工程 (UbootMod 版)

面向 **中国移动 XR30 (MT7981B / 256M RAM / 128M NAND / UbootMod)** 的极简、现代化、前沿 OpenWrt 构建工程。

基于官方 **`immortalwrt/immortalwrt`** 正统纯血源码，动态追踪最新稳定 Release（亦可指定快照），采用 **100% 开源驱动 (`mt76`)** 与 WED 硬件加速，彻底摒弃第三方侵入式私有补丁。

## 技术栈

- **官方底座**：动态自动探测并构建最新官方发行版（支持 `openwrt-25.12` / `master`）
- **纯粹开源无线**：`kmod-mt76` (mac80211) + WED 硬件加速，5GHz 默认 160MHz (信道 36)
- **硬件卸载**：PPE 硬件 NAT 卸载 (千兆/300M 跑满 0% CPU) + BBR
- **内存防御**：ZRAM 128MB (`zstd` 算法高倍率动态压缩)，彻底杜绝 256MB 内存 OOM
- **网络分流**：`sing-box` (TProxy + Fake-IP) + `fw4` (nftables)
- **管理界面**：Argon 主题

## 刷机说明

1. 路由器长按 Reset 键开机进入 **UbootMod** 控制台 (`192.168.1.1`)。
2. 上传 [Releases](../../releases) 中的 `*sysupgrade*` 镜像直接刷入。
3. 默认管理地址：`192.168.1.1`（无密码，Wi-Fi 默认开启）。

## 自定义配置

- **软件增减**：编辑 [`config/xr30-seed.config`](config/xr30-seed.config)
- **首次开机预设**：编辑 [`files/etc/uci-defaults/99-default-settings`](files/etc/uci-defaults/99-default-settings)
