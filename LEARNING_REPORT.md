# DevOps 实战报告：Whisper-on-GKE 全链路部署

## 1. 项目概览 (Project Overview)
* **目标**：在 GCP (Google Cloud) 上部署一个生产级的 OpenAI Whisper 语音识别微服务。
* **核心挑战**：通过 **GKE (Kubernetes)** 实现高可用阵列，并通过 **GitHub Actions** 实现 100% 自动化交付。
* **最终成果**：实现了一个具备公网 IP、可弹性伸缩的 AI 推理 API 阵列。

## 2. 技术栈 (The Tech Stack)
* **OS/CLI**: Arch Linux / Fish Shell / Nvim
* **Container**: Podman / Docker
* **CI/CD**: GitHub Actions
* **Cloud Infrastructure**: GCP (GKE, Artifact Registry, IAM)
* **Orchestration**: Kubernetes (Deployment, Service, LoadBalancer)
* **AI Engine**: OpenAI Whisper (Python/FastAPI)

## 3. 实战链路与“为什么要这么做” (The Workflow & Rationale)

| 阶段 | 关键操作 (Action) | 为什么这么做 (Rationale) |
| :--- | :--- | :--- |
| **基础建设** | `gcloud projects create` / `billing link` | **资源隔离**。DevOps 讲究环境独立，防止实验影响生产。 |
| **军械库** | `gcloud artifacts repositories create` | **私有镜像托管**。解决“代码在本地能跑，服务器不能跑”的依赖问题。 |
| **容器化** | 编写 `Dockerfile` + `app.py` | **不可变基础设施**。将系统环境、FFmpeg 和模型打包成一个整体，实现“一处构建，到处运行”。 |
| **自动化** | 配置 `github-action-bot` (IAM) | **最小权限原则**。用服务账号代替个人账号，保障云端资产安全。 |
| **安全加固** | 触发 `Push Protection` / `.gitignore` | **DevSecOps 核心**。通过 GitHub 拦截密钥泄漏，理解“安全左移”的实战意义。 |
| **指挥部** | `gcloud container clusters create --spot` | **成本优化 (FinOps)**。利用抢占式实例，用几毛钱的成本换取上万元的 K8s 集群体验。 |
| **编排** | `kubectl apply -f deployment.yaml` | **声明式运维**。告诉 K8s 最终想要的状态，让大脑自动处理伸缩与自愈。 |
| **弹性扩展** | `gcloud container clusters resize` | **横向伸缩 (Scaling)**。通过增加计算节点解决 `Insufficient cpu` 资源调度瓶颈。 |

## 4. 痛苦品鉴与填坑日记 (Troubleshooting)
* **坑 1：安全卫士拦截 (Secret Leaking)**
    * *现象*：`gcp-key.json` 被 GitHub Push Protection 拦截。
    * *解决*：建立 `.gitignore` 规则，并将密钥存入 GitHub Secrets 加密。
* **坑 2：YAML 转义地狱 (JSON Parsing Error)**
    * *现象*：GitHub Actions 认证失败，提示 unexpected token。
    * *原因*：在 Shell 环境中写入 YAML 时引入了错误的转义符 `\`。
    * *解决*：通过 Nvim 手动编写纯净版 YAML 模板。
* **坑 3：资源调度不足 (Insufficient CPU)**
    * *现象*：Pod 处于 `Pending` 状态，提示 CPU 不足。
    * *原因*：GKE 节点的系统预留资源消耗了大量 CPU。
    * *解决*：执行集群 `resize` 增加节点数，并下调 `resources.requests.cpu` 配额。

## 5. 核心感悟 (Key Takeaway)
* **“代码即指令”**：几 KB 的 YAML 配置文件可以调动全球数个数据中心几 GB 的流量和算力。
* **“隔离胜于修补”**：通过 Docker 和 K8s 实现的彻底环境隔离，是解决“在我机器上是好的”魔咒的终极武器。
* **“自动化不是偷懒”**：GitHub Actions 虽然配置麻烦，但它节省了数小时的本地构建与上传时间，提高了整个交付链路的信噪比。

## 6. 下一步进化 (Future Work)
* 引入 **Terraform (IaC)** 实现集群一键拉起。
* 挂载 **NVIDIA GPU** 加速推理性能。
* 配置 **Prometheus & Grafana** 监控 CPU/GPU 负载及 API 延迟。

---
*Created by Antigravity DevOps Mentor for Kleesuran - 2026-03-26*
