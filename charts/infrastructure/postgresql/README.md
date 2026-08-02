# PostgreSQL Wrapper Chart

Wrapper Chart for [Bitnami PostgreSQL](https://github.com/bitnami/charts/tree/main/bitnami/postgresql)，提供 Java 开发场景的默认配置。

---

## 最简安装

仅填写必填参数即可快速安装：

```bash
helm install my-pg ltbah/postgresql \
  --set postgresql.auth.postgresPassword=Str0ngP0stgr3s! \
  --set postgresql.auth.password=Str0ngAppP@ss!
```

> **注意**: `postgresPassword` 和 `password` 为必填项，留空将导致安装失败。

---

## 最全配置安装

所有参数完整示例（含行内注释）：

```bash
helm install my-pg ltbah/postgresql \
  # ── Architecture ───────────────────────────────────────────
  --set postgresql.architecture=replication \
  # ── Auth ───────────────────────────────────────────────────
  --set postgresql.auth.postgresPassword=Str0ngP0stgr3s!     # [REQUIRED] postgres 超级用户密码
  --set postgresql.auth.database=appdb                        # 默认创建的数据库名
  --set postgresql.auth.username=appuser                      # 默认创建的普通用户名
  --set postgresql.auth.password=Str0ngAppP@ss!               # [REQUIRED] 普通用户密码
  --set postgresql.auth.replicationUsername=repl_user          # 复制用户名 (仅 replication)
  --set postgresql.auth.replicationPassword=Str0ngR3plP@ss!   # [REQUIRED when replication] 复制用户密码
  --set postgresql.auth.existingSecret=my-pg-secret           # 使用已有 Secret 替代内建密码
  # ── Primary ────────────────────────────────────────────────
  --set postgresql.primary.persistence.enabled=true            # 启用持久化
  --set postgresql.primary.persistence.size=50Gi               # PVC 大小
  --set postgresql.primary.persistence.storageClassName=ssd    # StorageClass 名称
  --set postgresql.primary.persistence.existingClaim=""        # 使用已有 PVC
  --set postgresql.primary.resources.requests.cpu=500m         # 请求 CPU
  --set postgresql.primary.resources.requests.memory=512Mi     # 请求内存
  --set postgresql.primary.resources.limits.cpu=2              # CPU 上限
  --set postgresql.primary.resources.limits.memory=2Gi         # 内存上限
  --set postgresql.primary.service.type=ClusterIP              # Service 类型
  --set postgresql.primary.service.ports.postgresql=5432       # Service 端口
  --set postgresql.primary.nodeSelector.disktype=ssd           # 节点选择器
  --set postgresql.primary.tolerations[0].key=db               # 容忍度
  --set postgresql.primary.tolerations[0].operator=Equal
  --set postgresql.primary.tolerations[0].value=true
  --set postgresql.primary.tolerations[0].effect=NoSchedule
  --set postgresql.primary.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchLabels.app=postgresql \
  --set postgresql.primary.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].topologyKey=kubernetes.io/hostname \
  --set postgresql.primary.extraEnvVars[0].name=TZ             # 额外环境变量
  --set postgresql.primary.extraEnvVars[0].value=Asia/Shanghai
  --set postgresql.primary.readinessProbe.enabled=true         # 就绪探针
  --set postgresql.primary.readinessProbe.initialDelaySeconds=5
  --set postgresql.primary.readinessProbe.periodSeconds=10
  --set postgresql.primary.livenessProbe.enabled=true          # 存活探针
  --set postgresql.primary.livenessProbe.initialDelaySeconds=30
  --set postgresql.primary.livenessProbe.periodSeconds=10
  --set postgresql.primary.startupProbe.enabled=true           # 启动探针 (慢启动场景)
  --set postgresql.primary.startupProbe.initialDelaySeconds=0
  --set postgresql.primary.startupProbe.periodSeconds=10
  --set postgresql.primary.startupProbe.failureThreshold=30
  --set postgresql.primary.priorityClassName=high-priority     # PriorityClass
  --set postgresql.primary.containerSecurityContext.enabled=true \
  --set postgresql.primary.containerSecurityContext.runAsUser=1001 \
  --set postgresql.primary.containerSecurityContext.runAsNonRoot=true \
  --set postgresql.primary.containerSecurityContext.readOnlyRootFilesystem=false \
  --set postgresql.primary.podSecurityContext.enabled=true \
  --set postgresql.primary.podSecurityContext.fsGroup=1001 \
  # ── Read Replicas ──────────────────────────────────────────
  --set postgresql.readReplicas.replicaCount=2                 # 副本数
  --set postgresql.readReplicas.persistence.enabled=true       # 副本持久化
  --set postgresql.readReplicas.persistence.size=50Gi
  --set postgresql.readReplicas.persistence.storageClassName=ssd
  --set postgresql.readReplicas.resources.requests.cpu=500m
  --set postgresql.readReplicas.resources.requests.memory=512Mi
  --set postgresql.readReplicas.resources.limits.cpu=2
  --set postgresql.readReplicas.resources.limits.memory=2Gi
  --set postgresql.readReplicas.service.type=ClusterIP
  --set postgresql.readReplicas.service.ports.postgresql=5432
  --set postgresql.readReplicas.nodeSelector.disktype=ssd
  --set postgresql.readReplicas.tolerations[0].key=db
  --set postgresql.readReplicas.tolerations[0].operator=Equal
  --set postgresql.readReplicas.tolerations[0].value=replica
  --set postgresql.readReplicas.tolerations[0].effect=NoSchedule
  --set postgresql.readReplicas.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchLabels.app=postgresql-replica \
  --set postgresql.readReplicas.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].topologyKey=kubernetes.io/hostname \
  --set postgresql.readReplicas.containerSecurityContext.enabled=true \
  --set postgresql.readReplicas.containerSecurityContext.runAsUser=1001 \
  --set postgresql.readReplicas.containerSecurityContext.runAsNonRoot=true \
  --set postgresql.readReplicas.podSecurityContext.enabled=true \
  --set postgresql.readReplicas.podSecurityContext.fsGroup=1001 \
  # ── Metrics ────────────────────────────────────────────────
  --set postgresql.metrics.enabled=true                        # 启用 Prometheus exporter
  --set postgresql.metrics.service.port=9187                   # Metrics 端口
  # ── TLS ────────────────────────────────────────────────────
  --set postgresql.tls.enabled=true                            # 启用 TLS
  --set postgresql.tls.certificatesSecret=pg-tls-secret        # TLS 证书 Secret
  # ── Network Policy ─────────────────────────────────────────
  --set postgresql.networkPolicy.enabled=true                  # 启用网络策略
  # ── Volume Permissions ─────────────────────────────────────
  --set postgresql.volumePermissions.enabled=true              # initContainer 修改卷权限
```

---

## 必填参数

| 参数 | 说明 |
|------|------|
| `postgresql.auth.postgresPassword` | postgres 超级用户密码，**不可为空** |
| `postgresql.auth.password` | 普通用户密码，**不可为空** |
| `postgresql.auth.replicationPassword` | 复制用户密码，**当 `architecture=replication` 时不可为空** |

---

## 完整参数参考

| 参数 | 说明 | 默认值 |
|------|------|--------|
| **Image** | | |
| `postgresql.image.repository` | 镜像仓库地址，空值使用上游默认 | `""` |
| `postgresql.image.tag` | 镜像标签，空值使用上游默认（跟随 appVersion） | `""` |
| `postgresql.image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |
| **Architecture** | | |
| `postgresql.architecture` | 部署架构：`standalone` 或 `replication` | `standalone` |
| **Auth** | | |
| `postgresql.auth.postgresPassword` | **[REQUIRED]** postgres 超级用户密码 | `""` |
| `postgresql.auth.database` | 默认创建的数据库名 | `appdb` |
| `postgresql.auth.username` | 默认创建的普通用户名 | `appuser` |
| `postgresql.auth.password` | **[REQUIRED]** 普通用户密码 | `""` |
| `postgresql.auth.replicationUsername` | 复制用户名（仅 replication） | `repl_user` |
| `postgresql.auth.replicationPassword` | **[REQUIRED when replication]** 复制用户密码 | `""` |
| `postgresql.auth.existingSecret` | 已有 Secret 名称（设置后密码参数被忽略） | `""` |
| **Primary - Persistence** | | |
| `postgresql.primary.persistence.enabled` | 启用持久化存储 | `true` |
| `postgresql.primary.persistence.size` | PVC 大小 | `8Gi` |
| `postgresql.primary.persistence.storageClassName` | StorageClass 名称（空字符串使用集群默认） | `""` |
| `postgresql.primary.persistence.existingClaim` | 使用已有 PVC 名称 | `""` |
| **Primary - Resources** | | |
| `postgresql.primary.resources.requests.cpu` | CPU 请求 | `250m` |
| `postgresql.primary.resources.requests.memory` | 内存请求 | `256Mi` |
| `postgresql.primary.resources.limits.cpu` | CPU 上限 | `1` |
| `postgresql.primary.resources.limits.memory` | 内存上限 | `1Gi` |
| **Primary - Service** | | |
| `postgresql.primary.service.type` | Service 类型 | `ClusterIP` |
| `postgresql.primary.service.ports.postgresql` | PostgreSQL 端口 | `5432` |
| **Primary - Scheduling** | | |
| `postgresql.primary.nodeSelector` | 节点选择器（键值对） | `{}` |
| `postgresql.primary.tolerations` | 容忍度列表 | `[]` |
| `postgresql.primary.affinity` | 亲和性规则 | `{}` |
| **Primary - Env & Init** | | |
| `postgresql.primary.extraEnvVars` | 额外环境变量列表（EnvVar 对象） | `[]` |
| `postgresql.primary.initdbScripts` | 初始化脚本（键=文件名，值=SQL/SH 内容） | `{}` |
| **Primary - Probes** | | |
| `postgresql.primary.readinessProbe.enabled` | 启用就绪探针 | `true` |
| `postgresql.primary.readinessProbe.initialDelaySeconds` | 就绪探针初始延迟 | `5` |
| `postgresql.primary.readinessProbe.periodSeconds` | 就绪探针检查间隔 | `10` |
| `postgresql.primary.readinessProbe.timeoutSeconds` | 就绪探针超时 | `5` |
| `postgresql.primary.readinessProbe.failureThreshold` | 就绪探针失败阈值 | `6` |
| `postgresql.primary.readinessProbe.successThreshold` | 就绪探针成功阈值 | `1` |
| `postgresql.primary.livenessProbe.enabled` | 启用存活探针 | `true` |
| `postgresql.primary.livenessProbe.initialDelaySeconds` | 存活探针初始延迟 | `30` |
| `postgresql.primary.livenessProbe.periodSeconds` | 存活探针检查间隔 | `10` |
| `postgresql.primary.livenessProbe.timeoutSeconds` | 存活探针超时 | `5` |
| `postgresql.primary.livenessProbe.failureThreshold` | 存活探针失败阈值 | `6` |
| `postgresql.primary.livenessProbe.successThreshold` | 存活探针成功阈值 | `1` |
| `postgresql.primary.startupProbe.enabled` | 启用启动探针 | `false` |
| `postgresql.primary.startupProbe.initialDelaySeconds` | 启动探针初始延迟 | `0` |
| `postgresql.primary.startupProbe.periodSeconds` | 启动探针检查间隔 | `10` |
| `postgresql.primary.startupProbe.timeoutSeconds` | 启动探针超时 | `5` |
| `postgresql.primary.startupProbe.failureThreshold` | 启动探针失败阈值 | `30` |
| `postgresql.primary.startupProbe.successThreshold` | 启动探针成功阈值 | `1` |
| **Primary - Pod Meta** | | |
| `postgresql.primary.podAnnotations` | Pod 自定义标注 | `{}` |
| `postgresql.primary.podLabels` | Pod 自定义标签 | `{}` |
| `postgresql.primary.priorityClassName` | PriorityClass 名称 | `""` |
| **Primary - Security** | | |
| `postgresql.primary.containerSecurityContext.enabled` | 启用容器安全上下文 | `false` |
| `postgresql.primary.containerSecurityContext.runAsUser` | 容器运行用户 UID | `1001` |
| `postgresql.primary.containerSecurityContext.runAsNonRoot` | 禁止 root 运行 | `true` |
| `postgresql.primary.containerSecurityContext.readOnlyRootFilesystem` | 只读根文件系统 | `false` |
| `postgresql.primary.podSecurityContext.enabled` | 启用 Pod 安全上下文 | `false` |
| `postgresql.primary.podSecurityContext.fsGroup` | 文件系统组 GID | `1001` |
| **Read Replicas** | | |
| `postgresql.readReplicas.replicaCount` | 只读副本数量 | `1` |
| `postgresql.readReplicas.persistence.enabled` | 启用副本持久化 | `true` |
| `postgresql.readReplicas.persistence.size` | 副本 PVC 大小 | `8Gi` |
| `postgresql.readReplicas.persistence.storageClassName` | 副本 StorageClass | `""` |
| `postgresql.readReplicas.persistence.existingClaim` | 副本已有 PVC | `""` |
| `postgresql.readReplicas.resources.requests.cpu` | 副本 CPU 请求 | `250m` |
| `postgresql.readReplicas.resources.requests.memory` | 副本内存请求 | `256Mi` |
| `postgresql.readReplicas.resources.limits.cpu` | 副本 CPU 上限 | `1` |
| `postgresql.readReplicas.resources.limits.memory` | 副本内存上限 | `1Gi` |
| `postgresql.readReplicas.service.type` | 副本 Service 类型 | `ClusterIP` |
| `postgresql.readReplicas.service.ports.postgresql` | 副本 PostgreSQL 端口 | `5432` |
| `postgresql.readReplicas.nodeSelector` | 副本节点选择器 | `{}` |
| `postgresql.readReplicas.tolerations` | 副本容忍度 | `[]` |
| `postgresql.readReplicas.affinity` | 副本亲和性 | `{}` |
| `postgresql.readReplicas.podAnnotations` | 副本 Pod 标注 | `{}` |
| `postgresql.readReplicas.podLabels` | 副本 Pod 标签 | `{}` |
| `postgresql.readReplicas.priorityClassName` | 副本 PriorityClass | `""` |
| `postgresql.readReplicas.containerSecurityContext.enabled` | 副本容器安全上下文 | `false` |
| `postgresql.readReplicas.containerSecurityContext.runAsUser` | 副本容器运行 UID | `1001` |
| `postgresql.readReplicas.containerSecurityContext.runAsNonRoot` | 副本禁止 root | `true` |
| `postgresql.readReplicas.containerSecurityContext.readOnlyRootFilesystem` | 副本只读根文件系统 | `false` |
| `postgresql.readReplicas.podSecurityContext.enabled` | 副本 Pod 安全上下文 | `false` |
| `postgresql.readReplicas.podSecurityContext.fsGroup` | 副本 fsGroup | `1001` |
| **Metrics** | | |
| `postgresql.metrics.enabled` | 启用 Prometheus exporter | `false` |
| `postgresql.metrics.service.port` | Metrics 服务端口 | `9187` |
| **TLS** | | |
| `postgresql.tls.enabled` | 启用 TLS 加密连接 | `false` |
| `postgresql.tls.certificatesSecret` | TLS 证书 Secret 名称 | `""` |
| **Ingress / Higress 网关** | | |
| `postgresql.ingress.enabled` | 是否启用 Ingress | `false` |
| `postgresql.ingress.className` | Ingress 类名，使用 Higress 时设为 "higress" | `"higress"` |
| `postgresql.ingress.domainSuffix` | 域名后缀，最终域名格式: {release-name}-{service}.{domainSuffix} | `""` |
| `postgresql.ingress.host` | 自定义域名（优先级高于 domainSuffix） | `""` |
| `postgresql.ingress.tls.enabled` | 是否启用 TLS | `false` |
| `postgresql.ingress.tls.secretName` | TLS 证书 Secret 名称 | `""` |
| `postgresql.ingress.annotations` | Ingress 注解 | `{}` |
| **Network Policy** | | |
| `postgresql.networkPolicy.enabled` | 启用 NetworkPolicy | `false` |
| **Volume Permissions** | | |
| `postgresql.volumePermissions.enabled` | 启用 initContainer 修改卷权限 | `false` |

---

## 测试环境推荐配置

```bash
helm install pg-test ltbah/postgresql \
  --set postgresql.auth.postgresPassword=testP0stgr3s \
  --set postgresql.auth.password=testAppP@ss \
  --set postgresql.auth.database=testdb \
  --set postgresql.architecture=standalone \
  --set postgresql.primary.persistence.enabled=false \
  --set postgresql.primary.resources.requests.cpu=100m \
  --set postgresql.primary.resources.requests.memory=128Mi \
  --set postgresql.primary.resources.limits.cpu=500m \
  --set postgresql.primary.resources.limits.memory=512Mi \
  --set postgresql.metrics.enabled=false
```

> 测试环境关闭持久化以节省资源，重启后数据丢失。如需数据持久化，设置 `persistence.enabled=true`。

---

## 生产环境推荐配置

```bash
helm install pg-prod ltbah/postgresql \
  --set postgresql.auth.postgresPassword=<FROM_VAULT> \
  --set postgresql.auth.password=<FROM_VAULT> \
  --set postgresql.auth.database=appdb \
  --set postgresql.auth.existingSecret=pg-prod-credentials \
  --set postgresql.architecture=replication \
  --set postgresql.auth.replicationPassword=<FROM_VAULT> \
  --set postgresql.primary.persistence.enabled=true \
  --set postgresql.primary.persistence.size=50Gi \
  --set postgresql.primary.persistence.storageClassName=ssd \
  --set postgresql.primary.resources.requests.cpu=500m \
  --set postgresql.primary.resources.requests.memory=512Mi \
  --set postgresql.primary.resources.limits.cpu=2 \
  --set postgresql.primary.resources.limits.memory=2Gi \
  --set postgresql.primary.startupProbe.enabled=true \
  --set postgresql.primary.startupProbe.failureThreshold=30 \
  --set postgresql.primary.containerSecurityContext.enabled=true \
  --set postgresql.primary.containerSecurityContext.runAsNonRoot=true \
  --set postgresql.primary.podSecurityContext.enabled=true \
  --set postgresql.primary.podSecurityContext.fsGroup=1001 \
  --set postgresql.readReplicas.replicaCount=2 \
  --set postgresql.readReplicas.persistence.enabled=true \
  --set postgresql.readReplicas.persistence.size=50Gi \
  --set postgresql.readReplicas.persistence.storageClassName=ssd \
  --set postgresql.readReplicas.resources.requests.cpu=500m \
  --set postgresql.readReplicas.resources.requests.memory=512Mi \
  --set postgresql.readReplicas.resources.limits.cpu=2 \
  --set postgresql.readReplicas.resources.limits.memory=2Gi \
  --set postgresql.readReplicas.containerSecurityContext.enabled=true \
  --set postgresql.readReplicas.containerSecurityContext.runAsNonRoot=true \
  --set postgresql.readReplicas.podSecurityContext.enabled=true \
  --set postgresql.readReplicas.podSecurityContext.fsGroup=1001 \
  --set postgresql.metrics.enabled=true \
  --set postgresql.tls.enabled=true \
  --set postgresql.tls.certificatesSecret=pg-prod-tls \
  --set postgresql.networkPolicy.enabled=true \
  --set postgresql.volumePermissions.enabled=false
```

生产环境要点：
- **密码管理**: 推荐使用 `existingSecret` 配合 Vault/Sealed Secrets 等方案，避免明文密码
- **高可用**: `architecture=replication` + 至少 2 个只读副本
- **持久化**: 必须启用，使用高性能 StorageClass（如 SSD）
- **资源配额**: 根据业务负载合理设置 requests/limits，避免 OOM
- **安全加固**: 启用 containerSecurityContext / podSecurityContext / networkPolicy / TLS
- **监控**: 启用 metrics 以接入 Prometheus
- **启动探针**: 启用 startupProbe 以适应大数据量场景的慢启动

### 通过 Higress 网关暴露服务

```bash
# 通过 Higress 网关暴露服务
helm install my-postgresql ltbah/postgresql \
  --set postgresql.auth.postgresPassword=yourpassword \
  --set postgresql.auth.password=yourpassword \
  --set postgresql.ingress.enabled=true \
  --set postgresql.ingress.className=higress \
  --set postgresql.ingress.domainSuffix=example.com
```

如需 TLS：
```bash
  --set postgresql.ingress.tls.enabled=true \
  --set postgresql.ingress.tls.secretName=postgresql-tls
```

---

更多底层参数详见 [Bitnami PostgreSQL Chart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql)
