# Navicat Docker VNC

通过 Docker 容器运行 Navicat Premium 17，使用浏览器或 VNC 客户端远程访问图形界面。

## 技术栈

| 组件 | 说明 |
|------|------|
| 基础镜像 | [jlesage/baseimage-gui:ubuntu-24.04-v4](https://github.com/jlesage/docker-baseimage-gui)（内置 TigerVNC + noVNC + Nginx） |
| 应用 | Navicat Premium 17 (AppImage) |
| 中文支持 | 文泉驿正黑 / 微米黑 / Noto CJK + `zh_CN.UTF-8` locale |

## 快速开始

### 1. 构建并启动

```bash
docker compose up -d --build
```

### 2. 访问 Navicat

| 方式 | 地址 |
|------|------|
| 浏览器（推荐） | http://localhost:5800 |
| VNC 客户端 | localhost:5900 |

### 3. 停止 / 重启

```bash
docker compose down       # 停止并移除容器
docker compose restart    # 重启容器
```

## 目录结构

```
.
├── Dockerfile           # 镜像构建文件
├── docker-compose.yml   # 编排配置
├── startapp.sh          # 容器内应用启动脚本
└── data/                # 持久化数据（已 gitignore）
    ├── config/          # Navicat 配置 & 连接信息
    └── logs/            # 应用日志
```

## 环境变量

在 `docker-compose.yml` 中可配置：

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `TZ` | `Asia/Shanghai` | 时区 |
| `DISPLAY_WIDTH` | `1920` | 显示宽度（像素） |
| `DISPLAY_HEIGHT` | `1080` | 显示高度（像素） |
| `KEEP_APP_RUNNING` | `1` | 应用崩溃后自动重启 |
| `DARK_MODE` | `0` | 设为 `1` 启用暗色模式 |
| `WEB_FILE_MANAGER` | `0` | 设为 `1` 启用 Web 文件管理器 |

更多变量参见 [baseimage-gui 文档](https://github.com/jlesage/docker-baseimage-gui#environment-variables)。

## 注意事项

- 首次构建需要下载 Navicat AppImage（~120MB），请确保网络畅通
- 连接信息保存在 `data/config/` 目录下，删除该目录将丢失所有连接配置
- 如果宿主机 Docker 使用 `overlay2` 存储驱动遇到权限问题，可切换为 `vfs`：
  ```bash
  echo '{"storage-driver": "vfs"}' | sudo tee /etc/docker/daemon.json
  sudo systemctl restart docker
  ```
