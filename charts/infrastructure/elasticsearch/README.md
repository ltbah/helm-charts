# Elasticsearch Wrapper Chart

Wrapper Chart for [Elastic Elasticsearch](https://github.com/elastic/helm-charts/tree/main/elasticsearch)，提供日志存储和搜索的默认配置。

## 默认配置

- 副本数: 3
- 持久化存储: 30Gi
- JVM 堆内存: 2g
- 资源限制: CPU 2核 / 内存 4Gi

## 安装

```bash
helm install my-elasticsearch ltbah/elasticsearch
```

## 单节点模式

```bash
helm install my-elasticsearch ltbah/elasticsearch \
  --set elasticsearch.replicas=1
```

## 更多配置

详见 [Elastic Elasticsearch Chart](https://github.com/elastic/helm-charts/tree/main/elasticsearch)
