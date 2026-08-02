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

## 配置 Ingress

### 使用 Higress Ingress

```bash
helm install my-powerjob ltbah/powerjob \
  --set ingress.enabled=true \
  --set ingress.className=higress \
  --set ingress.domainSuffix=example.com
```

### 使用 Nginx Ingress

```bash
helm install my-powerjob ltbah/powerjob \
  --set ingress.enabled=true \
  --set ingress.className=nginx \
  --set ingress.domainSuffix=example.com
```

### 使用自定义域名

```bash
helm install my-powerjob ltbah/powerjob \
  --set ingress.enabled=true \
  --set ingress.className=nginx \
  --set ingress.host=powerjob.mycompany.com
```

## 配置自定义镜像版本

```bash
helm install my-powerjob ltbah/powerjob \
  --set image.tag=4.3.8 \
  --set image.pullPolicy=Always
```

## 参数

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `replicaCount` | 副本数 | `1` |
| `image.repository` | 镜像仓库 | `powerjob/powerjob-server` |
| `image.tag` | 镜像版本 | `4.3.9` |
| `image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |
| `ingress.enabled` | 是否启用 Ingress | `false` |
| `ingress.className` | Ingress 类名（higress, nginx 等） | `""` |
| `ingress.domainSuffix` | 域名后缀 | `""` |
| `ingress.host` | 自定义域名（优先级高于 domainSuffix） | `""` |
| `ingress.annotations` | Ingress 注解 | `{}` |
| `ingress.tls` | TLS 配置 | `[]` |
| `service.type` | 服务类型 | `ClusterIP` |
| `service.ports.http` | HTTP 端口 | `7700` |
| `service.ports.akka` | Akka 端口 | `10086` |
| `params.dbType` | 数据库类型（postgresql / mysql） | `"postgresql"` |
| `params.postgresql.host` | PostgreSQL 主机 | `""` |
| `params.postgresql.password` | PostgreSQL 密码 | `"powerjob"` |
| `params.redis.host` | Redis 主机 | `""` |
| `params.redis.password` | Redis 密码 | `""` |
| `postgresql.enabled` | 是否启用内置 PostgreSQL | `true` |
| `redis.enabled` | 是否启用内置 Redis | `true` |
| `resources.limits.cpu` | CPU 限制 | `"2"` |
| `resources.limits.memory` | 内存限制 | `2Gi` |
