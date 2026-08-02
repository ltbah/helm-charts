# PowerJob Helm Chart

[PowerJob](https://github.com/PowerJob/PowerJob) 分布式计算与任务调度框架。

## 默认配置

- 副本数: 1
- 数据库: PostgreSQL（内置，5Gi）
- 缓存: Redis（内置，1Gi）
- JVM: -Xms1g -Xmx1g
- 资源限制: CPU 2核 / 内存 2Gi

## 安装

```bash
# 使用内置 PostgreSQL + Redis
helm install my-powerjob ltbah/powerjob

# 使用 MySQL
helm install my-powerjob ltbah/powerjob \
  --set params.dbType=mysql \
  --set postgresql.enabled=false \
  --set params.mysql.host=external-mysql \
  --set params.mysql.port=3306 \
  --set params.mysql.username=powerjob \
  --set params.mysql.password=yourpassword
```

## 使用外部数据库和缓存

```bash
helm install my-powerjob ltbah/powerjob \
  --set postgresql.enabled=false \
  --set redis.enabled=false \
  --set params.postgresql.host=external-pg \
  --set params.postgresql.password=yourpassword \
  --set params.redis.host=external-redis \
  --set params.redis.password=yourpassword
```

## 默认登录

- 用户名: admin
- 密码: powerjob

## 配置邮件告警

```bash
helm install my-powerjob ltbah/powerjob \
  --set params.mail.enabled=true \
  --set params.mail.host=smtp.example.com \
  --set params.mail.port=465 \
  --set params.mail.username=alert@example.com \
  --set params.mail.password=yourpassword
```
