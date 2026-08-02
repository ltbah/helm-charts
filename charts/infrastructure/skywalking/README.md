# SkyWalking Wrapper Chart

Wrapper Chart for [Apache SkyWalking](https://github.com/apache/skywalking-helm)，提供分布式追踪和 APM 的默认配置。

## 快速开始

```bash
# 最简安装（使用内置 Elasticsearch）
helm install my-skywalking ltbah/skywalking

# 生产安装
helm install my-skywalking ltbah/skywalking \
  --set skywalking.oap.replicas=3 \
  --set skywalking.oap.javaOpts="-Xms4g -Xmx4g" \
  --set skywalking.oap.resources.requests.cpu=2 \
  --set skywalking.oap.resources.requests.memory=4Gi \
  --set skywalking.oap.resources.limits.cpu=4 \
  --set skywalking.oap.resources.limits.memory=8Gi \
  --set skywalking.ui.replicas=2 \
  --set skywalking.ui.ingress.enabled=true \
  --set skywalking.ui.ingress.hosts[0]=skywalking.example.com \
  --set skywalking.elasticsearch.enabled=false \
  --set skywalking.elasticsearch.config.host=es-cluster \
  --set skywalking.elasticsearch.config.port.http=9200
```

## 必填参数

无。默认配置可直接启动（内置 Elasticsearch + 内存存储）。

> ⚠️ 生产环境必须配置外部 Elasticsearch，内置 ES 仅用于测试。

## 参数列表

### OAP Server 配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `skywalking.oap.replicas` | OAP 副本数 | `2` |
| `skywalking.oap.image.repository` | OAP 镜像仓库 | `apache/skywalking-oap-server` |
| `skywalking.oap.image.tag` | OAP 镜像标签 | `""` |
| `skywalking.oap.image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |
| `skywalking.oap.storageType` | 存储类型 | `elasticsearch` |
| `skywalking.oap.javaOpts` | JVM 参数 | `-Xms2g -Xmx2g` |
| `skywalking.oap.ports.grpc` | gRPC 端口 | `11800` |
| `skywalking.oap.ports.rest` | REST 端口 | `12800` |
| `skywalking.oap.ports.admin` | Admin 端口 | `17128` |
| `skywalking.oap.service.type` | 服务类型 | `ClusterIP` |
| `skywalking.oap.resources` | 资源配置 | `{}` |
| `skywalking.oap.nodeSelector` | 节点选择器 | `{}` |
| `skywalking.oap.tolerations` | 容忍度 | `[]` |
| `skywalking.oap.affinity` | 亲和性 | `{}` |
| `skywalking.oap.extraEnvVars` | 额外环境变量 | `[]` |
| `skywalking.oap.dynamicConfig.enabled` | 动态配置开关 | `false` |

### UI 配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `skywalking.ui.replicas` | UI 副本数 | `1` |
| `skywalking.ui.image.repository` | UI 镜像仓库 | `apache/skywalking-ui` |
| `skywalking.ui.image.tag` | UI 镜像标签 | `""` |
| `skywalking.ui.service.type` | 服务类型 | `ClusterIP` |
| `skywalking.ui.service.externalPort` | 外部端口 | `80` |
| `skywalking.ui.ingress.enabled` | 启用 Ingress | `false` |
| `skywalking.ui.ingress.hosts` | Ingress 域名 | `[]` |
| `skywalking.ui.ingress.tls` | TLS 配置 | `[]` |
| `skywalking.ui.persistence.enabled` | 持久化开关 | `false` |
| `skywalking.ui.persistence.size` | 持久化大小 | `1Gi` |
| `skywalking.ui.resources` | 资源配置 | `{}` |

### Satellite / Event

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `skywalking.satellite.enabled` | 启用 Satellite | `false` |
| `skywalking.event.enabled` | 启用 Event | `false` |

### Elasticsearch 配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `skywalking.elasticsearch.enabled` | 部署内置 ES | `true` |
| `skywalking.elasticsearch.version` | ES 版本 | `8.18.8` |
| `skywalking.elasticsearch.nodeCount` | ES 节点数 | `3` |
| `skywalking.elasticsearch.config.host` | 外部 ES 地址 | `elasticsearch` |
| `skywalking.elasticsearch.config.port.http` | 外部 ES 端口 | `9200` |
| `skywalking.elasticsearch.config.user` | 外部 ES 用户 | `""` |
| `skywalking.elasticsearch.config.password` | 外部 ES 密码 | `""` |

## 推荐配置

### 测试环境

```bash
helm install my-skywalking ltbah/skywalking \
  --set skywalking.oap.replicas=1 \
  --set skywalking.oap.javaOpts="-Xms1g -Xmx1g" \
  --set skywalking.elasticsearch.nodeCount=1
```

### 生产环境

```bash
helm install my-skywalking ltbah/skywalking \
  --set skywalking.oap.replicas=3 \
  --set skywalking.oap.javaOpts="-Xms4g -Xmx4g" \
  --set skywalking.oap.resources.requests.cpu=2 \
  --set skywalking.oap.resources.requests.memory=4Gi \
  --set skywalking.oap.resources.limits.cpu=4 \
  --set skywalking.oap.resources.limits.memory=8Gi \
  --set skywalking.ui.replicas=2 \
  --set skywalking.ui.ingress.enabled=true \
  --set skywalking.ui.ingress.hosts[0]=skywalking.example.com \
  --set skywalking.ui.ingress.tls[0].hosts[0]=skywalking.example.com \
  --set skywalking.ui.ingress.tls[0].secretName=skywalking-tls \
  --set skywalking.elasticsearch.enabled=false \
  --set skywalking.elasticsearch.config.host=es-cluster \
  --set skywalking.elasticsearch.config.port.http=9200 \
  --set skywalking.elasticsearch.config.user=elastic \
  --set skywalking.elasticsearch.config.password=ES_PASSWORD
```

## 更多配置

详见 [Apache SkyWalking Helm Chart](https://github.com/apache/skywalking-helm)
