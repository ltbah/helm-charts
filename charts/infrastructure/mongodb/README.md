# MongoDB Wrapper Chart

Wrapper Chart for [Bitnami MongoDB](https://github.com/bitnami/charts/tree/main/bitnami/mongodb)，提供 Java 开发场景的默认配置。

## 最简安装

> 必填密码未设置时安装会失败，务必通过 `--set` 传入。

```bash
helm install my-mongo ltbah/mongodb \
  --set mongodb.auth.rootPassword=RootPass123 \
  --set mongodb.auth.password=UserPass123
```

## 最全配置安装

```bash
helm install my-mongo ltbah/mongodb \
  --set mongodb.architecture=replicaset \
  --set mongodb.auth.rootPassword=RootPass123 \
  --set mongodb.auth.database=appdb \
  --set mongodb.auth.username=appuser \
  --set mongodb.auth.password=UserPass123 \
  --set mongodb.auth.replicaSetKey=ReplKey123 \
  --set mongodb.replicaSetName=rs0 \
  --set mongodb.replicaSetHostnames=true \
  --set mongodb.persistence.enabled=true \
  --set mongodb.persistence.size=20Gi \
  --set mongodb.persistence.storageClassName=ssd \
  --set mongodb.resources.requests.cpu=500m \
  --set mongodb.resources.requests.memory=512Mi \
  --set mongodb.resources.limits.cpu=2 \
  --set mongodb.resources.limits.memory=2Gi \
  --set mongodb.service.type=ClusterIP \
  --set mongodb.service.ports.mongodb=27017 \
  --set mongodb.metrics.enabled=true \
  --set mongodb.metrics.service.port=9216 \
  --set mongodb.tls.enabled=true \
  --set mongodb.tls.certificatesSecret=mongo-tls-secret \
  --set mongodb.arbiter.enabled=true \
  --set mongodb.hidden.enabled=true \
  --set mongodb.hidden.persistence.size=20Gi \
  --set mongodb.hidden.resources.limits.cpu=2 \
  --set mongodb.hidden.resources.limits.memory=2Gi \
  --set mongodb.volumePermissions.enabled=true
```

也可通过 values 文件安装：

```bash
helm install my-mongo ltbah/mongodb -f my-values.yaml
```

## 必填参数

| 参数 | 说明 |
|------|------|
| `mongodb.auth.rootPassword` | root 用户密码，**必填**，无默认值 |
| `mongodb.auth.password` | 普通用户密码，**必填**，无默认值 |

> 使用 `mongodb.auth.existingSecret` 时，上述密码可留空，改为从已有 Secret 读取。

**副本集模式下额外必填：**

| 参数 | 说明 |
|------|------|
| `mongodb.auth.replicaSetKey` | 副本集认证密钥，**必填**（当 `architecture=replicaset` 且未使用 `existingSecret` 时） |

## 参数列表

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `mongodb.image.repository` | `""` | 镜像仓库地址，空值使用上游默认 |
| `mongodb.image.tag` | `""` | 镜像标签，空值使用上游默认（跟随 appVersion） |
| `mongodb.image.pullPolicy` | `IfNotPresent` | 镜像拉取策略 |
| `mongodb.architecture` | `standalone` | 架构模式：`standalone` 或 `replicaset` |
| `mongodb.auth.rootPassword` | `""` | **[必填]** root 用户密码 |
| `mongodb.auth.database` | `appdb` | 默认创建的数据库名 |
| `mongodb.auth.username` | `appuser` | 默认创建的普通用户名 |
| `mongodb.auth.password` | `""` | **[必填]** 普通用户密码 |
| `mongodb.auth.replicaSetKey` | `""` | 副本集认证密钥（replicaset 模式必填） |
| `mongodb.auth.existingSecret` | `""` | 已有 Secret 名称，设置后忽略内建密码 |
| `mongodb.replicaSetName` | `rs0` | 副本集名称 |
| `mongodb.replicaSetHostnames` | `true` | 使用 Pod 主机名作为副本集成员标识 |
| `mongodb.persistence.enabled` | `true` | 是否启用持久化 |
| `mongodb.persistence.size` | `8Gi` | 持久卷大小 |
| `mongodb.persistence.storageClassName` | `""` | 存储类名，空值使用集群默认 |
| `mongodb.persistence.existingClaim` | `""` | 已有 PVC 名称 |
| `mongodb.resources.requests.cpu` | `250m` | CPU 请求 |
| `mongodb.resources.requests.memory` | `256Mi` | 内存请求 |
| `mongodb.resources.limits.cpu` | `"1"` | CPU 上限 |
| `mongodb.resources.limits.memory` | `1Gi` | 内存上限 |
| `mongodb.service.type` | `ClusterIP` | Service 类型 |
| `mongodb.service.ports.mongodb` | `27017` | MongoDB 端口 |
| `mongodb.nodeSelector` | `{}` | 节点选择器 |
| `mongodb.tolerations` | `[]` | 容忍度 |
| `mongodb.affinity` | `{}` | 亲和性 |
| `mongodb.podAnnotations` | `{}` | Pod 注解 |
| `mongodb.podLabels` | `{}` | Pod 额外标签 |
| `mongodb.extraEnvVars` | `[]` | 额外环境变量列表 |
| `mongodb.readinessProbe.enabled` | `true` | 是否启用 Readiness 探针 |
| `mongodb.readinessProbe.initialDelaySeconds` | `5` | Readiness 初始延迟 |
| `mongodb.readinessProbe.periodSeconds` | `10` | Readiness 检测周期 |
| `mongodb.readinessProbe.timeoutSeconds` | `5` | Readiness 超时 |
| `mongodb.readinessProbe.failureThreshold` | `6` | Readiness 失败阈值 |
| `mongodb.readinessProbe.successThreshold` | `1` | Readiness 成功阈值 |
| `mongodb.livenessProbe.enabled` | `true` | 是否启用 Liveness 探针 |
| `mongodb.livenessProbe.initialDelaySeconds` | `30` | Liveness 初始延迟 |
| `mongodb.livenessProbe.periodSeconds` | `10` | Liveness 检测周期 |
| `mongodb.livenessProbe.timeoutSeconds` | `5` | Liveness 超时 |
| `mongodb.livenessProbe.failureThreshold` | `6` | Liveness 失败阈值 |
| `mongodb.livenessProbe.successThreshold` | `1` | Liveness 成功阈值 |
| `mongodb.metrics.enabled` | `false` | 是否启用 Prometheus Exporter |
| `mongodb.metrics.service.port` | `9216` | Metrics 服务端口 |
| `mongodb.tls.enabled` | `false` | 是否启用 TLS |
| `mongodb.tls.certificatesSecret` | `""` | TLS 证书 Secret 名称 |
| `mongodb.ingress.enabled` | `false` | 是否启用 Ingress |
| `mongodb.ingress.className` | `"higress"` | Ingress 类名，使用 Higress 时设为 "higress" |
| `mongodb.ingress.domainSuffix` | `""` | 域名后缀，最终域名格式: {release-name}-{service}.{domainSuffix} |
| `mongodb.ingress.host` | `""` | 自定义域名（优先级高于 domainSuffix） |
| `mongodb.ingress.tls.enabled` | `false` | 是否启用 TLS |
| `mongodb.ingress.tls.secretName` | `""` | TLS 证书 Secret 名称 |
| `mongodb.ingress.annotations` | `{}` | Ingress 注解 |
| `mongodb.arbiter.enabled` | `false` | 是否启用仲裁节点（仅 replicaset） |
| `mongodb.hidden.enabled` | `false` | 是否启用隐藏节点（仅 replicaset） |
| `mongodb.hidden.persistence.enabled` | `true` | 隐藏节点持久化 |
| `mongodb.hidden.persistence.size` | `8Gi` | 隐藏节点持久卷大小 |
| `mongodb.hidden.persistence.storageClassName` | `""` | 隐藏节点存储类名 |
| `mongodb.hidden.persistence.existingClaim` | `""` | 隐藏节点已有 PVC |
| `mongodb.hidden.resources.requests.cpu` | `250m` | 隐藏节点 CPU 请求 |
| `mongodb.hidden.resources.requests.memory` | `256Mi` | 隐藏节点内存请求 |
| `mongodb.hidden.resources.limits.cpu` | `"1"` | 隐藏节点 CPU 上限 |
| `mongodb.hidden.resources.limits.memory` | `1Gi` | 隐藏节点内存上限 |
| `mongodb.volumePermissions.enabled` | `false` | initContainer 修改卷权限 |

## 测试环境推荐配置

```yaml
mongodb:
  architecture: standalone
  auth:
    rootPassword: "TestRoot123"
    database: "appdb"
    username: "appuser"
    password: "TestUser123"
  persistence:
    enabled: false
  resources:
    requests:
      cpu: 100m
      memory: 128Mi
    limits:
      cpu: 500m
      memory: 512Mi
  metrics:
    enabled: false
```

## 生产环境推荐配置

```yaml
mongodb:
  architecture: replicaset
  auth:
    rootPassword: ""        # 通过 --set 或 existingSecret 传入
    database: "appdb"
    username: "appuser"
    password: ""            # 通过 --set 或 existingSecret 传入
    replicaSetKey: ""       # 通过 --set 或 existingSecret 传入
    existingSecret: ""      # 推荐使用已有 Secret 管理密码
  replicaSetName: "rs0"
  replicaSetHostnames: true
  persistence:
    enabled: true
    size: 50Gi
    storageClassName: "ssd"
  resources:
    requests:
      cpu: "1"
      memory: 2Gi
    limits:
      cpu: "2"
      memory: 4Gi
  nodeSelector:
    node-role: database
  tolerations:
    - key: "dedicated"
      operator: "Equal"
      value: "mongodb"
      effect: "NoSchedule"
  readinessProbe:
    enabled: true
    initialDelaySeconds: 5
    periodSeconds: 10
  livenessProbe:
    enabled: true
    initialDelaySeconds: 30
    periodSeconds: 10
  metrics:
    enabled: true
    service:
      port: 9216
  tls:
    enabled: true
    certificatesSecret: "mongo-tls-secret"
  arbiter:
    enabled: true
  hidden:
    enabled: false
  volumePermissions:
    enabled: false
```

### 通过 Higress 网关暴露服务

```bash
# 通过 Higress 网关暴露服务
helm install my-mongodb ltbah/mongodb \
  --set mongodb.auth.rootPassword=yourpassword \
  --set mongodb.auth.password=yourpassword \
  --set mongodb.ingress.enabled=true \
  --set mongodb.ingress.className=higress \
  --set mongodb.ingress.domainSuffix=example.com
```

如需 TLS：
```bash
  --set mongodb.ingress.tls.enabled=true \
  --set mongodb.ingress.tls.secretName=mongodb-tls
```

## 更多配置

详见 [Bitnami MongoDB Chart](https://github.com/bitnami/charts/tree/main/bitnami/mongodb)
