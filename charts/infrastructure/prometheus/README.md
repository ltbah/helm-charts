# Prometheus Wrapper Chart

Wrapper Chart for [Prometheus Community](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus)，提供监控告警的默认配置。

## 默认配置

- 数据保留: 15天
- 持久化存储: 10Gi
- 启用 Alertmanager, Pushgateway, Node Exporter, kube-state-metrics

## 安装

```bash
helm install my-prometheus ltbah/prometheus
```

## 自定义保留时间

```bash
helm install my-prometheus ltbah/prometheus \
  --set prometheus.server.retention="30d"
```

## 更多配置

详见 [Prometheus Community Chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus)
