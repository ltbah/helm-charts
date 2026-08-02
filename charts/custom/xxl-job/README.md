# XXL-JOB Helm Chart

[XXL-JOB](https://github.com/xuxueli/xxl-job) 分布式任务调度平台。

## 默认配置

- 副本数: 1
- 内置 MySQL: 启用（5Gi）
- 资源限制: CPU 1核 / 内存 1Gi
- 日志保留: 30天

## 安装

```bash
# 使用内置 MySQL
helm install my-xxl-job ltbah/xxl-job

# 使用外部 MySQL
helm install my-xxl-job ltbah/xxl-job \
  --set mysql.enabled=false \
  --set params.jdbcUrl="jdbc:mysql://external-mysql:3306/xxl_job?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai" \
  --set params.jdbcUsername=xxljob \
  --set params.jdbcPassword=yourpassword
```

## 默认登录

- 用户名: admin
- 密码: 123456

## 配置邮件告警

```bash
helm install my-xxl-job ltbah/xxl-job \
  --set params.mailHost=smtp.example.com \
  --set params.mailPort=465 \
  --set params.mailUsername=alert@example.com \
  --set params.mailPassword=yourpassword \
  --set params.mailSsl=true \
  --set params.mailFrom=alert@example.com
```

## 配置访问令牌

```bash
helm install my-xxl-job ltbah/xxl-job \
  --set params.accessToken=your-token
```

## 配置 Ingress

### 使用 Higress Ingress

```bash
helm install my-xxl-job ltbah/xxl-job \
  --set ingress.enabled=true \
  --set ingress.className=higress \
  --set ingress.domainSuffix=example.com
```

### 使用 Nginx Ingress

```bash
helm install my-xxl-job ltbah/xxl-job \
  --set ingress.enabled=true \
  --set ingress.className=nginx \
  --set ingress.domainSuffix=example.com
```

### 使用自定义域名

```bash
helm install my-xxl-job ltbah/xxl-job \
  --set ingress.enabled=true \
  --set ingress.className=nginx \
  --set ingress.host=xxl-job.mycompany.com
```

## 配置自定义镜像版本

```bash
helm install my-xxl-job ltbah/xxl-job \
  --set image.tag=2.4.1 \
  --set image.pullPolicy=Always
```

## 参数

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `replicaCount` | 副本数 | `1` |
| `image.repository` | 镜像仓库 | `xuxueli/xxl-job-admin` |
| `image.tag` | 镜像版本 | `2.4.2` |
| `image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |
| `ingress.enabled` | 是否启用 Ingress | `false` |
| `ingress.className` | Ingress 类名（higress, nginx 等） | `""` |
| `ingress.domainSuffix` | 域名后缀 | `""` |
| `ingress.host` | 自定义域名（优先级高于 domainSuffix） | `""` |
| `ingress.annotations` | Ingress 注解 | `{}` |
| `ingress.tls` | TLS 配置 | `[]` |
| `service.type` | 服务类型 | `ClusterIP` |
| `service.port` | 服务端口 | `8080` |
| `params.jdbcUrl` | JDBC 连接地址 | `""` |
| `params.jdbcUsername` | 数据库用户名 | `xxljob` |
| `params.jdbcPassword` | 数据库密码 | `""` |
| `params.accessToken` | 访问令牌 | `""` |
| `params.logretentiondays` | 日志保留天数 | `"30"` |
| `mysql.enabled` | 是否启用内置 MySQL | `true` |
| `resources.limits.cpu` | CPU 限制 | `"1"` |
| `resources.limits.memory` | 内存限制 | `1Gi` |
