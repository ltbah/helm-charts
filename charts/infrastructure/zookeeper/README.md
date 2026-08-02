# ZooKeeper Wrapper Chart

Wrapper Chart for [Bitnami ZooKeeper](https://github.com/bitnami/charts/tree/main/bitnami/zookeeper)，提供 Java 开发场景的默认配置。

## 默认配置

- 副本数: 3
- 持久化存储: 4Gi
- 资源限制: CPU 1核 / 内存 512Mi

## 安装

```bash
helm install my-zookeeper ltbah/zookeeper
```

## 单节点模式

```bash
helm install my-zookeeper ltbah/zookeeper \
  --set zookeeper.replicaCount=1
```

## 更多配置

详见 [Bitnami ZooKeeper Chart](https://github.com/bitnami/charts/tree/main/bitnami/zookeeper)
