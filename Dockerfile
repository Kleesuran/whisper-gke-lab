# 1. 基础镜像：选择一个预装了 Python 的 Linux 系统
FROM python:3.10-slim
# 2. 设置工作目录：进入容器后的“家”
WORKDIR /app
# 3. 安装系统依赖：Whisper 需要 FFmpeg 来处理音频，还需要 Rust 编译器
RUN apt-get update && apt-get install -y \
  ffmpeg \
  rustc \
  cargo \
  && rm -rf /var/lib/apt/lists/*
# 4. 拷贝清单并安装 Python 依赖
# 品鉴点：先拷清单再装包，可以利用 Docker 的缓存机制 (Layer Caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# 5. 拷贝业务代码
COPY app.py .
# 6. 暴露端口：我们的 FastAPI 跑在 8000 端口
EXPOSE 8000
# 7. 启动命令：使用 uvicorn 运行我们的 API
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
