# Kibana Wrapper Chart

Wrapper Chart for [Elastic Kibana](https://github.com/elastic/helm-charts/tree/main/kibana)，提供 Elasticsearch 可视化的默认配置。

## 默认配置

- 副本数: 1
- 资源限制: CPU 1核 / 内存 1Gi
- 默认连接: https://elasticsearch:9200

## 安装

```bash
helm install my-kibana ltbah/kibana
```

## 指定 Elasticsearch 地址

```bash
helm install my-kibana ltbah/kibana \
  --set kibana.elasticsearchHosts="https://my-es:9200"
```

## 更多配置

详见 [Elastic Kibana Chart](https://github.com/elastic/helm-charts/tree/main/kibana)
