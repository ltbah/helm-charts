# Higress Wrapper Chart

Wrapper Chart for [Higress](https://github.com/alibaba/higress)，提供云原生 API 网关的默认配置。

## 默认配置

- Gateway 2 副本
- Controller 1 副本
- 服务类型: LoadBalancer

## 安装

```bash
helm install my-higress ltbah/higress
```

## 使用 NodePort

```bash
helm install my-higress ltbah/higress \
  --set higress.gateway.service.type=NodePort
```

## 更多配置

详见 [Higress Chart](https://github.com/alibaba/higress)
