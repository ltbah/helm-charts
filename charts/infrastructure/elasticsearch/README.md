# Elasticsearch Wrapper Chart

Wrapper Chart for [Elastic Elasticsearch](https://github.com/elastic/helm-charts/tree/main/elasticsearch)，提供日志存储和搜索的默认配置。

## 最简安装

```bash
helm install my-es ltbah/elasticsearch
```

## 最全配置安装

```bash
helm install my-es ltbah/elasticsearch \
  --set elasticsearch.clusterName=es-prod \
  --set elasticsearch.nodeGroup=master \
  --set elasticsearch.masterService=es-prod-master \
  --set elasticsearch.roles.master=true \
  --set elasticsearch.roles.data=true \
  --set elasticsearch.roles.ingest=true \
  --set elasticsearch.roles.ml=false \
  --set elasticsearch.replicas=3 \
  --set elasticsearch.esJavaOpts="-Xms4g -Xmx4g" \
  --set elasticsearch.resources.requests.cpu=1 \
  --set elasticsearch.resources.requests.memory=4Gi \
  --set elasticsearch.resources.limits.cpu=4 \
  --set elasticsearch.resources.limits.memory=8Gi \
  --set elasticsearch.persistence.enabled=true \
  --set elasticsearch.persistence.volumeClaimTemplate.accessModes[0]=ReadWriteOnce \
  --set elasticsearch.persistence.volumeClaimTemplate.resources.requests.storage=100Gi \
  --set elasticsearch.persistence.volumeClaimTemplate.storageClassName=ssd \
  --set elasticsearch.service.type=ClusterIP \
  --set elasticsearch.service.ports.http=9200 \
  --set elasticsearch.service.ports.transport=9300 \
  --set elasticsearch.protocol=https \
  --set elasticsearch.fsGroup=1000 \
  --set elasticsearch.secretsKeystoreEnabled=true \
  --set elasticsearch.keystore[0].secretName=es-credentials
```

更复杂配置建议使用 `--values` 文件：

```yaml
# values-prod.yaml
elasticsearch:
  clusterName: es-prod
  replicas: 3
  esJavaOpts: "-Xms4g -Xmx4g"
  resources:
    requests:
      cpu: 1
      memory: 4Gi
    limits:
      cpu: 4
      memory: 8Gi
  persistence:
    enabled: true
    volumeClaimTemplate:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 100Gi
      storageClassName: ssd
  esConfig:
    elasticsearch.yml: |
      xpack.security.enabled: true
      xpack.security.transport.ssl.enabled: true
  keystore:
    - secretName: es-credentials
  secretsKeystoreEnabled: true
```

```bash
helm install my-es ltbah/elasticsearch -f values-prod.yaml
```

## 必填参数

| 参数 | 说明 |
|------|------|
| 无 | 默认配置即可启动单节点测试集群；生产环境建议至少设置 `replicas`、`resources`、`esJavaOpts`、`persistence` |

## 参数列表

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `elasticsearch.clusterName` | `elasticsearch` | 集群名称，同集群内所有节点必须一致 |
| `elasticsearch.nodeGroup` | `master` | 节点组名称，用于区分不同角色组 |
| `elasticsearch.masterService` | `""` | Master 服务名称，多节点组部署时 data/ingest 节点组需指向 master 组 |
| `elasticsearch.roles.master` | `true` | 是否担任 master 角色 |
| `elasticsearch.roles.data` | `true` | 是否担任 data 角色 |
| `elasticsearch.roles.ingest` | `true` | 是否担任 ingest 角色 |
| `elasticsearch.roles.ml` | `false` | 是否担任 ml 角色 |
| `elasticsearch.replicas` | `3` | 副本数 |
| `elasticsearch.esJavaOpts` | `"-Xms2g -Xmx2g"` | JVM 堆内存参数，建议设为容器内存 50% |
| `elasticsearch.resources.requests.cpu` | `500m` | CPU 请求 |
| `elasticsearch.resources.requests.memory` | `2Gi` | 内存请求 |
| `elasticsearch.resources.limits.cpu` | `"2"` | CPU 限制 |
| `elasticsearch.resources.limits.memory` | `4Gi` | 内存限制 |
| `elasticsearch.persistence.enabled` | `true` | 是否启用持久化 |
| `elasticsearch.persistence.labels` | `{}` | PVC 自定义标签 |
| `elasticsearch.persistence.annotations` | `{}` | PVC 自定义注解 |
| `elasticsearch.persistence.volumeClaimTemplate.accessModes` | `["ReadWriteOnce"]` | PVC 访问模式 |
| `elasticsearch.persistence.volumeClaimTemplate.resources.requests.storage` | `30Gi` | 存储容量 |
| `elasticsearch.persistence.volumeClaimTemplate.storageClassName` | `""` | 存储类名，空值使用集群默认 |
| `elasticsearch.service.type` | `ClusterIP` | Service 类型 |
| `elasticsearch.service.ports.http` | `9200` | HTTP 端口 (REST API) |
| `elasticsearch.service.ports.transport` | `9300` | Transport 端口 (节点间通信) |
| `elasticsearch.nodeSelector` | `{}` | 节点选择器 |
| `elasticsearch.tolerations` | `[]` | 容忍度 |
| `elasticsearch.affinity` | `{}` | 亲和性/反亲和性 |
| `elasticsearch.podAnnotations` | `{}` | Pod 自定义注解 |
| `elasticsearch.podLabels` | `{}` | Pod 自定义标签 |
| `elasticsearch.extraEnvs` | `[]` | 额外环境变量 (EnvVar 列表) |
| `elasticsearch.esConfig` | `{}` | elasticsearch.yml 自定义配置 (键值对) |
| `elasticsearch.keystore` | `[]` | Keystore 引用的 Secret 列表 |
| `elasticsearch.protocol` | `https` | 协议 (http / https) |
| `elasticsearch.securityContext` | 见 values | 容器级安全上下文 |
| `elasticsearch.fsGroup` | `1000` | Pod 级 fsGroup，确保数据目录写权限 |
| `elasticsearch.readinessProbe.failureThreshold` | `3` | Readiness 失败阈值 |
| `elasticsearch.readinessProbe.initialDelaySeconds` | `10` | Readiness 初始延迟 |
| `elasticsearch.readinessProbe.periodSeconds` | `10` | Readiness 检测周期 |
| `elasticsearch.readinessProbe.successThreshold` | `3` | Readiness 成功阈值 |
| `elasticsearch.readinessProbe.timeoutSeconds` | `5` | Readiness 超时 |
| `elasticsearch.livenessProbe.failureThreshold` | `3` | Liveness 失败阈值 |
| `elasticsearch.livenessProbe.initialDelaySeconds` | `30` | Liveness 初始延迟 |
| `elasticsearch.livenessProbe.periodSeconds` | `10` | Liveness 检测周期 |
| `elasticsearch.livenessProbe.successThreshold` | `1` | Liveness 成功阈值 |
| `elasticsearch.livenessProbe.timeoutSeconds` | `5` | Liveness 超时 |
| `elasticsearch.startupProbe.enabled` | `false` | 是否启用 Startup 探针 |
| `elasticsearch.startupProbe.failureThreshold` | `30` | Startup 失败阈值 |
| `elasticsearch.startupProbe.initialDelaySeconds` | `0` | Startup 初始延迟 |
| `elasticsearch.startupProbe.periodSeconds` | `10` | Startup 检测周期 |
| `elasticsearch.startupProbe.successThreshold` | `1` | Startup 成功阈值 |
| `elasticsearch.startupProbe.timeoutSeconds` | `5` | Startup 超时 |
| `elasticsearch.ingress.enabled` | `false` | 是否启用 Ingress |
| `elasticsearch.ingress.annotations` | `{}` | Ingress 注解 |
| `elasticsearch.ingress.hosts` | `[]` | Ingress 主机规则 |
| `elasticsearch.ingress.tls` | `[]` | Ingress TLS 配置 |
| `elasticsearch.secretsKeystoreEnabled` | `false` | 是否启用 Secrets Keystore 自动挂载 |

## 测试/生产推荐配置

### 测试环境

```yaml
elasticsearch:
  clusterName: es-test
  replicas: 1
  esJavaOpts: "-Xms512m -Xmx512m"
  resources:
    requests:
      cpu: 250m
      memory: 512Mi
    limits:
      cpu: "1"
      memory: 1Gi
  persistence:
    enabled: false
  roles:
    master: true
    data: true
    ingest: true
    ml: false
  protocol: http
  startupProbe:
    enabled: true
    failureThreshold: 30
```

### 生产环境

```yaml
elasticsearch:
  clusterName: es-prod
  nodeGroup: master
  replicas: 3
  esJavaOpts: "-Xms4g -Xmx4g"
  resources:
    requests:
      cpu: "1"
      memory: 4Gi
    limits:
      cpu: "4"
      memory: 8Gi
  persistence:
    enabled: true
    volumeClaimTemplate:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 100Gi
      storageClassName: ssd
  roles:
    master: true
    data: true
    ingest: true
    ml: false
  service:
    type: ClusterIP
    ports:
      http: 9200
      transport: 9300
  protocol: https
  fsGroup: 1000
  readinessProbe:
    failureThreshold: 3
    initialDelaySeconds: 10
    periodSeconds: 10
    successThreshold: 3
    timeoutSeconds: 5
  livenessProbe:
    failureThreshold: 3
    initialDelaySeconds: 60
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 5
  startupProbe:
    enabled: true
    failureThreshold: 30
    initialDelaySeconds: 0
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 5
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
                    - elasticsearch
            topologyKey: kubernetes.io/hostname
  esConfig:
    elasticsearch.yml: |
      xpack.security.enabled: true
      xpack.security.transport.ssl.enabled: true
  keystore:
    - secretName: es-credentials
  secretsKeystoreEnabled: true
```

> 生产环境建议分离 master 与 data 节点组，分别部署多套 Release，通过 `masterService` 互相引用。详见 [Elastic Elasticsearch Chart](https://github.com/elastic/helm-charts/tree/main/elasticsearch)。
