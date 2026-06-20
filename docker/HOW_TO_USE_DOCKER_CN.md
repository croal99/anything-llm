# 如何使用 Docker 化的 Anything LLM

使用 Docker 化版本的 AnythingLLM 可以更快、更完整地启动 AnythingLLM。

### 最低要求

> [!TIP]
> 在 AWS/GCP/Azure 上运行 AnythingLLM？
> 您应该至少分配 2GB 的 RAM。磁盘存储量取决于您将存储多少数据
> （文档、向量、模型等）。建议至少 10GB。

- 您的机器上安装了 `docker`
- 您的机器上安装了 `yarn` 和 `node`
- 可以访问在本地或远程运行的 LLM

*AnythingLLM 默认使用由 [LanceDB](https://github.com/lancedb/lancedb) 提供的内置向量数据库*

*AnythingLLM 默认在实例上私下进行文本嵌入 [了解更多](../server/storage/models/README.md)*

## 运行 Docker 化 AnythingLLM 的推荐方式！

> [!IMPORTANT]
> 如果您在 localhost 上运行其他服务，如 Chroma、LocalAi 或 LMStudio，
> 您需要使用 `http://host.docker.internal:xxxx` 来从 Docker 容器内
> 访问该服务，因为使用 AnythingLLM 时 `localhost:xxxx` 将无法解析到主机系统。
>
> **要求** Docker 在 Win/Mac 上需要 v18.03+，在 Linux/Ubuntu 上需要 20.10+ 才能让 host.docker.internal 解析！
>
> _Linux_：在 docker run 命令中添加 `--add-host=host.docker.internal:host-gateway` 以实现解析。
>
> 例如：主机上运行在 localhost:8000 的 Chroma 主机 URL 在 AnythingLLM 中使用时需要改为 `http://host.docker.internal:8000`。

> [!TIP]
> 最好将容器的存储卷挂载到主机机器上的文件夹，
> 这样您可以在不删除现有数据的情况下拉取未来的更新！

从 Docker 拉取最新镜像。支持 `amd64` 和 `arm64` CPU 架构。

```shell
docker pull mintplexlabs/anythingllm
```

<table>
<tr>
<th colspan="2">在本地挂载存储并运行 Docker 中的 AnythingLLM</th>
</tr>
<tr>
<td>
  Linux/MacOS
</td>
<td>


```shell
export STORAGE_LOCATION=$HOME/anythingllm && \
mkdir -p $STORAGE_LOCATION && \
touch "$STORAGE_LOCATION/.env" && \
docker run -d --rm -p 3001:3001 \
--cap-add SYS_ADMIN \
-v ${STORAGE_LOCATION}:/app/server/storage \
-v ${STORAGE_LOCATION}/.env:/app/server/.env \
-e STORAGE_DIR="/app/server/storage" \
mintplexlabs/anythingllm
```


</td>
</tr>
<tr>
<td>
  Windows
</td>
<td>


```powershell
# 在 PowerShell 终端中运行此命令
$env:STORAGE_LOCATION="$HOME\Documents\anythingllm"; `
If(!(Test-Path $env:STORAGE_LOCATION)) {New-Item $env:STORAGE_LOCATION -ItemType Directory}; `
If(!(Test-Path "$env:STORAGE_LOCATION\.env")) {New-Item "$env:STORAGE_LOCATION\.env" -ItemType File}; `
docker run -d --rm -p 3001:3001 `
--cap-add SYS_ADMIN `
-v "$env:STORAGE_LOCATION`:/app/server/storage" `
-v "$env:STORAGE_LOCATION\.env:/app/server/.env" `
-e STORAGE_DIR="/app/server/storage" `
mintplexlabs/anythingllm;
```


</td>
</tr>
<tr>
<td> Docker Compose</td>
<td>



```yaml
version: '3.8'
services:
  anythingllm:
    image: mintplexlabs/anythingllm
    container_name: anythingllm
    ports:
    - "3001:3001"
    cap_add:
      - SYS_ADMIN
    environment:
    # 根据您的环境调整
      - STORAGE_DIR=/app/server/storage
      - JWT_SECRET="make this a large list of random numbers and letters 20+"
      - LLM_PROVIDER=ollama
      - OLLAMA_BASE_PATH=http://127.0.0.1:11434
      - OLLAMA_MODEL_PREF=llama2
      - OLLAMA_MODEL_TOKEN_LIMIT=4096
      - EMBEDDING_ENGINE=ollama
      - EMBEDDING_BASE_PATH=http://127.0.0.1:11434
      - EMBEDDING_MODEL_PREF=nomic-embed-text:latest
      - EMBEDDING_MODEL_MAX_CHUNK_LENGTH=8192
      - VECTOR_DB=lancedb
      - WHISPER_PROVIDER=local
      - TTS_PROVIDER=native
      - PASSWORDMINCHAR=8
      # 在此添加您需要的其他服务或设置密钥
      # 您可以在 docker/.env.example 文件中找到它们
    volumes:
      - anythingllm_storage:/app/server/storage
    restart: always

volumes:
  anythingllm_storage:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /path/on/local/disk
```


  </td>
</tr>
</table>

访问 `http://localhost:3001`，您现在正在使用 AnythingLLM！您的所有数据和进度将在容器重建或从 Docker Hub 拉取后保持不变。

## 如何使用用户界面

- 要访问完整应用程序，请在浏览器中访问 `http://localhost:3001`。

## 关于 ENV 中的 UID 和 GID

- UID 和 GID 默认设置为 1000。这是 Docker 容器和大多数主机操作系统中的默认用户。如果您的主机用户 UID 和 GID 与 `.env` 文件中的设置不匹配，您可能会遇到权限问题。

## 从源代码本地构建 _不推荐 casual 使用_

- `git clone` 此仓库并 `cd anything-llm` 进入根目录。
- `touch server/storage/anythingllm.db` 创建空的 SQLite 数据库文件。
- `cd docker/`
- `cp .env.example .env` **您必须在构建之前执行此操作**
- `docker-compose up -d --build` 构建镜像 - 这将花费一些时间。

构建过程完成后，您的 Docker 主机将显示镜像已上线。这会将应用程序构建到 `http://localhost:3001`。

## 集成和一键设置

以下集成是由社区构建的模板或工具，旨在使运行 AnythingLLM 的 Docker 体验更加轻松。

### 使用 Midori AI 子系统管理 AnythingLLM

请按照 [Midori AI 子系统网站](https://io.midori-ai.xyz/subsystem/manager/) 上找到的设置说明操作您的主机操作系统。设置完成后，将 AnythingLLM Docker 后端安装到 Midori AI 子系统。

完成后，您就全部设置好了！

## 常见问题和修复

### 无法连接到在 localhost 上运行的服务！

如果您在 Docker 中并且无法连接到在主机机器上运行在本地接口或回环上的服务：

- `localhost`
- `127.0.0.1`
- `0.0.0.0`

> [!IMPORTANT]
> 在 Linux 上 `http://host.docker.internal:xxxx` 不起作用。
> 请改用 `http://172.17.0.1:xxxx` 来模拟此功能。

然后在 Docker 中，您需要将 localhost 部分替换为 `host.docker.internal`。例如，如果在主机机器上运行 Ollama，绑定到 `http://127.0.0.1:11434`，您应该在 AnythingLLM 的连接 URL 中放入 `http://host.docker.internal:11434`。

### API 不工作，无法登录，LLM 显示"离线"？

您可能是在远程机器（如 EC2 或其他实例）上运行 Docker 容器，其中可访问的 URL 不是 `http://localhost:3001`，而是类似 `http://193.xx.xx.xx:3001` 的内容 - 在这种情况下，您只需在运行 `docker-compose up -d --build` 之前将以下内容添加到您的 `frontend/.env.production` 中：

```
# frontend/.env.production
GENERATE_SOURCEMAP=false
VITE_API_BASE="http://<YOUR_REACHABLE_IP_ADDRESS>:3001/api"
```

例如，如果 Docker 实例可通过 `192.186.1.222` 访问，那么您的 `VITE_API_BASE` 在 `frontend/.env.production` 中应类似于 `VITE_API_BASE="http://192.186.1.222:3001/api"`。

### Ollama 出现问题？

如果您收到类似 `llama:streaming - could not stream chat. Error: connect ECONNREFUSED 172.17.0.1:11434` 的错误，请查看下面的 README。

[修复 Ollama 的常见问题](../server/utils/AIProviders/ollama/README.md)

### 仍然无法工作？

[在 Discord 上寻求帮助](https://discord.gg/6UyHPeGZAC)
