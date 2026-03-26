请在 ~/whisper-api 目录下创建这个文件（你可以直接用 Nvim 粘贴）：

# 🚀 Whisper-on-GKE: 全自动化 AI 语音识别阵列

![GCP](https://img.shields.io/badge/Google%20Cloud-GKE-4285F4?style=flat-square&logo=google-cloud)
![Kubernetes](https://img.shields.io/badge/Kubernetes-v1.34-326CE5?style=flat-square&logo=kubernetes)
![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=flat-square&logo=docker)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?style=flat-square&logo=github-actions)

> **DevOps 90 天实战项目**：基于 GKE 构建的高可用、可弹性伸缩的 OpenAI Whisper 语音识别微服务。

## 这是一个自我实践的学习项目，旨在尝试DevOps全链路，不具备什么价值

## 🌟 项目亮点 (Highlights)

- **100% 自动化流水线 (CI/CD)**：基于 GitHub Actions 实现了从代码推送 (Git Push) 到大阪 Artifact Registry 镜像构建与推送的全自动化闭环。
- **声明式云端编排 (Orchestration)**：利用 Kubernetes (GKE) 管理计算资源，支持通过 YAML 动态调整阵列副本数 (Replicas)。
- **FinOps 成本优化**：采用 GCP Spot (抢占式) 实例，利用 K8s 的自愈能力在廉价算力上构建稳健的服务。
- **安全加固 (SecOps)**：集成 GitHub Push Protection，实现了基于 Service Account 的最小权限原则 (Least Privilege)。

---

## 🏛️ 架构全景 (Architecture)

```mermaid
graph LR
    A[Code: Python/FastAPI] --> B[Docker Build]
    B --> C[GitHub Actions CI]
    C --> D[GCP Artifact Registry]
    D --> E[GKE Cluster]
    E --> F[Load Balancer]
    F --> G[Public API Access]
---
🛠️ 快速开始 (Quick Start)
1. 本地测试 (Local)
podman build -t whisper-api .
podman run -p 8000:8000 whisper-api
2. 云端调用 (API Call)
curl -X POST "http://[YOUR_EXTERNAL_IP]/transcribe" \
     -H "Content-Type: multipart/form-data" \
     -F "file=@test.mp3"
---
## 📚 学习记录与复盘
本项目记录了我在 **DevOps 90 天计划** 中的进阶实战心得，详细的填坑记录（如 YAML 转义、CPU 调度不足、安全拦截等）请参考：
👉 [**详细学习记录 (LEARNING_REPORT.md)**](./LEARNING_REPORT.md)
---
🛡️ 开源协议
MIT License
```
