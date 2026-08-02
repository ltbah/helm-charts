# Kafka Wrapper Chart

Wrapper Chart for [Bitnami Kafka](https://github.com/bitnami/charts/tree/main/bitnami/kafka)，提供 Java 开发场景的默认配置。

## 最简安装

```bash
helm install my-kafka ltbah/kafka
```

默认以 KRaft 模式启动 3 Controller + 3 Broker 集群，无需 ZooKeeper。

## 最全配置安装

```bash
helm install my-kafka ltbah/kafka \
  --set kafka.kraft.enabled=true \
  --set kafka.listeners.client.protocol=PLAINTEXT \
  --set kafka.listeners.interbroker.protocol=PLAINTEXT \
  --set kafka.listeners.controller.protocol=PLAINTEXT \
  --set kafka.controller.replicaCount=3 \
  --set kafka.controller.persistence.enabled=true \
  --set kafka.controller.persistence.size=20Gi \
  --set kafka.controller.persistence.storageClassName=standard \
  --set kafka.controller.resources.requests.cpu=500m \
  --set kafka.controller.resources.requests.memory=1Gi \
  --set kafka.controller.resources.limits.cpu=2 \
  --set kafka.controller.resources.limits.memory=4Gi \
  --set kafka.controller.nodeSelector.role=controller \
  --set 'kafka.controller.tolerations[0].key=dedicated' \
  --set 'kafka.controller.tolerations[0].operator=Equal' \
  --set 'kafka.controller.tolerations[0].value=kafka' \
  --set 'kafka.controller.tolerations[0].effect=NoSchedule' \
  --set kafka.controller.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchLabels.app=kafka \
  --set kafka.broker.replicaCount=3 \
  --set kafka.broker.persistence.enabled=true \
  --set kafka.broker.persistence.size=20Gi \
  --set kafka.broker.persistence.storageClassName=standard \
  --set kafka.broker.resources.requests.cpu=500m \
  --set kafka.broker.resources.requests.memory=1Gi \
  --set kafka.broker.resources.limits.cpu=2 \
  --set kafka.broker.resources.limits.memory=4Gi \
  --set kafka.broker.nodeSelector.role=broker \
  --set kafka.service.type=ClusterIP \
  --set kafka.service.ports.client=9092 \
  --set kafka.service.ports.interbroker=9093 \
  --set kafka.service.ports.controller=9094 \
  --set kafka.metrics.enabled=true \
  --set kafka.metrics.jmx.enabled=true \
  --set kafka.tls.enabled=true \
  --set kafka.tls.certificatesSecret=kafka-tls \
  --set kafka.extraConfig="log.retention.hours=168\nnum.partitions=6" \
  --set kafka.logPersistence.enabled=true \
  --set kafka.logPersistence.size=10Gi \
  --set kafka.volumePermissions.enabled=true
```

## 必填参数

| 参数 | 说明 |
|------|------|
| 无 | 默认配置即可启动最简集群 |

> 如启用 TLS，需提前创建包含证书的 Secret 并设置 `kafka.tls.certificatesSecret`。

## 参数列表

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `kafka.image.repository` | 镜像仓库地址，空值使用上游默认 | `""` |
| `kafka.image.tag` | 镜像标签，空值使用上游默认（跟随 appVersion） | `""` |
| `kafka.image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |
| `kafka.kraft.enabled` | 启用 KRaft 模式（无需 ZooKeeper） | `true` |
| `kafka.listeners.client.protocol` | 客户端监听协议 | `PLAINTEXT` |
| `kafka.listeners.interbroker.protocol` | Broker 间通信协议 | `PLAINTEXT` |
| `kafka.listeners.controller.protocol` | Controller 通信协议 | `PLAINTEXT` |
| `kafka.controller.replicaCount` | Controller 副本数 | `3` |
| `kafka.controller.persistence.enabled` | Controller 持久化 | `true` |
| `kafka.controller.persistence.size` | Controller 存储大小 | `8Gi` |
| `kafka.controller.persistence.storageClassName` | Controller 存储类 | `""` |
| `kafka.controller.resources.requests.cpu` | Controller CPU 请求 | `250m` |
| `kafka.controller.resources.requests.memory` | Controller 内存请求 | `512Mi` |
| `kafka.controller.resources.limits.cpu` | CPU 限制 | `"1"` |
| `kafka.controller.resources.limits.memory` | 内存限制 | `1Gi` |
| `kafka.controller.nodeSelector` | Controller 节点选择器 | `{}` |
| `kafka.controller.tolerations` | Controller 容忍度 | `[]` |
| `kafka.controller.affinity` | Controller 亲和性 | `{}` |
| `kafka.controller.extraEnvVars` | Controller 额外环境变量 | `[]` |
| `kafka.broker.replicaCount` | Broker 副本数 | `3` |
| `kafka.broker.persistence.enabled` | Broker 持久化 | `true` |
| `kafka.broker.persistence.size` | Broker 存储大小 | `8Gi` |
| `kafka.broker.persistence.storageClassName` | Broker 存储类 | `""` |
| `kafka.broker.resources.requests.cpu` | Broker CPU 请求 | `250m` |
| `kafka.broker.resources.requests.memory` | Broker 内存请求 | `512Mi` |
| `kafka.broker.resources.limits.cpu` | CPU 限制 | `"1"` |
| `kafka.broker.resources.limits.memory` | 内存限制 | `1Gi` |
| `kafka.broker.nodeSelector` | Broker 节点选择器 | `{}` |
| `kafka.broker.tolerations` | Broker 容忍度 | `[]` |
| `kafka.broker.affinity` | Broker 亲和性 | `{}` |
| `kafka.service.type` | Service 类型 | `ClusterIP` |
| `kafka.service.ports.client` | 客户端端口 | `9092` |
| `kafka.service.ports.interbroker` | Broker 间端口 | `9093` |
| `kafka.service.ports.controller` | Controller 端口 | `9094` |
| `kafka.metrics.enabled` | 启用 Kafka Exporter | `false` |
| `kafka.metrics.jmx.enabled` | 启用 JMX 指标采集 | `false` |
| `kafka.tls.enabled` | 启用 TLS 加密 | `false` |
| `kafka.tls.certificatesSecret` | TLS 证书 Secret 名称 | `""` |
| `kafka.ingress.enabled` | 是否启用 Ingress | `false` |
| `kafka.ingress.className` | Ingress 类名，使用 Higress 时设为 "higress" | `"higress"` |
| `kafka.ingress.domainSuffix` | 域名后缀，最终域名格式: {release-name}-{service}.{domainSuffix} | `""` |
| `kafka.ingress.host` | 自定义域名（优先级高于 domainSuffix） | `""` |
| `kafka.ingress.tls.enabled` | 是否启用 TLS | `false` |
| `kafka.ingress.tls.secretName` | TLS 证书 Secret 名称 | `""` |
| `kafka.ingress.annotations` | Ingress 注解 | `{}` |
| `kafka.extraConfig` | 额外 Kafka 配置 | `""` |
| `kafka.logPersistence.enabled` | 日志持久化 | `false` |
| `kafka.logPersistence.size` | 日志存储大小 | `8Gi` |
| `kafka.logPersistence.storageClassName` | 日志存储类 | `""` |
| `kafka.interBrokerProtocolVersion` | Inter-Broker 协议版本 | `""` |
| `kafka.zookeeper.enabled` | 启用 ZooKeeper（非 KRaft 模式） | `false` |
| `kafka.zookeeper.persistence.enabled` | ZooKeeper 持久化 | `true` |
| `kafka.zookeeper.persistence.size` | ZooKeeper 存储大小 | `8Gi` |
| `kafka.zookeeper.persistence.storageClassName` | ZooKeeper 存储类 | `""` |
| `kafka.zookeeper.resources.requests.cpu` | ZooKeeper CPU 请求 | `250m` |
| `kafka.zookeeper.resources.requests.memory` | ZooKeeper 内存请求 | `256Mi` |
| `kafka.zookeeper.resources.limits.cpu` | CPU 限制 | `"1"` |
| `kafka.zookeeper.resources.limits.memory` | 内存限制 | `512Mi` |
| `kafka.volumePermissions.enabled` | 启用卷权限初始化 | `false` |

## 测试推荐配置

```bash
helm install my-kafka ltbah/kafka \
  --set kafka.controller.replicaCount=1 \
  --set kafka.broker.replicaCount=0 \
  --set kafka.controller.persistence.size=4Gi \
  --set kafka.controller.resources.requests.cpu=100m \
  --set kafka.controller.resources.requests.memory=256Mi \
  --set kafka.controller.resources.limits.cpu=500m \
  --set kafka.controller.resources.limits.memory=512Mi
```

单节点 Combined 模式（Controller + Broker 合一），资源占用最小，适合本地开发与功能测试。

## 生产推荐配置

```bash
helm install my-kafka ltbah/kafka \
  --set kafka.controller.replicaCount=3 \
  --set kafka.broker.replicaCount=3 \
  --set kafka.controller.persistence.size=50Gi \
  --set kafka.controller.persistence.storageClassName=fast-ssd \
  --set kafka.controller.resources.requests.cpu=1 \
  --set kafka.controller.resources.requests.memory=2Gi \
  --set kafka.controller.resources.limits.cpu=4 \
  --set kafka.controller.resources.limits.memory=8Gi \
  --set kafka.broker.persistence.size=100Gi \
  --set kafka.broker.persistence.storageClassName=fast-ssd \
  --set kafka.broker.resources.requests.cpu=1 \
  --set kafka.broker.resources.requests.memory=2Gi \
  --set kafka.broker.resources.limits.cpu=4 \
  --set kafka.broker.resources.limits.memory=8Gi \
  --set kafka.metrics.enabled=true \
  --set kafka.metrics.jmx.enabled=true \
  --set kafka.tls.enabled=true \
  --set kafka.tls.certificatesSecret=kafka-tls \
  --set kafka.logPersistence.enabled=true \
  --set kafka.logPersistence.size=20Gi \
  --set kafka.logPersistence.storageClassName=fast-ssd \
  --set kafka.volumePermissions.enabled=true \
  --set 'kafka.controller.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchLabels.app-kubernetes.io/component=controller' \
  --set 'kafka.controller.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].topologyKey=kubernetes.io/hostname' \
  --set 'kafka.broker.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchLabels.app-kubernetes.io/component=broker' \
  --set 'kafka.broker.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].topologyKey=kubernetes.io/hostname'
```

3 Controller + 3 Broker 分离部署，SSD 存储、TLS 加密、JMX + Exporter 监控全开，Pod 反亲和保证高可用。

### 通过 Higress 网关暴露服务

```bash
# 通过 Higress 网关暴露服务
helm install my-kafka ltbah/kafka \
  --set kafka.ingress.enabled=true \
  --set kafka.ingress.className=higress \
  --set kafka.ingress.domainSuffix=example.com
```

如需 TLS：
```bash
  --set kafka.ingress.tls.enabled=true \
  --set kafka.ingress.tls.secretName=kafka-tls
```

## 更多配置

详见 [Bitnami Kafka Chart](https://github.com/bitnami/charts/tree/main/bitnami/kafka)
