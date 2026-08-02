# MinIO Wrapper Chart

Wrapper Chart for [MinIO Operator](https://min.io/docs/minio/kubernetes/upstream/)，提供对象存储服务的默认配置。

---

## 最简安装

仅填写必填参数即可快速安装：

```bash
helm install my-minio ltbah/minio \
  --set tenant.secrets.accessKey=youraccesskey \
  --set tenant.secrets.secretKey=yoursecretkey
```

> **注意**: `tenant.secrets.accessKey` 和 `tenant.secrets.secretKey` 为必填项，留空将导致安装失败。

---

## 最全配置安装

所有参数完整示例：

```bash
helm install my-minio ltbah/minio \
  # ── Operator ────────────────────────────────────────────────
  --set operator.enabled=true \
  --set operator.replicaCount=2 \
  --set operator.resources.requests.cpu=200m \
  --set operator.resources.requests.memory=256Mi \
  --set operator.resources.limits.cpu=500m \
  --set operator.resources.limits.memory=512Mi \
  --set operator.service.type=ClusterIP \
  --set operator.service.ports.http=9090 \
  --set operator.nodeSelector.role=storage \
  --set 'operator.tolerations[0].key=dedicated' \
  --set 'operator.tolerations[0].operator=Equal' \
  --set 'operator.tolerations[0].value=minio' \
  --set 'operator.tolerations[0].effect=NoSchedule' \
  --set operator.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchLabels.app=minio-operator \
  --set 'operator.extraEnvVars[0].name=TZ' \
  --set 'operator.extraEnvVars[0].value=Asia/Shanghai' \
  # ── Tenant ──────────────────────────────────────────────────
  --set tenant.enabled=true \
  --set tenant.name=minio-tenant \
  --set tenant.secrets.accessKey=youraccesskey                # [REQUIRED]
  --set tenant.secrets.secretKey=yoursecretkey                # [REQUIRED]
  --set tenant.pools[0].name=pool-0 \
  --set tenant.pools[0].servers=4 \
  --set tenant.pools[0].volumesPerServer=1 \
  --set tenant.pools[0].size=10Gi \
  --set tenant.pools[0].storageClassName=ssd \
  --set tenant.expose.type=ClusterIP \
  --set tenant.expose.ports.api=9000 \
  --set tenant.expose.ports.console=9001 \
  --set tenant.resources.requests.cpu=200m \
  --set tenant.resources.requests.memory=256Mi \
  --set tenant.resources.limits.cpu=1 \
  --set tenant.resources.limits.memory=1Gi \
  --set tenant.ingress.enabled=true \
  --set 'tenant.ingress.annotations[kubernetes.io/ingress.class]=nginx' \
  --set 'tenant.ingress.annotations[cert-manager.io/cluster-issuer]=letsencrypt-prod' \
  --set 'tenant.ingress.hosts[0].host=minio.example.com' \
  --set 'tenant.ingress.hosts[0].paths[0]=/' \
  --set 'tenant.ingress.tls[0].secretName=minio-tls' \
  --set 'tenant.ingress.tls[0].hosts[0]=minio.example.com'
```

---

## 必填参数

| 参数 | 说明 |
|------|------|
| `tenant.secrets.accessKey` | MinIO Access Key，**不可为空** |
| `tenant.secrets.secretKey` | MinIO Secret Key，**不可为空** |

---

## 参数列表

### Operator

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `operator.enabled` | `true` | 是否启用 MinIO Operator |
| `operator.replicaCount` | `2` | Operator 副本数 |
| `operator.resources.requests.cpu` | `200m` | CPU 请求 |
| `operator.resources.requests.memory` | `256Mi` | 内存请求 |
| `operator.resources.limits.cpu` | `500m` | CPU 限制 |
| `operator.resources.limits.memory` | `512Mi` | 内存限制 |
| `operator.service.type` | `ClusterIP` | Service 类型 |
| `operator.service.ports.http` | `9090` | Operator HTTP 端口 |
| `operator.nodeSelector` | `{}` | 节点选择器 |
| `operator.tolerations` | `[]` | 容忍度 |
| `operator.affinity` | `{}` | 亲和性 |
| `operator.extraEnvVars` | `[]` | 额外环境变量列表 |
| `operator.podAnnotations` | `{}` | Pod 标注 |
| `operator.podLabels` | `{}` | Pod 标签 |

### Tenant

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `tenant.enabled` | `true` | 是否启用 MinIO Tenant |
| `tenant.name` | `minio-tenant` | Tenant 名称 |
| `tenant.secrets.accessKey` | `""` | **[REQUIRED]** MinIO Access Key |
| `tenant.secrets.secretKey` | `""` | **[REQUIRED]** MinIO Secret Key |
| `tenant.pools[0].name` | `pool-0` | 存储池名称 |
| `tenant.pools[0].servers` | `4` | 存储池服务器数 |
| `tenant.pools[0].volumesPerServer` | `1` | 每服务器卷数 |
| `tenant.pools[0].size` | `10Gi` | 每卷存储大小 |
| `tenant.pools[0].storageClassName` | `""` | 存储类名 |
| `tenant.expose.type` | `ClusterIP` | Service 类型 |
| `tenant.expose.ports.api` | `9000` | S3 API 端口 |
| `tenant.expose.ports.console` | `9001` | Console 端口 |
| `tenant.resources.requests.cpu` | `200m` | CPU 请求 |
| `tenant.resources.requests.memory` | `256Mi` | 内存请求 |
| `tenant.resources.limits.cpu` | `"1"` | CPU 限制 |
| `tenant.resources.limits.memory` | `1Gi` | 内存限制 |
| `tenant.ingress.enabled` | `false` | 是否启用 Ingress |
| `tenant.ingress.annotations` | `{}` | Ingress 标注 |
| `tenant.ingress.hosts` | `[]` | Ingress 域名规则 |
| `tenant.ingress.tls` | `[]` | Ingress TLS 配置 |

---

## 测试环境推荐配置

```bash
helm install minio-test ltbah/minio \
  --set operator.replicaCount=1 \
  --set operator.resources.requests.cpu=100m \
  --set operator.resources.requests.memory=128Mi \
  --set operator.resources.limits.cpu=200m \
  --set operator.resources.limits.memory=256Mi \
  --set tenant.secrets.accessKey=testaccesskey \
  --set tenant.secrets.secretKey=testsecretkey \
  --set tenant.pools[0].servers=1 \
  --set tenant.pools[0].volumesPerServer=1 \
  --set tenant.pools[0].size=5Gi \
  --set tenant.resources.requests.cpu=100m \
  --set tenant.resources.requests.memory=128Mi \
  --set tenant.resources.limits.cpu=500m \
  --set tenant.resources.limits.memory=512Mi \
  --set tenant.ingress.enabled=false
```

> 测试环境使用单节点单卷最小部署，资源占用最低，适合本地开发与功能测试。

---

## 生产环境推荐配置

```bash
helm install minio-prod ltbah/minio \
  --set operator.replicaCount=2 \
  --set operator.resources.requests.cpu=200m \
  --set operator.resources.requests.memory=256Mi \
  --set operator.resources.limits.cpu=500m \
  --set operator.resources.limits.memory=512Mi \
  --set 'operator.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].labelSelector.matchLabels.app=minio-operator' \
  --set 'operator.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution[0].topologyKey=kubernetes.io/hostname' \
  --set tenant.secrets.accessKey=<FROM_VAULT> \
  --set tenant.secrets.secretKey=<FROM_VAULT> \
  --set tenant.pools[0].servers=4 \
  --set tenant.pools[0].volumesPerServer=2 \
  --set tenant.pools[0].size=100Gi \
  --set tenant.pools[0].storageClassName=fast-ssd \
  --set tenant.expose.type=LoadBalancer \
  --set tenant.resources.requests.cpu=500m \
  --set tenant.resources.requests.memory=1Gi \
  --set tenant.resources.limits.cpu=2 \
  --set tenant.resources.limits.memory=4Gi \
  --set tenant.ingress.enabled=true \
  --set 'tenant.ingress.annotations[kubernetes.io/ingress.class]=nginx' \
  --set 'tenant.ingress.annotations[cert-manager.io/cluster-issuer]=letsencrypt-prod' \
  --set 'tenant.ingress.hosts[0].host=minio.example.com' \
  --set 'tenant.ingress.hosts[0].paths[0]=/' \
  --set 'tenant.ingress.tls[0].secretName=minio-prod-tls' \
  --set 'tenant.ingress.tls[0].hosts[0]=minio.example.com'
```

生产环境要点：
- **密钥管理**: 推荐通过 CI/CD 注入密钥或使用 Vault/Sealed Secrets，避免明文写入命令行
- **高可用**: 至少 4 Server + 多卷，确保数据冗余与纠删码生效
- **持久化**: 必须使用高性能 StorageClass（如 SSD）
- **资源配额**: 根据对象存储规模合理设置 requests/limits
- **网络暴露**: 生产环境建议通过 Ingress + TLS 或 LoadBalancer 对外暴露

---

## 更多配置

详见 [MinIO Operator Helm Chart](https://min.io/docs/minio/kubernetes/upstream/)
