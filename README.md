# Helm Charts

集中管理 Java 开发常用中间件的 Helm Charts 仓库，通过 GitHub Pages 托管。

## 仓库结构

```
charts/
├── infrastructure/    # 有官方仓库，wrapper Chart
│   ├── mysql/
│   ├── postgresql/
│   ├── mongodb/
│   ├── redis/
│   ├── kafka/
│   ├── zookeeper/
│   ├── minio/
│   ├── elasticsearch/
│   ├── kibana/
│   ├── logstash/
│   ├── filebeat/
│   ├── prometheus/
│   ├── grafana/
│   ├── skywalking/
│   ├── zipkin/
│   └── higress/
├── sourced/           # 从源码拷贝整合（有 Chart 但无独立仓库）
│   ├── seata/
│   ├── nacos/
│   ├── rocketmq-operator/
│   └── opensandbox/
└── custom/            # 完全自定义编写（无任何 Chart）
    ├── xxl-job/
    └── powerjob/
```

## 使用方式

### 添加仓库

```bash
helm repo add ltbah https://ltbah.github.io/helm-charts/
helm repo update
```

### 搜索 Chart

```bash
helm search repo ltbah
```

### 安装 Chart

所有 Chart 都支持通过 `--set` 参数注入配置，无需修改文件。每个 Chart 的 README 中都提供了：

- **最简安装**：只填必填参数，其余取默认值
- **最全配置安装**：列出所有可配置参数及注释
- **测试环境推荐**：最小资源
- **生产环境推荐**：高可用 + 监控 + 安全

```bash
# 示例：安装 MySQL（最简）
helm install my-mysql ltbah/mysql \
  --set mysql.auth.rootPassword=yourpassword \
  --set mysql.auth.password=yourpassword

# 示例：安装 MySQL（生产）
helm install my-mysql ltbah/mysql \
  --set mysql.architecture=replication \
  --set mysql.auth.rootPassword=<STRONG_PASSWORD> \
  --set mysql.auth.password=<STRONG_PASSWORD> \
  --set mysql.auth.replicationPassword=<STRONG_PASSWORD> \
  --set mysql.primary.persistence.size=50Gi \
  --set mysql.primary.resources.requests.cpu=500m \
  --set mysql.primary.resources.requests.memory=1Gi \
  --set mysql.metrics.enabled=true
```

### 查看默认值

```bash
helm show values ltbah/mysql
```

## Chart 分类

### Infrastructure Wrapper Chart

通过 `dependencies` 引用官方 Helm 仓库，提供经过优化的默认配置和完整的参数注入支持。

| 服务 | 上游仓库 | Chart | 必填参数 |
|------|---------|-------|---------|
| MySQL | Bitnami | mysql | `auth.rootPassword`, `auth.password` |
| PostgreSQL | Bitnami | postgresql | `auth.postgresPassword`, `auth.password` |
| MongoDB | Bitnami | mongodb | `auth.rootPassword`, `auth.password` |
| Redis | Bitnami | redis | `auth.password` |
| Kafka | Bitnami | kafka | - |
| ZooKeeper | Bitnami | zookeeper | - |
| MinIO | MinIO | operator + tenant | `tenant.secrets.accessKey`, `tenant.secrets.secretKey` |
| Elasticsearch | Elastic | elasticsearch | - |
| Kibana | Elastic | kibana | - |
| Logstash | Elastic | logstash | - |
| Filebeat | Elastic | filebeat | - |
| Prometheus | Prometheus Community | prometheus | - |
| Grafana | Grafana | grafana | `adminPassword` |
| SkyWalking | Apache | skywalking | - |
| Zipkin | OpenZipkin | zipkin | - |
| Higress | Higress | higress | - |

### Sourced Chart

从项目源码仓库拷贝的 Helm Chart，适用于有 Chart 但无独立 Helm 仓库的项目。

| 服务 | 来源 | 说明 |
|------|------|------|
| Seata | incubator-seata-k8s | 分布式事务 |
| Nacos | nacos-k8s | 动态命名与配置服务 |
| RocketMQ Operator | rocketmq-operator | 消息队列 Operator |
| OpenSandbox | OpenSandbox | 在线代码沙箱 |

### Custom Chart

完全自定义编写的 Helm Chart，适用于没有任何 Helm Chart 的项目。

| 服务 | 镜像 | 必填参数 |
|------|------|---------|
| XXL-JOB | xuxueli/xxl-job-admin | `params.jdbcPassword`（使用内置 MySQL 时无需指定） |
| PowerJob | powerjob/powerjob-server | -（使用内置 PostgreSQL + Redis 时无需指定） |

## 开发

### 更新依赖

```bash
helm dependency update charts/infrastructure/mysql
```

### Lint 检查

```bash
helm lint charts/infrastructure/mysql
```

### 打包

```bash
helm package charts/infrastructure/mysql
```
