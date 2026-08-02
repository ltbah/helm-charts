# Kibana Wrapper Chart

Wrapper Chart for [Elastic Kibana](https://github.com/elastic/helm-charts/tree/main/kibana)，提供 Elasticsearch 可视化的默认配置。

## 最简安装

```bash
helm install my-kibana ltbah/kibana \
  --set kibana.elasticsearchHosts="https://my-es:9200"
```

## 最全配置安装

```bash
helm install my-kibana ltbah/kibana \
  --set kibana.elasticsearchHosts="https://my-es:9200" \
  --set kibana.replicas=3 \
  --set kibana.resources.requests.cpu=1 \
  --set kibana.resources.requests.memory=2Gi \
  --set kibana.resources.limits.cpu=2 \
  --set kibana.resources.limits.memory=4Gi \
  --set kibana.service.type=LoadBalancer \
  --set kibana.service.port=5601 \
  --set kibana.persistence.enabled=true \
  --set kibana.persistence.size=5Gi \
  --set kibana.persistence.storageClassName=ssd \
  --set kibana.ingress.enabled=true \
  --set kibana.ingress.className=nginx \
  --set kibana.ingress.host=kibana.example.com \
  --set kibana.ingress.tls.enabled=true \
  --set kibana.ingress.tls.secretName=kibana-tls \
  --set kibana.protocol=https \
  --set kibana.tls.enabled=true \
  --set kibana.tls.certificatesSecret=kibana-certs \
  --set kibana.securityContext.runAsUser=1000 \
  --set kibana.fsGroup=1000 \
  --set-file kibana.kibanaConfig.kibana\.yml=kibana.yml
```

## 必填参数

| 参数 | 说明 |
|------|------|
| `kibana.elasticsearchHosts` | Elasticsearch 连接地址，无内置 ES 时必须指定 |

## 参数列表

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `kibana.image.repository` | `""` | 镜像仓库地址，空值使用上游 Chart 默认 |
| `kibana.image.tag` | `""` | 镜像标签，空值使用上游 Chart 默认版本 |
| `kibana.image.pullPolicy` | `IfNotPresent` | 镜像拉取策略 |
| `kibana.elasticsearchHosts` | `https://elasticsearch:9200` | Elasticsearch 连接地址 |
| `kibana.replicas` | `1` | Kibana 副本数 |
| `kibana.resources.requests.cpu` | `500m` | CPU 请求 |
| `kibana.resources.requests.memory` | `1Gi` | 内存请求 |
| `kibana.resources.limits.cpu` | `1` | CPU 限制 |
| `kibana.resources.limits.memory` | `2Gi` | 内存限制 |
| `kibana.service.type` | `ClusterIP` | Service 类型 |
| `kibana.service.port` | `5601` | Service 端口 |
| `kibana.service.annotations` | `{}` | Service 注解 |
| `kibana.persistence.enabled` | `false` | 是否启用持久化 |
| `kibana.persistence.size` | `1Gi` | 持久化存储大小 |
| `kibana.persistence.storageClassName` | `""` | 存储类名 |
| `kibana.ingress.enabled` | `false` | 是否启用 Ingress |
| `kibana.ingress.className` | `""` | Ingress 类名 (higress, nginx 等) |
| `kibana.ingress.domainSuffix` | `""` | 域名后缀，最终域名: {release-name}-{service}.{domainSuffix} |
| `kibana.ingress.host` | `""` | 自定义域名（优先级高于 domainSuffix） |
| `kibana.ingress.tls.enabled` | `false` | 是否启用 Ingress TLS |
| `kibana.ingress.tls.secretName` | `""` | TLS 证书 Secret 名称 |
| `kibana.ingress.annotations` | `{}` | Ingress 注解 |
| `kibana.nodeSelector` | `{}` | 节点选择器 |
| `kibana.tolerations` | `[]` | 容忍度 |
| `kibana.affinity` | `{}` | 亲和性 |
| `kibana.podAnnotations` | `{}` | Pod 注解 |
| `kibana.podLabels` | `{}` | Pod 额外标签 |
| `kibana.extraEnvs` | `[]` | 额外环境变量 |
| `kibana.kibanaConfig` | `{}` | kibana.yml 配置 |
| `kibana.protocol` | `https` | 协议 (http/https) |
| `kibana.tls.enabled` | `false` | 是否启用 TLS |
| `kibana.tls.certificatesSecret` | `""` | TLS 证书 Secret |
| `kibana.readinessProbe` | (见 values) | 就绪探针配置 |
| `kibana.livenessProbe` | (见 values) | 存活探针配置 |
| `kibana.securityContext` | (见 values) | 安全上下文 |
| `kibana.fsGroup` | `1000` | 卷文件系统组 |

## 测试环境推荐配置

```bash
helm install my-kibana ltbah/kibana \
  --set kibana.elasticsearchHosts="https://elasticsearch:9200" \
  --set kibana.replicas=1 \
  --set kibana.resources.requests.cpu=250m \
  --set kibana.resources.requests.memory=512Mi \
  --set kibana.resources.limits.cpu=500m \
  --set kibana.resources.limits.memory=1Gi \
  --set kibana.service.type=ClusterIP \
  --set kibana.persistence.enabled=false \
  --set kibana.protocol=http
```

## 生产环境推荐配置

```bash
helm install my-kibana ltbah/kibana \
  --set kibana.elasticsearchHosts="https://elasticsearch:9200" \
  --set kibana.replicas=3 \
  --set kibana.resources.requests.cpu=1 \
  --set kibana.resources.requests.memory=2Gi \
  --set kibana.resources.limits.cpu=2 \
  --set kibana.resources.limits.memory=4Gi \
  --set kibana.service.type=ClusterIP \
  --set kibana.persistence.enabled=true \
  --set kibana.persistence.size=5Gi \
  --set kibana.persistence.storageClassName=ssd \
  --set kibana.ingress.enabled=true \
  --set kibana.ingress.className=nginx \
  --set kibana.ingress.host=kibana.example.com \
  --set kibana.ingress.tls.enabled=true \
  --set kibana.ingress.tls.secretName=kibana-tls \
  --set kibana.protocol=https \
  --set kibana.tls.enabled=true \
  --set kibana.tls.certificatesSecret=kibana-certs \
  --set kibana.securityContext.runAsNonRoot=true \
  --set kibana.fsGroup=1000
```

## 通过 Ingress 暴露服务

```bash
# 通过 Ingress 暴露服务（支持 Higress / Nginx 等）
helm install my-kibana ltbah/kibana \
  --set kibana.ingress.enabled=true \
  --set kibana.ingress.className=higress \
  --set kibana.ingress.domainSuffix=example.com

# 使用 Nginx Ingress
helm install my-kibana ltbah/kibana \
  --set kibana.ingress.enabled=true \
  --set kibana.ingress.className=nginx \
  --set kibana.ingress.host=kibana.example.com
```

## 更多配置

详见 [Elastic Kibana Chart](https://github.com/elastic/helm-charts/tree/main/kibana)
