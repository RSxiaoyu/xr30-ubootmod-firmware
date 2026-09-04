# xr30-ubootmod-firmware

基于 ImmortalWrt 官方源码构建的中国移动 XR30 固件（MT7981B / UbootMod 122.5MB 大分区）。

## 特性

- 官方开源驱动 (`kmod-mt76` + WED) 与 PPE 硬件 NAT 卸载
- 128MB ZRAM (`zstd`) 内存压缩
- 官方 `HomeProxy` (`sing-box`) 代理
- 5GHz 默认 160MHz（信道 36）
- Argon 主题，管理地址 `192.168.1.1`
