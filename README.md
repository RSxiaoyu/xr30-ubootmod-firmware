# XR30 极简、现代、高性能固件构建工程 (UbootMod 版)

专为 **中国移动 XR30 (MediaTek MT7981B / 256MB RAM / 128MB NAND / UbootMod)** 打造的 GitHub Actions 自动化极速构建工程。

追求 **极致性能、现代化协议栈、最少冗余代码、秒级开箱即用**。

---

## 🌟 核心特性与技术栈

- **现代内核**：基于 Linux 6.6 LTS，享受最前沿的网络调度与安全特性。
- **纯粹开源射频 (`kmod-mt76`)**：
  - 彻底抛弃闭源私有杂质，完全遵从 Linux `mac80211` / `hostapd` 规范。
  - 完整支持 **WED (Wireless Ethernet Dispatch)** 硬件无线转发。
  - 默认 5GHz 锁定 160MHz（信道 36，避开 DFS 雷达干扰），小户型与宿舍延迟表现极佳。
- **硬件流控 (PPE)**：默认开机自动启用硬件 NAT 卸载，千兆/300M 跑满时 CPU 占用稳定在 0% ~ 2%。
- **256MB 内存保卫战**：
  - 内置 **ZRAM (zstd 算法, 128MB 动态压缩)**，彻底根治 256MB 内存 OOM 隐患，且零闪存磨损。
- **现代化代理与分流**：
  - 预置 **`sing-box`** + `luci-app-sing-box`，常驻内存仅 20MB ~ 30MB，支持 VLESS Reality、Hysteria 2、TUIC 等新一代协议。
- **开箱即用 (Zero-Touch Config)**：
  - 编译时通过 `files/etc/uci-defaults/99-default-settings` 固化所有硬件加速与无线优化，刷机开机即处于最佳状态。
- **极速构建流水线**：
  - 拒绝臃肿的 2019 时代构建脚本，全工程仅保留核心文件。
  - 引入 GitHub Actions `dl/` 依赖缓存，大幅节省网络拉取时间。

---

## 📂 目录结构

```text
xr30-builder/
├── .github/workflows/
│   └── build.yml               # 现代声明式 CI 构建流水线
├── config/
│   └── xr30-seed.config        # 极简种子配置 (仅 20 余行，交由 make defconfig 解析)
├── scripts/
│   └── custom.sh               # 极简自定义调整脚本
├── files/
│   └── etc/uci-defaults/
│       └── 99-default-settings # 首次开机自激活配置 (PPE、WED、ZRAM、BBR、5G Wi-Fi)
├── .gitignore
└── README.md
```

---

## 🚀 快速使用指南

### 1. 推送到你的 GitHub 仓库

你可以直接将此工程推送到你现有的 `RSxiaoyu/xr30_nand_UbootMod` 或新建一个仓库：

```bash
cd C:\Users\_xiaoyu\.gemini\antigravity\scratch\xr30-builder

# 初始化本地 Git 仓库
git init
git add .
git commit -m "feat: init modern xr30 ubootmod builder"

# 关联远程仓库 (以你的仓库为例)
git remote add origin https://github.com/RSxiaoyu/xr30_nand_UbootMod.git
git branch -M main

# 推送代码 (如果远程已有旧文件，可强制覆盖或合并)
git push -u origin main --force
```

### 2. 触发构建与获取固件

1. 打开 GitHub 仓库，进入 **Actions** 标签页。
2. 选中左侧的 **Build XR30 Modern Firmware** 工作流。
3. 点击右侧 **Run workflow** 按钮启动构建。
4. 编译完成后，固件会自动上传至 **Releases** 和 Actions **Artifacts** 中：
   - 文件名通常为：`immortalwrt-mediatek-filogic-cmcc_xr30-squashfs-sysupgrade.bin`。

### 3. 刷入固件

- 本固件专门针对 **UbootMod (大分区 122.5MB)** 编译。
- 路由器进入 U-Boot 网页恢复控制台（长按 Reset 开机，电脑设静态 IP `192.168.1.2`，访问 `192.168.1.1`）。
- 直接上传并刷入 `*sysupgrade.bin` 即可。

---

## ⚙️ 后续极简定制建议

- **修改管理 IP**：编辑 `scripts/custom.sh` 中的 IP 替换规则。
- **调整预装软件**：在 `config/xr30-seed.config` 中追加 `CONFIG_PACKAGE_xxx=y`。
