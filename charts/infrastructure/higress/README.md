# Higress Wrapper Chart

Wrapper Chart for [Higress](https://github.com/alibaba/higress)，提供云原生 API 网关的默认配置。

## 使用示例

```bash
# 通过 Ingress 暴露服务（支持 Higress / Nginx 等）
helm install my-higress ltbah/higress \
  --set higress.ingress.enabled=true \
  --set higress.ingress.className=higress \
  --set higress.ingress.domainSuffix=example.com

# 指定镜像版本
helm install my-higress ltbah/higress \
  --set higress.image.tag=2.0.0
```

## 快速开始

```bash
# 最简安装
helm install my-higress ltbah/higress

# 生产安装
helm install my-higress ltbah/higress \
  --set higress.gateway.replicas=3 \
  --set higress.gateway.resources.requests.cpu=500m \
  --set higress.gateway.resources.requests.memory=512Mi \
  --set higress.gateway.resources.limits.cpu=2 \
  --set higress.gateway.resources.limits.memory=2Gi \
  --set higress.controller.replicas=2 \
  --set higress.controller.resources.requests.cpu=500m \
  --set higress.controller.resources.requests.memory=2048Mi \
  --set higress.global.enableRedis=true \
  --set higress.tracing.enabled=true \
  --set higress.tracing.sampling=10
```

## 必填参数

无。默认配置可直接启动。

## 参数列表

### 镜像配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `higress.image.repository` | 镜像仓库 | `""` |
| `higress.image.tag` | 镜像标签 | `""` |
| `higress.image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |

### Ingress 配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `higress.ingress.enabled` | 启用 Ingress | `false` |
| `higress.ingress.className` | Ingress 类名 (higress, nginx 等) | `""` |
| `higress.ingress.domainSuffix` | 域名后缀 | `""` |
| `higress.ingress.host` | 自定义域名（优先级高于 domainSuffix） | `""` |
| `higress.ingress.tls.enabled` | 启用 TLS | `false` |
| `higress.ingress.tls.secretName` | TLS Secret 名称 | `""` |
| `higress.ingress.annotations` | Ingress 注解 | `{}` |

### Gateway 配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `higress.gateway.replicas` | Gateway 副本数 | `2` |
| `higress.gateway.kind` | 部署模式: Deployment 或 DaemonSet | `Deployment` |
| `higress.gateway.hostNetwork` | 使用宿主机网络 | `false` |
| `higress.gateway.ingressClass` | IngressClass 名称 | `higress` |
| `higress.gateway.resources` | 资源配置 | `{}` |
| `higress.gateway.service.type` | 服务类型 | `LoadBalancer` |
| `higress.gateway.service.ports.http` | HTTP 端口 | `80` |
| `higress.gateway.service.ports.https` | HTTPS 端口 | `443` |
| `higress.gateway.nodeSelector` | 节点选择器 | `{}` |
| `higress.gateway.tolerations` | 容忍度 | `[]` |
| `higress.gateway.affinity` | 亲和性 | `{}` |
| `higress.gateway.autoscaling.enabled` | 启用 HPA | `false` |
| `higress.gateway.metrics.enabled` | 启用 Metrics | `false` |

### Controller 配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `higress.controller.replicas` | Controller 副本数 | `1` |
| `higress.controller.image` | Controller 镜像 | `higress` |
| `higress.controller.resources` | 资源配置 | `{}` |
| `higress.controller.automaticHttps.enabled` | 自动 HTTPS | `true` |
| `higress.controller.automaticHttps.email` | 证书邮箱 | `""` |

### 全局配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `higress.global.watchNamespace` | 监控命名空间 | `""` |
| `higress.global.ingressClass` | IngressClass | `higress` |
| `higress.global.enableIstioAPI` | 启用 Istio API | `true` |
| `higress.global.enableGatewayAPI` | 启用 Gateway API | `true` |
| `higress.global.enableRedis` | 启用 Redis | `false` |
| `higress.global.enableH3` | 启用 HTTP/3 | `false` |
| `higress.global.logging.level` | 日志级别 | `default:info` |

### 追踪与连接

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `higress.tracing.enabled` | 启用追踪 | `false` |
| `higress.tracing.sampling` | 采样率 | `100` |
| `higress.downstream.idleTimeout` | 下游空闲超时(秒) | `180` |
| `higress.upstream.idleTimeout` | 上游空闲超时(秒) | `10` |
| `higress.gzip.enable` | 启用 Gzip | `true` |

## 推荐配置

### 测试环境

```bash
helm install my-higress ltbah/higress \
  --set higress.gateway.replicas=1 \
  --set higress.gateway.service.type=NodePort \
  --set higress.controller.replicas=1
```

### 生产环境

```bash
helm install my-higress ltbah/higress \
  --set higress.gateway.replicas=3 \
  --set higress.gateway.kind=DaemonSet \
  --set higress.gateway.hostNetwork=true \
  --set higress.gateway.resources.requests.cpu=500m \
  --set higress.gateway.resources.requests.memory=512Mi \
  --set higress.gateway.resources.limits.cpu=2 \
  --set higress.gateway.resources.limits.memory=2Gi \
  --set higress.controller.replicas=2 \
  --set higress.controller.resources.requests.cpu=500m \
  --set higress.controller.resources.requests.memory=2048Mi \
  --set higress.global.enableRedis=true \
  --set higress.tracing.enabled=true \
  --set higress.tracing.sampling=10 \
  --set higress.gateway.metrics.enabled=true
```

## 更多配置

详见 [Higress Chart](https://github.com/alibaba/higress)
