# MySQL Wrapper Chart

Wrapper Chart for [Bitnami MySQL](https://github.com/bitnami/charts/tree/main/bitnami/mysql)，提供 Java 开发场景的默认配置。

## 默认配置

- 字符集: `utf8mb4`
- 默认数据库: `appdb`
- 持久化存储: 8Gi
- 资源限制: CPU 1核 / 内存 1Gi

## 安装

```bash
helm install my-mysql ltbah/mysql
```

## 自定义配置

```bash
helm install my-mysql ltbah/mysql \
  --set mysql.auth.rootPassword=yourpassword \
  --set mysql.auth.database=mydb
```

## 更多配置

详见 [Bitnami MySQL Chart](https://github.com/bitnami/charts/tree/main/bitnami/mysql)
