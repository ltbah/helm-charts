# Logstash Wrapper Chart

Wrapper Chart for [Elastic Logstash](https://github.com/elastic/helm-charts/tree/main/logstash)，提供日志处理管道的默认配置。

## 默认配置

- 副本数: 2
- JVM 堆内存: 1g
- 资源限制: CPU 1核 / 内存 2Gi
- 默认 Pipeline: beats input → elasticsearch output

## 安装

```bash
helm install my-logstash ltbah/logstash
```

## 自定义 Pipeline

```bash
helm install my-logstash ltbah/logstash \
  --set-file logstash.logstashPipeline.'main.conf'=my-pipeline.conf
```

## 更多配置

详见 [Elastic Logstash Chart](https://github.com/elastic/helm-charts/tree/main/logstash)
