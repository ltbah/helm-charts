# Grafana Wrapper Chart

Wrapper Chart for [Grafana](https://github.com/grafana/helm-charts/tree/main/charts/grafana)，提供数据可视化和仪表盘的默认配置。

## 默认配置

- 管理员密码: admin
- 持久化存储: 5Gi
- 默认数据源: Prometheus

## 安装

```bash
helm install my-grafana ltbah/grafana
```

## 自定义管理员密码

```bash
helm install my-grafana ltbah/grafana \
  --set grafana.adminPassword=yourpassword
```

## 更多配置

详见 [Grafana Chart](https://github.com/grafana/helm-charts/tree/main/charts/grafana)
