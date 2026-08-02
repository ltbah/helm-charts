# Redis Wrapper Chart

Wrapper Chart for [Bitnami Redis](https://github.com/bitnami/charts/tree/main/bitnami/redis)，提供 Java 开发场景的默认配置。

## 默认配置

- 架构: standalone
- 持久化存储: 4Gi
- 资源限制: CPU 500m / 内存 512Mi

## 安装

```bash
helm install my-redis ltbah/redis
```

## 集群模式

```bash
helm install my-redis ltbah/redis \
  --set redis.architecture=replication \
  --set redis.replica.replicaCount=3
```

## 更多配置

详见 [Bitnami Redis Chart](https://github.com/bitnami/charts/tree/main/bitnami/redis)
