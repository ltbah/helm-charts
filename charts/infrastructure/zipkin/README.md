# Zipkin Wrapper Chart

Wrapper Chart for [Zipkin](https://github.com/openzipkin/zipkin-helm)，提供分布式追踪的默认配置。

## 快速开始

```bash
# 最简安装（内存存储）
helm install my-zipkin ltbah/zipkin

# 生产安装（Elasticsearch 存储）
helm install my-zipkin ltbah/zipkin \
  --set zipkin.replicaCount=3 \
  --set zipkin.storage.type=elasticsearch \
  --set zipkin.storage.elasticsearch.hosts=elasticsearch:9200 \
  --set zipkin.storage.elasticsearch.username=elastic \
  --set zipkin.storage.elasticsearch.password=ES_PASSWORD \
  --set zipkin.resources.requests.cpu=500m \
  --set zipkin.resources.requests.memory=1Gi \
  --set zipkin.resources.limits.cpu=2 \
  --set zipkin.resources.limits.memory=2Gi \
  --set zipkin.ingress.enabled=true \
  --set zipkin.ingress.hosts[0]=zipkin.example.com
```

## 必填参数

无。默认配置可直接启动（内存存储）。

> ⚠️ 生产环境必须配置 `storage.type=elasticsearch`，内存存储重启后数据丢失。

## 参数列表

### 核心配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `zipkin.replicaCount` | 副本数 | `1` |
| `zipkin.image.repository` | 镜像仓库 | `openzipkin/zipkin-slim` |
| `zipkin.image.tag` | 镜像标签 | `""` |
| `zipkin.image.pullPolicy` | 拉取策略 | `IfNotPresent` |
| `zipkin.resources` | 资源配置 | `{}` |
| `zipkin.service.type` | 服务类型 | `ClusterIP` |
| `zipkin.service.port` | 服务端口 | `9411` |

### 存储配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `zipkin.storage.type` | 存储类型: mem, elasticsearch, cassandra | `mem` |
| `zipkin.storage.elasticsearch.hosts` | ES 主机地址（type=elasticsearch 时必填） | `""` |
| `zipkin.storage.elasticsearch.indexShards` | ES 索引分片数 | `5` |
| `zipkin.storage.elasticsearch.indexReplicas` | ES 索引副本数 | `1` |
| `zipkin.storage.elasticsearch.username` | ES 用户名 | `""` |
| `zipkin.storage.elasticsearch.password` | ES 密码 | `""` |

### 网络配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `zipkin.ingress.enabled` | 启用 Ingress | `false` |
| `zipkin.ingress.hosts` | Ingress 域名 | `[]` |
| `zipkin.ingress.tls` | TLS 配置 | `[]` |

### 调度与安全

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `zipkin.nodeSelector` | 节点选择器 | `{}` |
| `zipkin.tolerations` | 容忍度 | `[]` |
| `zipkin.affinity` | 亲和性 | `{}` |
| `zipkin.extraEnv` | 额外环境变量（如 JAVA_OPTS） | `{}` |
| `zipkin.securityContext` | 安全上下文 | 见 values.yaml |
| `zipkin.serviceMonitor.enabled` | 启用 ServiceMonitor | `false` |
| `zipkin.autoscaling.enabled` | 启用 HPA | `false` |

## 推荐配置

### 测试环境

```bash
helm install my-zipkin ltbah/zipkin \
  --set zipkin.replicaCount=1 \
  --set zipkin.resources.requests.cpu=100m \
  --set zipkin.resources.requests.memory=256Mi
```

### 生产环境

```bash
helm install my-zipkin ltbah/zipkin \
  --set zipkin.replicaCount=3 \
  --set zipkin.storage.type=elasticsearch \
  --set zipkin.storage.elasticsearch.hosts=elasticsearch:9200 \
  --set zipkin.storage.elasticsearch.username=elastic \
  --set zipkin.storage.elasticsearch.password=<ES_PASSWORD> \
  --set zipkin.resources.requests.cpu=500m \
  --set zipkin.resources.requests.memory=1Gi \
  --set zipkin.resources.limits.cpu=2 \
  --set zipkin.resources.limits.memory=2Gi \
  --set zipkin.ingress.enabled=true \
  --set zipkin.ingress.hosts[0]=zipkin.example.com \
  --set zipkin.serviceMonitor.enabled=true
```

## 更多配置

详见 [Zipkin Chart](https://github.com/openzipkin/zipkin-helm)
