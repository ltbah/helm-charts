# PostgreSQL Wrapper Chart

Wrapper Chart for [Bitnami PostgreSQL](https://github.com/bitnami/charts/tree/main/bitnami/postgresql)，提供 Java 开发场景的默认配置。

## 默认配置

- 默认数据库: `appdb`
- 持久化存储: 8Gi
- 资源限制: CPU 1核 / 内存 1Gi

## 安装

```bash
helm install my-postgresql ltbah/postgresql
```

## 自定义配置

```bash
helm install my-postgresql ltbah/postgresql \
  --set postgresql.auth.postgresPassword=yourpassword \
  --set postgresql.auth.database=mydb
```

## 更多配置

详见 [Bitnami PostgreSQL Chart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql)
