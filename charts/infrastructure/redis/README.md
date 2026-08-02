# Redis Wrapper Chart

Wrapper Chart for [Bitnami Redis](https://github.com/bitnami/charts/tree/main/bitnami/redis)，提供 Java 开发场景的默认配置。

## 最简安装

> 启用认证时必须设置密码（`redis.auth.password` 为空即必填）。

```bash
helm install my-redis ltbah/redis \
  --set redis.auth.password=yourpassword
```

## 最全配置安装

```bash
helm install my-redis ltbah/redis \
  --set redis.architecture=replication \
  --set redis.auth.enabled=true \
  --set redis.auth.password=yourpassword \
  --set redis.auth.existingSecret="" \
  --set redis.master.persistence.enabled=true \
  --set redis.master.persistence.size=8Gi \
  --set redis.master.persistence.storageClassName=ssd \
  --set redis.master.resources.requests.cpu=250m \
  --set redis.master.resources.requests.memory=256Mi \
  --set redis.master.resources.limits.cpu=1 \
  --set redis.master.resources.limits.memory=1Gi \
  --set redis.master.service.type=ClusterIP \
  --set redis.master.service.ports.redis=6379 \
  --set redis.master.nodeSelector.role=cache \
  --set 'redis.master.tolerations[0].key=dedicated' \
  --set 'redis.master.tolerations[0].operator=Equal' \
  --set 'redis.master.tolerations[0].value=cache' \
  --set 'redis.master.tolerations[0].effect=NoSchedule' \
  --set redis.master.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchLabels.app=redis \
  --set 'redis.master.extraEnvVars[0].name=TZ' \
  --set 'redis.master.extraEnvVars[0].value=Asia/Shanghai' \
  --set redis.master.readinessProbe.enabled=true \
  --set redis.master.readinessProbe.initialDelaySeconds=5 \
  --set redis.master.livenessProbe.enabled=true \
  --set redis.master.livenessProbe.initialDelaySeconds=30 \
  --set redis.replica.replicaCount=3 \
  --set redis.replica.persistence.enabled=true \
  --set redis.replica.persistence.size=8Gi \
  --set redis.replica.persistence.storageClassName=ssd \
  --set redis.replica.resources.requests.cpu=250m \
  --set redis.replica.resources.requests.memory=256Mi \
  --set redis.replica.resources.limits.cpu=1 \
  --set redis.replica.resources.limits.memory=1Gi \
  --set redis.replica.service.type=ClusterIP \
  --set redis.replica.service.ports.redis=6379 \
  --set redis.replica.nodeSelector.role=cache \
  --set redis.replica.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchLabels.app=redis \
  --set redis.sentinel.enabled=true \
  --set redis.sentinel.quorum=2 \
  --set redis.sentinel.persistence.enabled=true \
  --set redis.sentinel.persistence.size=4Gi \
  --set redis.sentinel.resources.requests.cpu=50m \
  --set redis.sentinel.resources.requests.memory=64Mi \
  --set redis.sentinel.resources.limits.cpu=200m \
  --set redis.sentinel.resources.limits.memory=256Mi \
  --set redis.metrics.enabled=true \
  --set redis.metrics.service.port=9121 \
  --set redis.tls.enabled=true \
  --set redis.tls.certificatesSecret=redis-tls-certs \
  --set redis.networkPolicy.enabled=true \
  --set redis.volumePermissions.enabled=true \
  --set redis.sysctl.enabled=true
```

## 必填参数

| 参数 | 说明 |
|------|------|
| `redis.auth.password` | **启用认证时必填**（`redis.auth.enabled=true` 时密码不能为空）。也可通过 `redis.auth.existingSecret` 引用已有 Secret 代替 |

## 参数列表

### 镜像配置

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.image.repository` | `""` | 镜像仓库地址，空值使用上游默认 |
| `redis.image.tag` | `""` | 镜像标签，空值使用上游默认（跟随 appVersion） |
| `redis.image.pullPolicy` | `IfNotPresent` | 镜像拉取策略 |

### 全局

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.architecture` | `standalone` | 架构模式：`standalone`（单节点）或 `replication`（主从复制） |

### 认证

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.auth.enabled` | `true` | 是否启用认证 |
| `redis.auth.password` | `""` | **启用认证时必填**，Redis 密码 |
| `redis.auth.existingSecret` | `""` | 使用已有 Secret 替代密码，Secret 需包含 `redis-password` key |

### Master 节点

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.master.persistence.enabled` | `true` | 是否启用持久化 |
| `redis.master.persistence.size` | `4Gi` | 持久化存储大小 |
| `redis.master.persistence.storageClassName` | `""` | 存储类名 |
| `redis.master.resources.requests.cpu` | `100m` | CPU 请求 |
| `redis.master.resources.requests.memory` | `128Mi` | 内存请求 |
| `redis.master.resources.limits.cpu` | `500m` | CPU 限制 |
| `redis.master.resources.limits.memory` | `512Mi` | 内存限制 |
| `redis.master.service.type` | `ClusterIP` | Service 类型 |
| `redis.master.service.ports.redis` | `6379` | Redis 端口 |
| `redis.master.nodeSelector` | `{}` | 节点选择器 |
| `redis.master.tolerations` | `[]` | 容忍度 |
| `redis.master.affinity` | `{}` | 亲和性 |
| `redis.master.extraEnvVars` | `[]` | 额外环境变量列表 |
| `redis.master.podAnnotations` | `{}` | Pod 标注 |
| `redis.master.podLabels` | `{}` | Pod 标签 |
| `redis.master.readinessProbe.enabled` | `true` | 是否启用 Readiness 探针 |
| `redis.master.readinessProbe.initialDelaySeconds` | `5` | Readiness 初始延迟 |
| `redis.master.readinessProbe.periodSeconds` | `10` | Readiness 检测周期 |
| `redis.master.readinessProbe.timeoutSeconds` | `5` | Readiness 超时 |
| `redis.master.readinessProbe.failureThreshold` | `6` | Readiness 失败阈值 |
| `redis.master.readinessProbe.successThreshold` | `1` | Readiness 成功阈值 |
| `redis.master.livenessProbe.enabled` | `true` | 是否启用 Liveness 探针 |
| `redis.master.livenessProbe.initialDelaySeconds` | `30` | Liveness 初始延迟 |
| `redis.master.livenessProbe.periodSeconds` | `10` | Liveness 检测周期 |
| `redis.master.livenessProbe.timeoutSeconds` | `5` | Liveness 超时 |
| `redis.master.livenessProbe.failureThreshold` | `6` | Liveness 失败阈值 |
| `redis.master.livenessProbe.successThreshold` | `1` | Liveness 成功阈值 |

### Replica 副本（仅 `architecture=replication` 时生效）

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.replica.replicaCount` | `2` | 副本数量 |
| `redis.replica.persistence.enabled` | `true` | 是否启用持久化 |
| `redis.replica.persistence.size` | `4Gi` | 持久化存储大小 |
| `redis.replica.persistence.storageClassName` | `""` | 存储类名 |
| `redis.replica.resources.requests.cpu` | `100m` | CPU 请求 |
| `redis.replica.resources.requests.memory` | `128Mi` | 内存请求 |
| `redis.replica.resources.limits.cpu` | `500m` | CPU 限制 |
| `redis.replica.resources.limits.memory` | `512Mi` | 内存限制 |
| `redis.replica.service.type` | `ClusterIP` | Service 类型 |
| `redis.replica.service.ports.redis` | `6379` | Redis 端口 |
| `redis.replica.nodeSelector` | `{}` | 节点选择器 |
| `redis.replica.tolerations` | `[]` | 容忍度 |
| `redis.replica.affinity` | `{}` | 亲和性 |

### Sentinel 哨兵

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.sentinel.enabled` | `false` | 是否启用 Sentinel |
| `redis.sentinel.quorum` | `2` | Sentinel 法定人数 |
| `redis.sentinel.persistence.enabled` | `true` | 是否启用持久化 |
| `redis.sentinel.persistence.size` | `4Gi` | 持久化存储大小 |
| `redis.sentinel.persistence.storageClassName` | `""` | 存储类名 |
| `redis.sentinel.resources.requests.cpu` | `50m` | CPU 请求 |
| `redis.sentinel.resources.requests.memory` | `64Mi` | 内存请求 |
| `redis.sentinel.resources.limits.cpu` | `200m` | CPU 限制 |
| `redis.sentinel.resources.limits.memory` | `256Mi` | 内存限制 |

### Metrics 监控

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.metrics.enabled` | `false` | 是否启用 Prometheus Exporter |
| `redis.metrics.service.port` | `9121` | Metrics 端口 |

### TLS

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.tls.enabled` | `false` | 是否启用 TLS |
| `redis.tls.certificatesSecret` | `""` | TLS 证书 Secret 名称 |

### Ingress / Higress 网关

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.ingress.enabled` | `false` | 是否启用 Ingress |
| `redis.ingress.className` | `"higress"` | Ingress 类名，使用 Higress 时设为 "higress" |
| `redis.ingress.domainSuffix` | `""` | 域名后缀，最终域名格式: {release-name}-{service}.{domainSuffix} |
| `redis.ingress.host` | `""` | 自定义域名（优先级高于 domainSuffix） |
| `redis.ingress.tls.enabled` | `false` | 是否启用 TLS |
| `redis.ingress.tls.secretName` | `""` | TLS 证书 Secret 名称 |
| `redis.ingress.annotations` | `{}` | Ingress 注解 |

### Network Policy

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.networkPolicy.enabled` | `false` | 是否启用 Network Policy |

### Volume Permissions

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.volumePermissions.enabled` | `false` | 是否启用 initContainer 修改卷权限 |

### Sysctl

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `redis.sysctl.enabled` | `false` | 是否启用 initContainer 调整内核参数 |

## 测试环境推荐配置

```bash
helm install my-redis ltbah/redis \
  --set redis.auth.password=testpass123 \
  --set redis.architecture=standalone \
  --set redis.master.persistence.size=2Gi \
  --set redis.master.resources.requests.cpu=50m \
  --set redis.master.resources.requests.memory=64Mi \
  --set redis.master.resources.limits.cpu=250m \
  --set redis.master.resources.limits.memory=256Mi \
  --set redis.metrics.enabled=false
```

## 生产环境推荐配置

```bash
helm install my-redis ltbah/redis \
  --set redis.auth.enabled=true \
  --set redis.auth.password=STRONG_PROD_PASSWORD \
  --set redis.architecture=replication \
  --set redis.master.persistence.size=16Gi \
  --set redis.master.persistence.storageClassName=ssd \
  --set redis.master.resources.requests.cpu=250m \
  --set redis.master.resources.requests.memory=512Mi \
  --set redis.master.resources.limits.cpu=1 \
  --set redis.master.resources.limits.memory=2Gi \
  --set redis.master.livenessProbe.initialDelaySeconds=60 \
  --set redis.replica.replicaCount=3 \
  --set redis.replica.persistence.size=16Gi \
  --set redis.replica.persistence.storageClassName=ssd \
  --set redis.replica.resources.requests.cpu=250m \
  --set redis.replica.resources.requests.memory=512Mi \
  --set redis.replica.resources.limits.cpu=1 \
  --set redis.replica.resources.limits.memory=2Gi \
  --set redis.sentinel.enabled=true \
  --set redis.sentinel.quorum=2 \
  --set redis.metrics.enabled=true \
  --set redis.networkPolicy.enabled=true \
  --set redis.volumePermissions.enabled=true \
  --set redis.sysctl.enabled=true
```

### 通过 Higress 网关暴露服务

```bash
# 通过 Higress 网关暴露服务
helm install my-redis ltbah/redis \
  --set redis.auth.password=yourpassword \
  --set redis.ingress.enabled=true \
  --set redis.ingress.className=higress \
  --set redis.ingress.domainSuffix=example.com
```

如需 TLS：
```bash
  --set redis.ingress.tls.enabled=true \
  --set redis.ingress.tls.secretName=redis-tls
```

## 更多配置

详见 [Bitnami Redis Chart](https://github.com/bitnami/charts/tree/main/bitnami/redis)
