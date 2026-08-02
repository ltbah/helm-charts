# FileBrowser Quantum

[FileBrowser Quantum](https://github.com/gtsteffaniak/filebrowser) 是一个轻量级的 Web 文件管理器，提供现代化的响应式界面，支持用户管理、权限控制、文件共享、预览和编辑等功能。

## 快速安装

```bash
# 最简安装（无持久化，仅测试用）
helm install filebrowser ltbah/filebrowser

# 带持久化存储安装
helm install filebrowser ltbah/filebrowser \
  --set persistence.srv.enabled=true \
  --set persistence.data.enabled=true
```

## 通过 Higress 网关暴露服务

```bash
helm install filebrowser ltbah/filebrowser \
  --set ingress.enabled=true \
  --set ingress.className=higress \
  --set ingress.domainSuffix=example.com
```

## 完整配置安装

```bash
helm install filebrowser ltbah/filebrowser \
  --set image.tag="2.32.0" \
  --set persistence.srv.enabled=true \
  --set persistence.srv.size=50Gi \
  --set persistence.srv.storageClassName=standard \
  --set persistence.data.enabled=true \
  --set persistence.data.size=1Gi \
  --set ingress.enabled=true \
  --set ingress.className=higress \
  --set ingress.domainSuffix=example.com \
  --set config.auth.methods.password.signup=false \
  --set config.userDefaults.ui.darkMode=true \
  --set config.userDefaults.ui.locale=zh \
  --set config.userDefaults.listing.showHidden=true \
  --set config.userDefaults.account.permissions.admin=true \
  --set config.userDefaults.account.permissions.modify=true \
  --set config.userDefaults.account.permissions.create=true \
  --set config.userDefaults.account.permissions.delete=true \
  --set config.userDefaults.account.permissions.share=true \
  --set resources.requests.cpu=100m \
  --set resources.requests.memory=128Mi \
  --set resources.limits.cpu=500m \
  --set resources.limits.memory=512Mi
```

## 参数说明

### 镜像配置

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `image.repository` | 镜像仓库 | `gtstef/filebrowser` |
| `image.tag` | 镜像标签 | `""`（使用 Chart AppVersion） |
| `image.pullPolicy` | 拉取策略 | `IfNotPresent` |

### 副本与资源

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `replicaCount` | 副本数 | `1` |
| `resources.requests.cpu` | CPU 请求 | `100m` |
| `resources.requests.memory` | 内存请求 | `128Mi` |
| `resources.limits.cpu` | CPU 上限 | `500m` |
| `resources.limits.memory` | 内存上限 | `512Mi` |

### 服务配置

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `service.type` | Service 类型 | `ClusterIP` |
| `service.port` | Service 端口 | `80` |

### Ingress 配置

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `ingress.enabled` | 是否启用 Ingress | `false` |
| `ingress.className` | Ingress 类名（higress/nginx 等） | `""` |
| `ingress.domainSuffix` | 域名后缀 | `""` |
| `ingress.host` | 自定义域名（优先级高于 domainSuffix） | `""` |
| `ingress.tls` | TLS 配置 | `[]` |
| `ingress.annotations` | Ingress 注解 | `{}` |

### 持久化配置

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `persistence.srv.enabled` | 是否为文件目录创建 PVC | `false` |
| `persistence.srv.size` | 文件目录 PVC 大小 | `10Gi` |
| `persistence.srv.storageClassName` | 存储类名 | `""` |
| `persistence.srv.accessMode` | 访问模式 | `ReadWriteOnce` |
| `persistence.srv.existingClaim` | 已有 PVC 名称（挂载外部存储） | `""` |
| `persistence.data.enabled` | 是否为数据库/配置创建 PVC | `false` |
| `persistence.data.size` | 数据 PVC 大小 | `1Gi` |
| `persistence.data.storageClassName` | 存储类名 | `""` |
| `persistence.data.accessMode` | 访问模式 | `ReadWriteOnce` |

### FileBrowser 配置 (config.yaml)

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `config.server.port` | 监听端口 | `80` |
| `config.server.baseURL` | 基础 URL 路径 | `"/"` |
| `config.auth.methods.password.enabled` | 启用密码认证 | `true` |
| `config.auth.methods.password.minLength` | 密码最小长度 | `5` |
| `config.auth.methods.password.signup` | 允许用户注册 | `false` |
| `config.auth.methods.passkey.enabled` | 启用 Passkey 认证 | `false` |
| `config.userDefaults.ui.darkMode` | 暗色模式 | `true` |
| `config.userDefaults.ui.locale` | 语言 | `"en"` |
| `config.userDefaults.ui.themeColor` | 主题色 | `"var(--blue)"` |
| `config.userDefaults.listing.showHidden` | 显示隐藏文件 | `false` |
| `config.userDefaults.listing.viewMode` | 视图模式 | `"normal"` |
| `config.userDefaults.listing.singleClick` | 单击打开 | `false` |
| `config.userDefaults.preview.image` | 图片预览 | `true` |
| `config.userDefaults.preview.video` | 视频预览 | `true` |
| `config.userDefaults.preview.office` | Office 文件预览 | `true` |
| `config.userDefaults.account.permissions.admin` | 管理员权限 | `false` |
| `config.userDefaults.account.permissions.modify` | 修改权限 | `false` |
| `config.userDefaults.account.permissions.create` | 创建权限 | `false` |
| `config.userDefaults.account.permissions.delete` | 删除权限 | `false` |
| `config.userDefaults.account.permissions.share` | 分享权限 | `false` |
| `config.userDefaults.account.permissions.download` | 下载权限 | `true` |
| `config.userDefaults.account.loginMethod` | 登录方式 | `"password"` |
| `config.userDefaults.fileLoading.maxConcurrentUpload` | 最大并发上传数 | `10` |
| `config.userDefaults.fileLoading.uploadChunkSizeMb` | 上传分块大小(MB) | `10` |

### 探针与调度

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `readinessProbe` | 就绪探针配置 | 见 values.yaml |
| `livenessProbe` | 存活探针配置 | 见 values.yaml |
| `extraEnv` | 额外环境变量 | `[]` |
| `nodeSelector` | 节点选择器 | `{}` |
| `tolerations` | 容忍度 | `[]` |
| `affinity` | 亲和性 | `{}` |

## 推荐配置

### 测试环境

```bash
helm install filebrowser ltbah/filebrowser \
  --set persistence.srv.enabled=true \
  --set persistence.srv.size=5Gi \
  --set persistence.data.enabled=true \
  --set resources.requests.cpu=50m \
  --set resources.requests.memory=64Mi
```

### 生产环境

```bash
helm install filebrowser ltbah/filebrowser \
  --set persistence.srv.enabled=true \
  --set persistence.srv.size=100Gi \
  --set persistence.srv.storageClassName=fast-ssd \
  --set persistence.data.enabled=true \
  --set persistence.data.storageClassName=fast-ssd \
  --set ingress.enabled=true \
  --set ingress.className=higress \
  --set ingress.domainSuffix=example.com \
  --set config.auth.methods.password.signup=false \
  --set config.userDefaults.account.permissions.admin=true \
  --set config.userDefaults.account.permissions.modify=true \
  --set config.userDefaults.account.permissions.create=true \
  --set config.userDefaults.account.permissions.delete=true \
  --set config.userDefaults.account.permissions.share=true \
  --set config.userDefaults.listing.showHidden=true \
  --set config.userDefaults.ui.locale=zh \
  --set resources.requests.cpu=200m \
  --set resources.requests.memory=256Mi \
  --set resources.limits.cpu=1000m \
  --set resources.limits.memory=1Gi
```

## 注意事项

- 默认管理员账号: `admin` / `admin`，**首次登录后请立即修改密码**
- `persistence.srv.existingClaim` 可用于挂载已有的 NFS/CephFS 等 PVC，实现共享文件存储
- FileBrowser 的数据库和用户配置存储在 `/home/filebrowser/data/` 目录下，建议启用 `persistence.data` 以持久化
- 若需使用 OIDC/代理认证，修改 `config.userDefaults.account.loginMethod` 并配置相应环境变量
