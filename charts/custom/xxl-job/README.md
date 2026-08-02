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
