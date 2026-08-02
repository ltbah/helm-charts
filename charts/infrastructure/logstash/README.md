# Logstash Wrapper Chart

Wrapper Chart for [Elastic Logstash](https://github.com/elastic/helm-charts/tree/main/logstash)，提供日志处理管道的默认配置。

## 最简安装

```bash
helm install my-logstash ltbah/logstash \
  --set logstash.elasticsearchHosts="https://my-es:9200"
```

## 最全配置安装

```bash
helm install my-logstash ltbah/logstash \
  --set logstash.elasticsearchHosts="https://my-es:9200" \
  --set logstash.replicas=3 \
  --set logstash.heapSize=2g \
  --set logstash.resources.requests.cpu=1 \
  --set logstash.resources.requests.memory=2Gi \
  --set logstash.resources.limits.cpu=2 \
  --set logstash.resources.limits.memory=4Gi \
  --set logstash.persistence.enabled=true \
  --set logstash.persistence.size=10Gi \
  --set logstash.persistence.storageClassName=ssd \
  --set logstash.service.type=ClusterIP \
  --set 'logstash.service.ports[0].name=http' \
  --set 'logstash.service.ports[0].port=8080' \
  --set 'logstash.service.ports[1].name=beats' \
  --set 'logstash.service.ports[1].port=5044' \
  --set logstash.lsJavaOpts="-Xms2g -Xmx2g" \
  --set logstash.ingress.enabled=true \
  --set logstash.ingress.className=nginx \
  --set logstash.ingress.host=logstash.example.com \
  --set logstash.ingress.tls.enabled=true \
  --set logstash.ingress.tls.secretName=logstash-tls \
  --set-file logstash.logstashPipeline.logstash\.conf=pipeline.conf
```

## 必填参数

| 参数 | 说明 |
|------|------|
| `logstash.elasticsearchHosts` | Elasticsearch 连接地址，必须指定 |

## 参数列表

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `logstash.image.repository` | `""` | 镜像仓库地址，空值使用上游 Chart 默认 |
| `logstash.image.tag` | `""` | 镜像标签，空值使用上游 Chart 默认版本 |
| `logstash.image.pullPolicy` | `IfNotPresent` | 镜像拉取策略 |
| `logstash.elasticsearchHosts` | `https://elasticsearch:9200` | Elasticsearch 连接地址 |
| `logstash.replicas` | `2` | Logstash 副本数 |
| `logstash.heapSize` | `1g` | JVM 堆内存大小 |
| `logstash.resources.requests.cpu` | `500m` | CPU 请求 |
| `logstash.resources.requests.memory` | `1Gi` | 内存请求 |
| `logstash.resources.limits.cpu` | `1` | CPU 限制 |
| `logstash.resources.limits.memory` | `2Gi` | 内存限制 |
| `logstash.persistence.enabled` | `false` | 是否启用持久化 |
| `logstash.persistence.size` | `2Gi` | 持久化存储大小 |
| `logstash.persistence.storageClassName` | `""` | 存储类名 |
| `logstash.service.type` | `ClusterIP` | Service 类型 |
| `logstash.service.ports` | `[{"name":"http","port":8080},{"name":"beats","port":5044}]` | Service 端口列表 |
| `logstash.logstashPipeline` | `{}` | Pipeline 配置 |
| `logstash.nodeSelector` | `{}` | 节点选择器 |
| `logstash.tolerations` | `[]` | 容忍度 |
| `logstash.affinity` | `{}` | 亲和性 |
| `logstash.extraEnvs` | `[]` | 额外环境变量 |
| `logstash.lsJavaOpts` | `-Xms1g -Xmx1g` | JVM 启动参数 |
| `logstash.readinessProbe` | (见 values) | 就绪探针配置 |
| `logstash.livenessProbe` | (见 values) | 存活探针配置 |
| `logstash.ingress.enabled` | `false` | 是否启用 Ingress |
| `logstash.ingress.className` | `""` | Ingress 类名 (higress, nginx 等) |
| `logstash.ingress.domainSuffix` | `""` | 域名后缀，最终域名: {release-name}-{service}.{domainSuffix} |
| `logstash.ingress.host` | `""` | 自定义域名（优先级高于 domainSuffix） |
| `logstash.ingress.tls.enabled` | `false` | 是否启用 Ingress TLS |
| `logstash.ingress.tls.secretName` | `""` | TLS 证书 Secret 名称 |
| `logstash.ingress.annotations` | `{}` | Ingress 注解 |

## 测试环境推荐配置

```bash
helm install my-logstash ltbah/logstash \
  --set logstash.elasticsearchHosts="https://elasticsearch:9200" \
  --set logstash.replicas=1 \
  --set logstash.heapSize=512m \
  --set logstash.resources.requests.cpu=250m \
  --set logstash.resources.requests.memory=512Mi \
  --set logstash.resources.limits.cpu=500m \
  --set logstash.resources.limits.memory=1Gi \
  --set logstash.lsJavaOpts="-Xms512m -Xmx512m" \
  --set logstash.persistence.enabled=false
```

## 生产环境推荐配置

```bash
helm install my-logstash ltbah/logstash \
  --set logstash.elasticsearchHosts="https://elasticsearch:9200" \
  --set logstash.replicas=3 \
  --set logstash.heapSize=4g \
  --set logstash.resources.requests.cpu=2 \
  --set logstash.resources.requests.memory=4Gi \
  --set logstash.resources.limits.cpu=4 \
  --set logstash.resources.limits.memory=8Gi \
  --set logstash.persistence.enabled=true \
  --set logstash.persistence.size=10Gi \
  --set logstash.persistence.storageClassName=ssd \
  --set logstash.lsJavaOpts="-Xms4g -Xmx4g" \
  --set logstash.ingress.enabled=true \
  --set logstash.ingress.className=nginx \
  --set logstash.ingress.host=logstash.example.com \
  --set logstash.ingress.tls.enabled=true \
  --set logstash.ingress.tls.secretName=logstash-tls
```

## 通过 Ingress 暴露服务

```bash
# 通过 Ingress 暴露服务（支持 Higress / Nginx 等）
helm install my-logstash ltbah/logstash \
  --set logstash.ingress.enabled=true \
  --set logstash.ingress.className=higress \
  --set logstash.ingress.domainSuffix=example.com

# 使用 Nginx Ingress
helm install my-logstash ltbah/logstash \
  --set logstash.ingress.enabled=true \
  --set logstash.ingress.className=nginx \
  --set logstash.ingress.host=logstash.example.com
```

## 更多配置

详见 [Elastic Logstash Chart](https://github.com/elastic/helm-charts/tree/main/logstash)
