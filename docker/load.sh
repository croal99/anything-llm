#!/bin/bash

# ======================================
# Anything LLM Docker 启动脚本
# 使用当前目录作为存储位置
# ======================================

# 使用当前目录作为存储位置
STORAGE_LOCATION="$(pwd)"

echo "🚀 正在启动 Anything LLM Docker 容器..."
echo "📁 存储位置: $STORAGE_LOCATION"

# 创建 .env 文件（如果不存在）
if [ ! -f "$STORAGE_LOCATION/.env" ]; then
    echo "📝 创建 .env 文件..."
    touch "$STORAGE_LOCATION/.env"
fi

# 运行 Docker 容器
docker run -d --rm -p 3001:3001 \
  --cap-add SYS_ADMIN \
  -v "${STORAGE_LOCATION}:/app/server/storage" \
  -v "${STORAGE_LOCATION}/.env:/app/server/.env" \
  -e STORAGE_DIR="/app/server/storage" \
  mintplexlabs/anythingllm

# 检查容器是否成功启动
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 容器已成功启动！"
    echo "🌐 访问地址: <http://localhost:3001>"
    echo ""
    echo "📋 查看容器日志: docker logs -f $(docker ps -q -f "ancestor=mintplexlabs/anythingllm")"
    echo "🛑 停止容器: docker stop $(docker ps -q -f "ancestor=mintplexlabs/anythingllm")"
else
    echo ""
    echo "❌ 容器启动失败，请检查:"
    echo "   1. Docker 是否正在运行"
    echo "   2. 端口 3001 是否被占用"
    echo "   3. 是否已拉取镜像: docker pull mintplexlabs/anythingllm"
fi
