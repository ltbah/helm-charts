# Filebeat Wrapper Chart

Wrapper Chart for [Elastic Filebeat](https://github.com/elastic/helm-charts/tree/main/filebeat)，提供日志采集的默认配置。

## 最简安装

```bash
helm install my-filebeat ltbah/filebeat \
  --set-file filebeat.filebeatConfig.filebeat\.yml=filebeat.yml
```

其中 `filebeat.yml` 示例:

```yaml
filebeat.inputs:
  - type: log
    enabled: true
    paths:
      - /var/log/*.log
output.elasticsearch:
  hosts: ["https://elasticsearch:9200"]
```

## 最全配置安装

```bash
helm install my-filebeat ltbah/filebeat \
  --set-file filebeat.filebeatConfig.filebeat\.yml=filebeat.yml \
  --set filebeat.resources.requests.cpu=200m \
  --set filebeat.resources.requests.memory=256Mi \
  --set filebeat.resources.limits.cpu=1 \
  --set filebeat.resources.limits.memory=1Gi \
  --set 'filebeat.secretMounts[0].name=elasticsearch-certs' \
  --set 'filebeat.secretMounts[0].secretName=elasticsearch-certs' \
  --set 'filebeat.secretMounts[0].path=/usr/share/filebeat/certs' \
  --set filebeat.persistence.enabled=true \
  --set filebeat.persistence.size=5Gi \
  --set filebeat.service.type=ClusterIP \
  --set 'filebeat.service.ports[0].name=http' \
  --set 'filebeat.service.ports[0].port=5066' \
  --set filebeat.ingress.enabled=true \
  --set 'filebeat.ingress.hosts[0].host=filebeat.example.com' \
  --set 'filebeat.ingress.hosts[0].paths[0].path=/' \
  --set 'filebeat.extraEnvs[0].name=LOG_LEVEL' \
  --set 'filebeat.extraEnvs[0].value=info'
```

## 必填参数

| 参数 | 说明 |
|------|------|
| `filebeat.filebeatConfig` | Filebeat 配置，至少包含 filebeat.yml |

## 参数列表

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `filebeat.filebeatConfig` | `{}` | Filebeat 配置 (filebeat.yml) |
| `filebeat.resources.requests.cpu` | `100m` | CPU 请求 |
| `filebeat.resources.requests.memory` | `200Mi` | 内存请求 |
| `filebeat.resources.limits.cpu` | `500m` | CPU 限制 |
| `filebeat.resources.limits.memory` | `500Mi` | 内存限制 |
| `filebeat.extraEnvs` | `[]` | 额外环境变量 |
| `filebeat.nodeSelector` | `{}` | 节点选择器 |
| `filebeat.tolerations` | `[]` | 容忍度 |
| `filebeat.affinity` | `{}` | 亲和性 |
| `filebeat.secretMounts` | `[]` | Secret 挂载 (如 TLS 证书) |
| `filebeat.persistence.enabled` | `false` | 是否启用持久化 |
| `filebeat.persistence.size` | `1Gi` | 持久化存储大小 |
| `filebeat.readinessProbe` | (见 values) | 就绪探针配置 |
| `filebeat.livenessProbe` | (见 values) | 存活探针配置 |
| `filebeat.service.type` | `ClusterIP` | Service 类型 |
| `filebeat.service.ports` | `[{"name":"http","port":5066}]` | Service 端口列表 |
| `filebeat.ingress.enabled` | `false` | 是否启用 Ingress |
| `filebeat.ingress.hosts` | `[]` | Ingress 域名 |

## 测试环境推荐配置

```bash
helm install my-filebeat ltbah/filebeat \
  --set-file filebeat.filebeatConfig.filebeat\.yml=filebeat.yml \
  --set filebeat.resources.requests.cpu=50m \
  --set filebeat.resources.requests.memory=128Mi \
  --set filebeat.resources.limits.cpu=200m \
  --set filebeat.resources.limits.memory=256Mi \
  --set filebeat.persistence.enabled=false
```

## 生产环境推荐配置

```bash
helm install my-filebeat ltbah/filebeat \
  --set-file filebeat.filebeatConfig.filebeat\.yml=filebeat.yml \
  --set filebeat.resources.requests.cpu=200m \
  --set filebeat.resources.requests.memory=256Mi \
  --set filebeat.resources.limits.cpu=1 \
  --set filebeat.resources.limits.memory=1Gi \
  --set 'filebeat.secretMounts[0].name=elasticsearch-certs' \
  --set 'filebeat.secretMounts[0].secretName=elasticsearch-certs' \
  --set 'filebeat.secretMounts[0].path=/usr/share/filebeat/certs' \
  --set filebeat.persistence.enabled=true \
  --set filebeat.persistence.size=5Gi \
  --set filebeat.tolerations[0].key=node-role \
  --set filebeat.tolerations[0].operator=Exists \
  --set filebeat.tolerations[0].effect=NoSchedule
```

## 更多配置

详见 [Elastic Filebeat Chart](https://github.com/elastic/helm-charts/tree/main/filebeat)
