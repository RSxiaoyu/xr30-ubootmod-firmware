# xr30-ubootmod-firmware

中国移动 XR30（NAND 版）的 ImmortalWrt 极简构建：官方源码、官方设备定义、官方 U-Boot 布局，零补丁。

XR30 在 ImmortalWrt 中没有独立设备定义，本仓库使用硬件一致的孪生机型 **CMCC RAX3000M**（MT7981B / 256MB / 128MB NAND）。镜像与升级元数据沿用官方 `cmcc_rax3000m` 命名，未做本地化重命名。

## 构建

GitHub Actions 全自动：push 到 `main` 或手动触发，构建完成自动发布 Release。

| 产物 | 用途 |
|---|---|
| `*-sysupgrade.itb` | 日常升级镜像 |
| `*-initramfs-recovery.itb` | 首次刷机 / 救砖引导镜像 |
| `*-nand-preloader.bin` / `*-nand-bl31-uboot.fip` | 官方 OpenWrt U-Boot（bl2 + fip） |
| `sha256sums.txt` | 全部文件校验 |

## 刷机（官方 OpenWrt U-Boot 路径）

1. 写入 `*-nand-preloader.bin` 与 `*-nand-bl31-uboot.fip`（已有 OpenWrt/第三方系统可 dd；原厂系统需先取得写权限）
2. U-Boot 菜单 TFTP 引导 `*-initramfs-recovery.itb`
3. LuCI 系统升级刷入 `*-sysupgrade.itb`

> 25.12 起基础设备树不含分区表，分区定义在 NAND overlay 中，官方 U-Boot 以
> `bootconf=config-1#mt7981b-cmcc-rax3000m-nand` 多配置 FIT 引导。
> **不可使用只认单配置 FIT 的旧 bootloader**，否则内核无法挂载 rootfs。

### 替代：社区 U-Boot Mod（122.5MB 大分区）

若使用社区大分区 bootloader，克隆源码后、编译前执行：

```sh
sed -i 's/0x580000 0x7200000/0x580000 0x7a80000/g' \
  target/linux/mediatek/dts/mt7981b-cmcc-rax3000m-nand.dtso
```

前提同上：bootloader 须支持 FIT 多配置 overlay 引导。

## 与上游默认的差异

编译期（`config/`）与首启（`files/`）各只有数条，其余全部依赖上游默认：

- 设备级：PPE 硬件 NAT 卸载（fw4 默认关闭）、BBR、ZRAM 压缩算法 zstd、主机名
- 选装：HomeProxy（sing-box）、Argon 主题、htop / curl
- Wi-Fi 不做预设：默认已开启、`CN` 法规域、5G HE80；信道 / 频宽 / SSID 开机后在 LuCI 设置
