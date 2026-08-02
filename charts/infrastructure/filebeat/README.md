# Filebeat Wrapper Chart

Wrapper Chart for [Elastic Filebeat](https://github.com/elastic/helm-charts/tree/main/filebeat)，提供日志采集的默认配置。

## 默认配置

- 默认采集: /var/log/*.log
- 默认输出: Logstash (logstash:8080)
- 资源限制: CPU 500m / 内存 512Mi

## 安装

```bash
helm install my-filebeat ltbah/filebeat
```

## 直接输出到 Elasticsearch

```bash
helm install my-filebeat ltbah/filebeat \
  --set-file filebeat.filebeatConfig.filebeat.yml=custom-filebeat.yml
```

## 更多配置

详见 [Elastic Filebeat Chart](https://github.com/elastic/helm-charts/tree/main/filebeat)
