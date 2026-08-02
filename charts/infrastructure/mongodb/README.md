# MongoDB Wrapper Chart

Wrapper Chart for [Bitnami MongoDB](https://github.com/bitnami/charts/tree/main/bitnami/mongodb)，提供 Java 开发场景的默认配置。

## 默认配置

- 默认数据库: `appdb`
- 持久化存储: 8Gi
- 资源限制: CPU 1核 / 内存 1Gi

## 安装

```bash
helm install my-mongodb ltbah/mongodb
```

## 自定义配置

```bash
helm install my-mongodb ltbah/mongodb \
  --set mongodb.auth.rootPassword=yourpassword \
  --set mongodb.auth.database=mydb
```

## 更多配置

详见 [Bitnami MongoDB Chart](https://github.com/bitnami/charts/tree/main/bitnami/mongodb)
