# Prometheus Wrapper Chart

Wrapper Chart for [Prometheus Community Helm Chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus)，提供监控告警的默认配置。

## 使用示例

```bash
# 通过 Ingress 暴露服务（支持 Higress / Nginx 等）
helm install my-prometheus ltbah/prometheus \
  --set prometheus.server.retention="30d" \
  --set prometheus.ingress.enabled=true \
  --set prometheus.ingress.className=higress \
  --set prometheus.ingress.domainSuffix=example.com

# 指定镜像版本
helm install my-prometheus ltbah/prometheus \
  --set prometheus.image.tag=2.52.0
```

## 最简安装

```bash
helm install my-prometheus ltbah/prometheus
```

## 最全配置安装

```bash
helm install my-prometheus ltbah/prometheus \
  --set prometheus.server.replicaCount=2 \
  --set prometheus.server.retention="30d" \
  --set prometheus.server.persistentVolume.enabled=true \
  --set prometheus.server.persistentVolume.size=50Gi \
  --set prometheus.server.persistentVolume.storageClassName=ssd \
  --set prometheus.server.resources.requests.cpu=500m \
  --set prometheus.server.resources.requests.memory=2Gi \
  --set prometheus.server.resources.limits.cpu=2 \
  --set prometheus.server.resources.limits.memory=8Gi \
  --set prometheus.server.service.type=LoadBalancer \
  --set prometheus.server.ingress.enabled=true \
  --set 'prometheus.server.ingress.hosts[0]=prometheus.example.com' \
  --set prometheus.alertmanager.enabled=true \
  --set prometheus.alertmanager.persistentVolume.size=10Gi \
  --set prometheus.pushgateway.enabled=true \
  --set prometheus.nodeExporter.enabled=true \
  --set prometheus.kubeStateMetrics.enabled=true
```

或通过 values 文件：

```bash
helm install my-prometheus ltbah/prometheus -f my-values.yaml
```

## 必填参数

本 Chart 无强制必填参数，所有参数均有合理默认值，开箱即用。

## 参数列表

