# SkyWalking Wrapper Chart

Wrapper Chart for [Apache SkyWalking](https://github.com/apache/skywalking-helm)，提供分布式追踪和 APM 的默认配置。

## 默认配置

- OAP Server 2 副本
- 存储: Elasticsearch
- UI 1 副本

## 安装

```bash
helm install my-skywalking ltbah/skywalking
```

## 自定义 Elasticsearch 地址

```bash
helm install my-skywalking ltbah/skywalking \
  --set skywalking.oap.storage.elasticsearch.hosts="http://my-es:9200"
```

## 更多配置

详见 [Apache SkyWalking Chart](https://github.com/apache/skywalking-helm)
