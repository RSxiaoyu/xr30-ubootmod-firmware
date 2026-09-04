# XR30 官方纯血固件 (UbootMod)

面向中国移动 XR30 (联发科 MT7981B / 122.5MB 大分区) 的极简、高性能 ImmortalWrt 固件。  
100% 依托官方正统源与纯开源驱动，拒绝任何侵入式魔改补丁。

## 特性

- **正统基线**：动态追踪官方最新稳定 Release，Linux 6.12 LTS 内核
- **满血流控**：PPE 硬件 NAT 卸载 + WED 无线加速，千兆跑满 0% CPU
- **开源无线**：官方 `kmod-mt76` 驱动，5G 默认 160MHz (信道 36)
- **内存防护**：ZRAM 128MB (`zstd` 高倍动态压缩)，彻底杜绝 256MB 内存 OOM
- **网络分流**：官方 `HomeProxy` + `sing-box` (TProxy + Fake-IP)
- **开箱即用**：Argon 主题，主机名默认 `XR30`，免密即连

## 刷机

1. 路由器按住 Reset 开机进入 UbootMod 控制台 (`192.168.1.1`)。
2. 上传 [Releases](../../releases) 中的 `*sysupgrade.itb` 固件直接刷入。
3. 开机后访问 `192.168.1.1` 进入管理面板。
