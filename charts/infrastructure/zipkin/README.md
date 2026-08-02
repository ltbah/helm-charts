# Zipkin Wrapper Chart

Wrapper Chart for [Zipkin](https://github.com/openzipkin/zipkin-helm)，提供分布式追踪的默认配置。

## 默认配置

- 副本数: 1
- 存储: 内存
- 资源限制: CPU 500m / 内存 512Mi

## 安装

```bash
helm install my-zipkin ltbah/zipkin
```

## 使用 Elasticsearch 存储

```bash
helm install my-zipkin ltbah/zipkin \
  --set zipkin.storage.type=elasticsearch \
  --set zipkin.storage.elasticsearch.hosts=elasticsearch:9200
```

## 更多配置

详见 [Zipkin Chart](https://github.com/openzipkin/zipkin-helm)
