# 使用 jlesage/baseimage-gui 作为基础镜像（内置 VNC + Web 访问）
FROM jlesage/baseimage-gui:ubuntu-24.04-v4

# 安装 Navicat 运行依赖 + 中文字体
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfuse2 \
    wget \
    ca-certificates \
    locales \
    fonts-wqy-zenhei \
    fonts-wqy-microhei \
    fonts-noto-cjk \
    # OpenGL / X11 / Qt 运行时依赖
    libgl1 \
    libegl1 \
    libxkbcommon0 \
    libdbus-1-3 \
    libxcb-cursor0 \
    libxcb-icccm4 \
    libxcb-keysyms1 \
    libxcb-shape0 \
    # GLib / Pango 运行时依赖
    libglib2.0-0 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 生成中文 locale
RUN locale-gen zh_CN.UTF-8 && locale-gen en_US.UTF-8
ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

# 下载并解压 Navicat 17 Premium AppImage
RUN wget -q -O /tmp/navicat.AppImage \
    "https://dn.navicat.com.cn/download/navicat17-premium-cs-x86_64.AppImage" && \
    chmod +x /tmp/navicat.AppImage && \
    cd /tmp && ./navicat.AppImage --appimage-extract && \
    mv /tmp/squashfs-root /opt/navicat && \
    rm /tmp/navicat.AppImage

# 复制启动脚本
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

# 设置应用名称和图标
RUN set-cont-env APP_NAME "Navicat Premium 17"
RUN APP_ICON_URL=/opt/navicat/navicat-icon.png && \
    install_app_icon.sh "$APP_ICON_URL"

# 默认分辨率
ENV DISPLAY_WIDTH=1920
ENV DISPLAY_HEIGHT=1080
