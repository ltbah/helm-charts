# Grafana Wrapper Chart

Wrapper Chart for [Grafana Helm Chart](https://github.com/grafana/helm-charts/tree/main/charts/grafana)，提供数据可视化和仪表盘的默认配置。

## 使用示例

```bash
# 通过 Ingress 暴露服务（支持 Higress / Nginx 等）
helm install my-grafana ltbah/grafana \
  --set grafana.adminPassword=yourpassword \
  --set grafana.ingress.enabled=true \
  --set grafana.ingress.className=higress \
  --set grafana.ingress.domainSuffix=example.com

# 指定镜像版本
helm install my-grafana ltbah/grafana \
  --set grafana.image.tag=11.2.0
```

## 最简安装

```bash
helm install my-grafana ltbah/grafana \
  --set grafana.adminPassword=yourpassword
```

## 最全配置安装

```bash
helm install my-grafana ltbah/grafana \
  --set grafana.adminPassword=yourpassword \
  --set grafana.replicas=2 \
  --set grafana.persistence.enabled=true \
  --set grafana.persistence.size=20Gi \
  --set grafana.persistence.storageClassName=ssd \
  --set grafana.resources.requests.cpu=200m \
  --set grafana.resources.requests.memory=256Mi \
  --set grafana.resources.limits.cpu=1 \
  --set grafana.resources.limits.memory=1Gi \
  --set grafana.service.type=LoadBalancer \
  --set grafana.service.port=80 \
  --set grafana.ingress.enabled=true \
  --set 'grafana.ingress.hosts[0]=grafana.example.com' \
  --set grafana.smtp.enabled=true \
  --set grafana.smtp.host=smtp.example.com:587 \
  --set grafana.smtp.user=alert@example.com \
  --set grafana.smtp.password=smtp-password \
  --set grafana.smtp.from_address=alert@example.com
```

或通过 values 文件：

```bash
helm install my-grafana ltbah/grafana -f my-values.yaml
```

## 必填参数

| 参数 | 说明 |
|------|------|
| `grafana.adminPassword` | **必填**。Grafana 管理员密码，默认为空字符串，安装时必须设置。 |

## 参数列表

### 镜像配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `grafana.image.repository` | 镜像仓库 | `""` |
| `grafana.image.tag` | 镜像标签 | `""` |
| `grafana.image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |

### Ingress 配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `grafana.ingress.enabled` | 启用 Ingress | `false` |
| `grafana.ingress.className` | Ingress 类名 (higress, nginx 等) | `""` |
| `grafana.ingress.domainSuffix` | 域名后缀 | `""` |
| `grafana.ingress.host` | 自定义域名（优先级高于 domainSuffix） | `""` |
| `grafana.ingress.tls.enabled` | 启用 TLS | `false` |
| `grafana.ingress.tls.secretName` | TLS Secret 名称 | `""` |
| `grafana.ingress.annotations` | Ingress 注解 | `{}` |

### 核心

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `grafana.adminPassword` | 管理员密码 (**必填**) | `""` |
| `grafana.replicas` | 副本数 | `1` |

### 持久化

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `grafana.persistence.enabled` | 启用持久化 | `true` |
| `grafana.persistence.size` | 存储大小 | `5Gi` |
| `grafana.persistence.storageClassName` | StorageClass 名称 | `""` |

### 资源

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `grafana.resources.requests.cpu` | CPU 请求 | `100m` |
| `grafana.resources.requests.memory` | 内存请求 | `128Mi` |
| `grafana.resources.limits.cpu` | CPU 限制 | `500m` |
| `grafana.resources.limits.memory` | 内存限制 | `512Mi` |

### Service

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `grafana.service.type` | Service 类型 | `ClusterIP` |
| `grafana.service.port` | 端口 | `80` |

### 调度

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `grafana.nodeSelector` | 节点选择器 | `{}` |
| `grafana.tolerations` | 容忍度 | `[]` |
| `grafana.affinity` | 亲和性 | `{}` |

### 数据源与仪表盘

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `grafana.datasources` | 数据源配置 (datasources.yaml) | 见 values.yaml |
| `grafana.dashboardProviders` | Dashboard Provider 配置 | 见 values.yaml |

### Pod

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `grafana.extraEnvVars` | 额外环境变量 | `[]` |
| `grafana.podAnnotations` | Pod 注解 | `{}` |
| `grafana.podLabels` | Pod 标签 | `{}` |
| `grafana.readinessProbe` | 就绪探针 | 见 values.yaml |
| `grafana.livenessProbe` | 存活探针 | 见 values.yaml |
| `grafana.securityContext` | 安全上下文 | `{}` |
| `grafana.fsGroup` | 文件系统组 ID | `472` |

### SMTP

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `grafana.smtp.enabled` | 启用 SMTP | `false` |
| `grafana.smtp.host` | SMTP 服务器地址 | `""` |
| `grafana.smtp.user` | SMTP 用户名 | `""` |
| `grafana.smtp.password` | SMTP 密码 | `""` |
| `grafana.smtp.from_address` | 发件人地址 | `""` |

### 插件

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `grafana.plugins` | 插件列表 | `[]` |

## 测试环境推荐配置

```yaml
grafana:
  adminPassword: "test-admin-password"
  replicas: 1
  persistence:
    enabled: false
  resources:
    requests:
      cpu: 50m
      memory: 64Mi
    limits:
      cpu: 200m
      memory: 256Mi
  service:
    type: NodePort
    port: 80
  smtp:
    enabled: false
  plugins: []
```

## 生产环境推荐配置

```yaml
grafana:
  adminPassword: ""  # 必须通过 --set 或 Sealed Secret 注入
  replicas: 2
  persistence:
    enabled: true
    size: 20Gi
    storageClassName: ssd
  resources:
    requests:
      cpu: 200m
      memory: 256Mi
    limits:
      cpu: "1"
      memory: 1Gi
  service:
    type: ClusterIP
    port: 80
  ingress:
    enabled: true
    hosts:
      - grafana.example.com
    tls:
      - secretName: grafana-tls
        hosts:
          - grafana.example.com
    annotations:
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: letsencrypt-prod
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
                    - grafana
            topologyKey: kubernetes.io/hostname
  smtp:
    enabled: true
    host: "smtp.example.com:587"
    user: "alert@example.com"
    password: ""  # 必须通过 --set 或 Sealed Secret 注入
    from_address: "alert@example.com"
  plugins:
    - grafana-clock-panel
    - grafana-piechart-panel
```
