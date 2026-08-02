# Kafka Wrapper Chart

Wrapper Chart for [Bitnami Kafka](https://github.com/bitnami/charts/tree/main/bitnami/kafka)，提供 Java 开发场景的默认配置。

## 默认配置

- KRaft 模式（无需 ZooKeeper）
- Controller + Broker 各 3 副本
- 持久化存储: 8Gi
- 资源限制: CPU 1核 / 内存 1Gi

## 安装

```bash
helm install my-kafka ltbah/kafka
```

## 单节点模式

```bash
helm install my-kafka ltbah/kafka \
  --set kafka.controller.replicaCount=1 \
  --set kafka.broker.replicaCount=0
```

## 更多配置

详见 [Bitnami Kafka Chart](https://github.com/bitnami/charts/tree/main/bitnami/kafka)
