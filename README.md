# Navicat Docker VNC

通过 Docker 容器运行 Navicat Premium 17，使用浏览器或 VNC 客户端远程访问图形界面。

## 技术栈

| 组件 | 说明 |
|------|------|
| 基础镜像 | [jlesage/baseimage-gui:ubuntu-24.04-v4](https://github.com/jlesage/docker-baseimage-gui)（内置 TigerVNC + noVNC + Nginx） |
| 应用 | Navicat Premium 17 (AppImage) |
| 中文支持 | 文泉驿正黑 / 微米黑 / Noto CJK + `zh_CN.UTF-8` locale |

## 快速开始

### 生产环境（推荐）

直接拉取预构建镜像，无需本地构建：

```bash
docker compose up -d
```

镜像来源：`ghcr.io/shidai567/navicat-docker-vnc:latest`

### 开发环境

本地构建镜像，用于调试和开发：

```bash
docker compose -f docker-compose.dev.yml up -d --build
```

### 访问 Navicat

| 方式 | 地址 | 说明 |
|------|------|------|
| 浏览器（推荐） | http://localhost:5800 | 生产 & 开发 |
| VNC 客户端 | localhost:5900 | 仅开发环境 |

### 停止

```bash
# 生产
docker compose down

# 开发
docker compose -f docker-compose.dev.yml down
```

## 目录结构

```
.
├── Dockerfile              # 镜像构建文件
├── startapp.sh             # 容器内应用启动脚本
├── docker-compose.yml      # 生产环境（拉取预构建镜像）
├── docker-compose.dev.yml  # 开发环境（本地构建）
├── .github/workflows/      # GitHub Actions CI/CD
├── .gitlab-ci.yml          # GitLab CI/CD
└── data/                   # 持久化数据（已 gitignore）
    ├── config/             # Navicat 配置 & 连接信息
    └── logs/               # 应用日志
```

## 环境变量

在 `docker-compose.yml` 或 `docker-compose.dev.yml` 中可配置：

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `TZ` | `Asia/Shanghai` | 时区 |
| `DISPLAY_WIDTH` | `1920` | 显示宽度（像素） |
| `DISPLAY_HEIGHT` | `1080` | 显示高度（像素） |
| `KEEP_APP_RUNNING` | `1` | 应用崩溃后自动重启 |
| `VNC_PASSWORD` | `navicat` | VNC 连接密码（生产环境） |
| `DARK_MODE` | `0` | 设为 `1` 启用暗色模式 |
| `WEB_FILE_MANAGER` | `0` | 设为 `1` 启用 Web 文件管理器 |

更多变量参见 [baseimage-gui 文档](https://github.com/jlesage/docker-baseimage-gui#environment-variables)。

## CI/CD

推送 tag 或代码到 `main` 分支时，自动构建镜像并推送到平台容器仓库：

| 平台 | 触发条件 | 推送目标 |
|------|----------|----------|
| GitHub Actions | push `main` / `v*` tag | `ghcr.io` |
| GitLab CI | push tag | GitLab Container Registry |

```bash
# 发布新版本
git tag v1.0.0
git push origin v1.0.0
```

## 注意事项

- 连接配置保存在 `data/config/` 目录下，删除该目录将丢失所有连接配置
- 首次本地构建需要下载 Navicat AppImage（~120MB），请确保网络畅通
