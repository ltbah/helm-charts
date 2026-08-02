# Helm Charts

集中管理 Java 开发常用中间件的 Helm Charts 仓库。

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

## 分类说明

### Infrastructure Wrapper Chart

通过 `dependencies` 引用官方 Helm 仓库的 Chart，提供 Java 开发场景的默认配置。

| 服务 | 官方仓库 | Chart |
|------|---------|-------|
| MySQL | Bitnami | mysql |
| PostgreSQL | Bitnami | postgresql |
| MongoDB | Bitnami | mongodb |
| Redis | Bitnami | redis |
| Kafka | Bitnami | kafka |
| ZooKeeper | Bitnami | zookeeper |
| MinIO | MinIO Operator | operator + tenant |
| Elasticsearch | Elastic | elasticsearch |
| Kibana | Elastic | kibana |
| Logstash | Elastic | logstash |
| Filebeat | Elastic | filebeat |
| Prometheus | Prometheus Community | prometheus |
| Grafana | Grafana | grafana |
| SkyWalking | Apache | skywalking |
| Zipkin | Zipkin | zipkin |
| Higress | Higress | higress |

### Sourced Chart

从项目源码仓库拷贝的 Helm Chart，适用于有 Chart 但无独立 Helm 仓库的项目。

- **Seata** — 来自 `incubator-seata-k8s`
- **Nacos** — 来自 `nacos-k8s`
- **RocketMQ Operator** — 来自 `rocketmq-operator`
- **OpenSandbox** — 来自 `OpenSandbox`

### Custom Chart

完全自定义编写的 Helm Chart。

- **XXL-JOB** — 分布式任务调度平台
- **PowerJob** — 分布式计算与任务调度框架

## 使用方式

### 添加仓库

```bash
helm repo add ltbah https://ltbah.github.io/helm-charts/
helm repo update
```

### 安装 Chart

```bash
# 安装 MySQL
helm install my-mysql ltbah/mysql

# 安装 Redis
helm install my-redis ltbah/redis

# 安装 XXL-JOB
helm install my-xxl-job ltbah/xxl-job
```

### 自定义配置

```bash
# 查看默认值
helm show values ltbah/mysql

# 使用自定义配置安装
helm install my-mysql ltbah/mysql -f my-values.yaml
```

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