### 镜像配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `prometheus.image.repository` | 镜像仓库 | `""` |
| `prometheus.image.tag` | 镜像标签 | `""` |
| `prometheus.image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |

### Ingress 配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `prometheus.ingress.enabled` | 启用 Ingress | `false` |
| `prometheus.ingress.className` | Ingress 类名 (higress, nginx 等) | `""` |
| `prometheus.ingress.domainSuffix` | 域名后缀 | `""` |
| `prometheus.ingress.host` | 自定义域名（优先级高于 domainSuffix） | `""` |
| `prometheus.ingress.tls.enabled` | 启用 TLS | `false` |
| `prometheus.ingress.tls.secretName` | TLS Secret 名称 | `""` |
| `prometheus.ingress.annotations` | Ingress 注解 | `{}` |

### Server

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `prometheus.server.replicaCount` | Prometheus Server 副本数 | `1` |
| `prometheus.server.retention` | 数据保留时间 | `15d` |
| `prometheus.server.persistentVolume.enabled` | 是否启用持久化 | `true` |
| `prometheus.server.persistentVolume.size` | 持久化存储大小 | `10Gi` |
| `prometheus.server.persistentVolume.storageClassName` | StorageClass 名称 | `""` |
| `prometheus.server.persistentVolume.existingClaim` | 使用已有 PVC | `""` |
| `prometheus.server.resources.requests.cpu` | CPU 请求 | `250m` |
| `prometheus.server.resources.requests.memory` | 内存请求 | `512Mi` |
| `prometheus.server.resources.limits.cpu` | CPU 限制 | `1` |
| `prometheus.server.resources.limits.memory` | 内存限制 | `2Gi` |
| `prometheus.server.service.type` | Service 类型 | `ClusterIP` |
| `prometheus.server.service.ports.http` | HTTP 端口 | `9090` |
| `prometheus.server.nodeSelector` | 节点选择器 | `{}` |
| `prometheus.server.tolerations` | 容忍度 | `[]` |
| `prometheus.server.affinity` | 亲和性 | `{}` |
| `prometheus.server.extraArgs` | 额外启动参数 | `{}` |
| `prometheus.server.extraEnvVars` | 额外环境变量 | `[]` |
| `prometheus.server.configMapOverrideName` | 自定义配置 ConfigMap 名称 | `""` |
| `prometheus.server.ingress.enabled` | 启用 Ingress | `false` |
| `prometheus.server.ingress.hosts` | Ingress 域名列表 | `[]` |
| `prometheus.server.ingress.tls` | TLS 配置 | `[]` |
| `prometheus.server.podAnnotations` | Pod 注解 | `{}` |
| `prometheus.server.podLabels` | Pod 标签 | `{}` |
| `prometheus.server.readinessProbe` | 就绪探针 | 见 values.yaml |
| `prometheus.server.livenessProbe` | 存活探针 | 见 values.yaml |
| `prometheus.server.securityContext` | 安全上下文 | `{}` |

### Alertmanager

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `prometheus.alertmanager.enabled` | 启用 Alertmanager | `true` |
| `prometheus.alertmanager.persistentVolume.enabled` | 启用持久化 | `true` |
| `prometheus.alertmanager.persistentVolume.size` | 持久化存储大小 | `2Gi` |
| `prometheus.alertmanager.resources.requests` | 资源请求 | `cpu:50m,memory:64Mi` |
| `prometheus.alertmanager.resources.limits` | 资源限制 | `cpu:200m,memory:256Mi` |
| `prometheus.alertmanager.service.type` | Service 类型 | `ClusterIP` |
| `prometheus.alertmanager.service.port` | 端口 | `9093` |
| `prometheus.alertmanager.ingress.enabled` | 启用 Ingress | `false` |
| `prometheus.alertmanager.ingress.hosts` | Ingress 域名列表 | `[]` |
| `prometheus.alertmanager.ingress.tls` | TLS 配置 | `[]` |
| `prometheus.alertmanager.nodeSelector` | 节点选择器 | `{}` |
| `prometheus.alertmanager.tolerations` | 容忍度 | `[]` |
| `prometheus.alertmanager.affinity` | 亲和性 | `{}` |

### Pushgateway

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `prometheus.pushgateway.enabled` | 启用 Pushgateway | `true` |
| `prometheus.pushgateway.persistentVolume.enabled` | 启用持久化 | `false` |
| `prometheus.pushgateway.persistentVolume.size` | 持久化存储大小 | `2Gi` |
| `prometheus.pushgateway.resources.requests` | 资源请求 | `cpu:50m,memory:64Mi` |
| `prometheus.pushgateway.resources.limits` | 资源限制 | `cpu:200m,memory:256Mi` |
| `prometheus.pushgateway.service.type` | Service 类型 | `ClusterIP` |
| `prometheus.pushgateway.service.port` | 端口 | `9091` |
| `prometheus.pushgateway.ingress.enabled` | 启用 Ingress | `false` |
| `prometheus.pushgateway.ingress.hosts` | Ingress 域名列表 | `[]` |
| `prometheus.pushgateway.ingress.tls` | TLS 配置 | `[]` |

### 其他组件

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `prometheus.nodeExporter.enabled` | 启用 Node Exporter | `true` |
| `prometheus.kubeStateMetrics.enabled` | 启用 kube-state-metrics | `true` |

### 配置文件

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `prometheus.serverFiles.prometheus.yml` | Prometheus 采集配置 | 见 values.yaml |
| `prometheus.alertmanagerFiles.alertmanager.yml` | Alertmanager 告警路由配置 | 见 values.yaml |

## 测试环境推荐配置

```yaml
prometheus:
  server:
    replicaCount: 1
    retention: "7d"
    persistentVolume:
      enabled: false
    resources:
      requests:
        cpu: 100m
        memory: 256Mi
      limits:
        cpu: 500m
        memory: 1Gi
  alertmanager:
    enabled: true
    persistentVolume:
      enabled: false
  pushgateway:
    enabled: false
  nodeExporter:
    enabled: true
  kubeStateMetrics:
    enabled: true
```

## 生产环境推荐配置

```yaml
prometheus:
  server:
    replicaCount: 2
    retention: "30d"
    persistentVolume:
      enabled: true
      size: 100Gi
      storageClassName: ssd
    resources:
      requests:
        cpu: "1"
        memory: 4Gi
      limits:
        cpu: "4"
        memory: 16Gi
    ingress:
      enabled: true
      hosts:
        - prometheus.example.com
      tls:
        - secretName: prometheus-tls
          hosts:
            - prometheus.example.com
    affinity:
      podAntiAffinity:
        preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchExpressions:
                  - key: app
                    operator: In
                    values:
                      - prometheus
              topologyKey: kubernetes.io/hostname
  alertmanager:
    enabled: true
    persistentVolume:
      enabled: true
      size: 10Gi
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
      limits:
        cpu: 500m
        memory: 512Mi
  pushgateway:
    enabled: true
    persistentVolume:
      enabled: true
      size: 10Gi
  nodeExporter:
    enabled: true
  kubeStateMetrics:
    enabled: true
```
