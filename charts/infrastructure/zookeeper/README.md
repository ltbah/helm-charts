# ZooKeeper Wrapper Chart

Wrapper Chart for [Bitnami ZooKeeper](https://github.com/bitnami/charts/tree/main/bitnami/zookeeper)，提供 Java 开发场景的默认配置。

## 最简安装

```bash
helm install my-zookeeper ltbah/zookeeper
```

## 最全配置安装

```bash
helm install my-zookeeper ltbah/zookeeper \
  --set zookeeper.replicaCount=3 \
  --set zookeeper.auth.enabled=true \
  --set zookeeper.auth.clientUser=admin \
  --set zookeeper.auth.clientPassword=ChangeMe \
  --set zookeeper.auth.serverUsers="server1,server2,server3" \
  --set zookeeper.auth.serverPasswords="pass1,pass2,pass3" \
  --set zookeeper.persistence.enabled=true \
  --set zookeeper.persistence.size=8Gi \
  --set zookeeper.persistence.storageClassName=standard \
  --set zookeeper.resources.requests.cpu=500m \
  --set zookeeper.resources.requests.memory=512Mi \
  --set zookeeper.resources.limits.cpu=2 \
  --set zookeeper.resources.limits.memory=1Gi \
  --set zookeeper.service.type=ClusterIP \
  --set zookeeper.service.ports.client=2181 \
  --set zookeeper.service.ports.follower=2888 \
  --set zookeeper.service.ports.election=3888 \
  --set zookeeper.nodeSelector."disktype"=ssd \
  --set zookeeper.tolerations[0].key=dedicated \
  --set zookeeper.tolerations[0].operator=Equal \
  --set zookeeper.tolerations[0].value=zookeeper \
  --set zookeeper.tolerations[0].effect=NoSchedule \
  --set zookeeper.podAnnotations."prometheus.io/scrape"=true \
  --set zookeeper.podLabels."app-tier"=coordination \
  --set zookeeper.extraEnvVars[0].name=TZ \
  --set zookeeper.extraEnvVars[0].value=Asia/Shanghai \
  --set zookeeper.readinessProbe.enabled=true \
  --set zookeeper.readinessProbe.initialDelaySeconds=5 \
  --set zookeeper.livenessProbe.enabled=true \
  --set zookeeper.livenessProbe.initialDelaySeconds=30 \
  --set zookeeper.metrics.enabled=true \
  --set zookeeper.metrics.service.port=9141 \
  --set zookeeper.tls.enabled=true \
  --set zookeeper.tls.certificatesSecret=zookeeper-tls \
  --set zookeeper.networkPolicy.enabled=true \
  --set zookeeper.volumePermissions.enabled=true \
  --set zookeeper.logLevel=INFO
```

## 必填参数

| 参数 | 说明 |
|------|------|
| `zookeeper.auth.clientPassword` | 开启认证时客户端密码（`auth.enabled=true` 时必填） |
| `zookeeper.auth.serverPasswords` | 开启认证时服务端密码（`auth.enabled=true` 时必填，逗号分隔与 `serverUsers` 一一对应） |
| `zookeeper.tls.certificatesSecret` | 开启 TLS 时包含证书的 Secret 名称（`tls.enabled=true` 时必填） |

## 参数列表

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `zookeeper.image.repository` | `""` | 镜像仓库地址，空值使用上游默认 |
| `zookeeper.image.tag` | `""` | 镜像标签，空值使用上游默认（跟随 appVersion） |
| `zookeeper.image.pullPolicy` | `IfNotPresent` | 镜像拉取策略 |
| `zookeeper.replicaCount` | `3` | 副本数，生产环境建议 ≥ 3 且为奇数 |
| `zookeeper.auth.enabled` | `false` | 是否启用认证 |
| `zookeeper.auth.clientUser` | `""` | 客户端认证用户名 |
| `zookeeper.auth.clientPassword` | `""` | 客户端认证密码 |
| `zookeeper.auth.serverUsers` | `""` | 服务端间认证用户名（逗号分隔） |
| `zookeeper.auth.serverPasswords` | `""` | 服务端间认证密码（逗号分隔） |
| `zookeeper.persistence.enabled` | `true` | 是否启用持久化存储 |
| `zookeeper.persistence.size` | `4Gi` | 持久化存储大小 |
| `zookeeper.persistence.storageClassName` | `""` | 存储类名，空值使用集群默认 |
| `zookeeper.persistence.existingClaim` | `""` | 使用已有 PVC，设置后 `size` 与 `storageClassName` 被忽略 |
| `zookeeper.resources.requests.cpu` | `250m` | CPU 请求 |
| `zookeeper.resources.requests.memory` | `256Mi` | 内存请求 |
| `zookeeper.resources.limits.cpu` | `"1"` | CPU 上限 |
| `zookeeper.resources.limits.memory` | `512Mi` | 内存上限 |
| `zookeeper.service.type` | `ClusterIP` | Service 类型 |
| `zookeeper.service.ports.client` | `2181` | 客户端连接端口 |
| `zookeeper.service.ports.follower` | `2888` | Follower 连接端口 |
| `zookeeper.service.ports.election` | `3888` | 选举端口 |
| `zookeeper.nodeSelector` | `{}` | 节点选择标签 |
| `zookeeper.tolerations` | `[]` | 容忍度 |
| `zookeeper.affinity` | `{}` | 亲和性/反亲和性 |
| `zookeeper.podAnnotations` | `{}` | Pod 自定义标注 |
| `zookeeper.podLabels` | `{}` | Pod 自定义标签 |
| `zookeeper.extraEnvVars` | `[]` | 额外环境变量列表 |
| `zookeeper.readinessProbe.enabled` | `true` | 是否启用就绪探针 |
| `zookeeper.readinessProbe.initialDelaySeconds` | `5` | 就绪探针初始延迟 |
| `zookeeper.readinessProbe.periodSeconds` | `10` | 就绪探针检测周期 |
| `zookeeper.readinessProbe.timeoutSeconds` | `5` | 就绪探针超时 |
| `zookeeper.readinessProbe.failureThreshold` | `6` | 就绪探针失败阈值 |
| `zookeeper.readinessProbe.successThreshold` | `1` | 就绪探针成功阈值 |
| `zookeeper.livenessProbe.enabled` | `true` | 是否启用存活探针 |
| `zookeeper.livenessProbe.initialDelaySeconds` | `30` | 存活探针初始延迟 |
| `zookeeper.livenessProbe.periodSeconds` | `10` | 存活探针检测周期 |
| `zookeeper.livenessProbe.timeoutSeconds` | `5` | 存活探针超时 |
| `zookeeper.livenessProbe.failureThreshold` | `6` | 存活探针失败阈值 |
| `zookeeper.livenessProbe.successThreshold` | `1` | 存活探针成功阈值 |
| `zookeeper.metrics.enabled` | `false` | 是否启用 Prometheus Metrics Exporter |
| `zookeeper.metrics.service.port` | `9141` | Metrics 服务端口 |
| `zookeeper.tls.enabled` | `false` | 是否启用 TLS 加密 |
| `zookeeper.tls.certificatesSecret` | `""` | 包含证书的 Secret 名称 |
| `zookeeper.ingress.enabled` | `false` | 是否启用 Ingress |
| `zookeeper.ingress.className` | `"higress"` | Ingress 类名，使用 Higress 时设为 "higress" |
| `zookeeper.ingress.domainSuffix` | `""` | 域名后缀，最终域名格式: {release-name}-{service}.{domainSuffix} |
| `zookeeper.ingress.host` | `""` | 自定义域名（优先级高于 domainSuffix） |
| `zookeeper.ingress.tls.enabled` | `false` | 是否启用 TLS |
| `zookeeper.ingress.tls.secretName` | `""` | TLS 证书 Secret 名称 |
| `zookeeper.ingress.annotations` | `{}` | Ingress 注解 |
| `zookeeper.networkPolicy.enabled` | `false` | 是否启用 NetworkPolicy |
| `zookeeper.volumePermissions.enabled` | `false` | 是否用 initContainer 修改卷权限 |
| `zookeeper.logLevel` | `"INFO"` | 日志级别 (INFO / WARN / ERROR / DEBUG) |

## 测试推荐配置

```bash
helm install my-zookeeper ltbah/zookeeper \
  --set zookeeper.replicaCount=1 \
  --set zookeeper.persistence.enabled=false \
  --set zookeeper.resources.requests.cpu=100m \
  --set zookeeper.resources.requests.memory=128Mi \
  --set zookeeper.resources.limits.cpu=500m \
  --set zookeeper.resources.limits.memory=256Mi \
  --set zookeeper.auth.enabled=false \
  --set zookeeper.metrics.enabled=false \
  --set zookeeper.logLevel=WARN
```

## 生产推荐配置

```bash
helm install my-zookeeper ltbah/zookeeper \
  --set zookeeper.replicaCount=3 \
  --set zookeeper.auth.enabled=true \
  --set zookeeper.auth.clientUser=admin \
  --set zookeeper.auth.clientPassword=<YOUR_STRONG_PASSWORD> \
  --set zookeeper.auth.serverUsers="zk1,zk2,zk3" \
  --set zookeeper.auth.serverPasswords="<PASS1>,<PASS2>,<PASS3>" \
  --set zookeeper.persistence.enabled=true \
  --set zookeeper.persistence.size=8Gi \
  --set zookeeper.persistence.storageClassName=fast-ssd \
  --set zookeeper.resources.requests.cpu=500m \
  --set zookeeper.resources.requests.memory=512Mi \
  --set zookeeper.resources.limits.cpu=2 \
  --set zookeeper.resources.limits.memory=1Gi \
  --set zookeeper.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchLabels."app\.kubernetes\.io/name"=zookeeper \
  --set zookeeper.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].topologyKey=topology.kubernetes.io/zone \
  --set zookeeper.metrics.enabled=true \
  --set zookeeper.tls.enabled=true \
  --set zookeeper.tls.certificatesSecret=zookeeper-tls \
  --set zookeeper.networkPolicy.enabled=true \
  --set zookeeper.volumePermissions.enabled=true \
  --set zookeeper.logLevel=INFO
```

### 通过 Higress 网关暴露服务

```bash
# 通过 Higress 网关暴露服务
helm install my-zookeeper ltbah/zookeeper \
  --set zookeeper.ingress.enabled=true \
  --set zookeeper.ingress.className=higress \
  --set zookeeper.ingress.domainSuffix=example.com
```

如需 TLS：
```bash
  --set zookeeper.ingress.tls.enabled=true \
  --set zookeeper.ingress.tls.secretName=zookeeper-tls
```
