# MinIO Wrapper Chart

Wrapper Chart for [MinIO Operator](https://min.io/docs/minio/kubernetes/upstream/)，提供对象存储服务的默认配置。

## 默认配置

- Operator 2 副本
- Tenant 4 Server, 每个 10Gi
- 默认 accessKey/secretKey: minioadmin/minioadmin

## 安装

```bash
helm install my-minio ltbah/minio
```

## 仅安装 Operator

```bash
helm install my-minio ltbah/minio \
  --set tenant.enabled=false
```

## 更多配置

详见 [MinIO Operator Helm Chart](https://min.io/docs/minio/kubernetes/upstream/)
