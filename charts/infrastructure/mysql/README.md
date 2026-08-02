# MySQL Wrapper Chart

Wrapper Chart for [Bitnami MySQL](https://github.com/bitnami/charts/tree/main/bitnami/mysql)。

## 快速开始

```bash
# 最小化部署（测试用）
helm install my-mysql ltbah/mysql \
  --set mysql.auth.rootPassword=rootpass123 \
  --set mysql.auth.password=appuserpass123

# 生产部署
helm install my-mysql ltbah/mysql \
  --set mysql.architecture=replication \
  --set mysql.auth.rootPassword=STRONG_ROOT_PASSWORD \
  --set mysql.auth.password=STRONG_APP_PASSWORD \
  --set mysql.auth.replicationPassword=STRONG_REPL_PASSWORD \
  --set mysql.primary.persistence.size=50Gi \
  --set mysql.primary.resources.requests.cpu=500m \
  --set mysql.primary.resources.requests.memory=1Gi \
  --set mysql.primary.resources.limits.cpu=2 \
  --set mysql.primary.resources.limits.memory=4Gi \
  --set mysql.secondary.replicaCount=2 \
  --set mysql.metrics.enabled=true
```

## 必填参数

以下参数**必须在部署时指定**，没有默认值：

| 参数 | 说明 |
|------|------|
| `mysql.auth.rootPassword` | root 用户密码 |
| `mysql.auth.password` | 应用用户密码（当 `mysql.auth.username` 已设置时） |

## 参数列表

### 镜像配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `mysql.image.repository` | 镜像仓库地址，空值使用上游默认 | `""` |
| `mysql.image.tag` | 镜像标签，空值使用上游默认（跟随 appVersion） | `""` |
| `mysql.image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |

### 全局配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `mysql.architecture` | 架构模式：standalone 或 replication | `standalone` |

### 认证配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `mysql.auth.rootPassword` | root 用户密码（**必填**） | `""` |
| `mysql.auth.database` | 默认创建的数据库 | `appdb` |
| `mysql.auth.username` | 应用用户名 | `appuser` |
| `mysql.auth.password` | 应用用户密码（**必填**） | `""` |
| `mysql.auth.replicationUser` | 复制用户名（replication 模式） | `replicator` |
| `mysql.auth.replicationPassword` | 复制用户密码（replication 模式下必填） | `""` |
| `mysql.auth.existingSecret` | 使用现有 Secret（设置后忽略其他 auth 参数） | `""` |

### Primary 节点配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `mysql.primary.persistence.enabled` | 是否启用持久化 | `true` |
| `mysql.primary.persistence.size` | 持久化存储大小 | `8Gi` |
| `mysql.primary.persistence.storageClassName` | 存储类名 | `""` |
| `mysql.primary.persistence.existingClaim` | 使用现有 PVC | `""` |
| `mysql.primary.resources.requests.cpu` | CPU 请求 | `250m` |
| `mysql.primary.resources.requests.memory` | 内存请求 | `256Mi` |
| `mysql.primary.resources.limits.cpu` | CPU 限制 | `""` |
| `mysql.primary.resources.limits.memory` | 内存限制 | `""` |
| `mysql.primary.service.type` | 服务类型 | `ClusterIP` |
| `mysql.primary.service.ports.mysql` | MySQL 端口 | `3306` |
| `mysql.primary.nodeSelector` | 节点选择器 | `{}` |
| `mysql.primary.tolerations` | 容忍度 | `[]` |
| `mysql.primary.affinity` | 亲和性 | `{}` |
| `mysql.primary.extraEnvVars` | 额外环境变量 | `[]` |
| `mysql.primary.configuration` | 自定义 my.cnf 配置 | `""` |
| `mysql.primary.initdbScripts` | 初始化 SQL 脚本 | `{}` |
| `mysql.primary.readinessProbe.enabled` | 就绪探针开关 | `true` |
| `mysql.primary.livenessProbe.enabled` | 存活探针开关 | `true` |
| `mysql.primary.startupProbe.enabled` | 启动探针开关 | `false` |

### Secondary 节点配置（replication 模式）

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `mysql.secondary.replicaCount` | 副本数 | `1` |
| `mysql.secondary.persistence.enabled` | 是否启用持久化 | `true` |
| `mysql.secondary.persistence.size` | 持久化存储大小 | `8Gi` |
| `mysql.secondary.resources.requests.cpu` | CPU 请求 | `250m` |
| `mysql.secondary.resources.requests.memory` | 内存请求 | `256Mi` |

### 监控配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `mysql.metrics.enabled` | 是否启用 Metrics | `false` |
| `mysql.metrics.service.port` | Metrics 服务端口 | `9104` |

### TLS 配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `mysql.tls.enabled` | 是否启用 TLS | `false` |
| `mysql.tls.certificatesSecret` | TLS 证书 Secret | `""` |

### Ingress / Higress 网关

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `mysql.ingress.enabled` | 是否启用 Ingress | `false` |
| `mysql.ingress.className` | Ingress 类名，使用 Higress 时设为 "higress" | `"higress"` |
| `mysql.ingress.domainSuffix` | 域名后缀，最终域名格式: {release-name}-{service}.{domainSuffix} | `""` |
| `mysql.ingress.host` | 自定义域名（优先级高于 domainSuffix） | `""` |
| `mysql.ingress.tls.enabled` | 是否启用 TLS | `false` |
| `mysql.ingress.tls.secretName` | TLS 证书 Secret 名称 | `""` |
| `mysql.ingress.annotations` | Ingress 注解 | `{}` |

## 推荐配置

### 测试环境

资源最小化，适合本地开发/测试：

```bash
helm install my-mysql ltbah/mysql \
  --set mysql.auth.rootPassword=testpass123 \
  --set mysql.auth.password=testpass123 \
  --set mysql.primary.persistence.size=1Gi \
  --set mysql.primary.resources.requests.cpu=100m \
  --set mysql.primary.resources.requests.memory=128Mi
```

### 生产环境

高可用 + 数据安全 + 监控：

```bash
helm install my-mysql ltbah/mysql \
  --set mysql.architecture=replication \
  --set mysql.auth.rootPassword=<STRONG_PASSWORD> \
  --set mysql.auth.password=<STRONG_PASSWORD> \
  --set mysql.auth.replicationPassword=<STRONG_PASSWORD> \
  --set mysql.primary.persistence.size=50Gi \
  --set mysql.primary.persistence.storageClassName=ssd \
  --set mysql.primary.resources.requests.cpu=500m \
  --set mysql.primary.resources.requests.memory=1Gi \
  --set mysql.primary.resources.limits.cpu=2 \
  --set mysql.primary.resources.limits.memory=4Gi \
  --set mysql.secondary.replicaCount=2 \
  --set mysql.secondary.persistence.size=50Gi \
  --set mysql.secondary.resources.requests.cpu=500m \
  --set mysql.secondary.resources.requests.memory=1Gi \
  --set mysql.secondary.resources.limits.cpu=2 \
  --set mysql.secondary.resources.limits.memory=4Gi \
  --set mysql.metrics.enabled=true \
  --set mysql.tls.enabled=true \
  --set mysql.tls.certificatesSecret=mysql-tls-certs
```

### 通过 Higress 网关暴露服务

```bash
# 通过 Higress 网关暴露服务
helm install my-mysql ltbah/mysql \
  --set mysql.auth.rootPassword=yourpassword \
  --set mysql.auth.password=yourpassword \
  --set mysql.ingress.enabled=true \
  --set mysql.ingress.className=higress \
  --set mysql.ingress.domainSuffix=example.com
```

如需 TLS：
```bash
  --set mysql.ingress.tls.enabled=true \
  --set mysql.ingress.tls.secretName=mysql-tls
```

## 更多配置

详见 [Bitnami MySQL Chart](https://github.com/bitnami/charts/tree/main/bitnami/mysql)
