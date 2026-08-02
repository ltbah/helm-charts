#!/usr/bin/env bash
#
# 推送 Helm Charts 到内网 Harbor (OCI Registry)
#
# 用法:
#   ./scripts/push-to-harbor.sh                          # 交互式输入
#   ./scripts/push-to-harbor.sh harbor.example.com       # 指定 Harbor 地址
#   HARBOR_PROJECT=my-charts ./scripts/push-to-harbor.sh harbor.example.com
#
# 环境变量:
#   HARBOR_URL       - Harbor 地址 (不含 https://)
#   HARBOR_PROJECT   - Harbor 项目名 (默认: helm-charts)
#   HARBOR_USERNAME   - Harbor 用户名 (默认: admin)
#   HARBOR_PASSWORD   - Harbor 密码 (交互式输入或通过环境变量)

set -euo pipefail

# ── 配置 ──
HARBOR_URL="${1:-${HARBOR_URL:-}}"
HARBOR_PROJECT="${HARBOR_PROJECT:-helm-charts}"
HARBOR_USERNAME="${HARBOR_USERNAME:-admin}"
CHARTS_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# ── 参数检查 ──
if [ -z "$HARBOR_URL" ]; then
  echo "请输入 Harbor 地址 (如 harbor.example.com):"
  read -r HARBOR_URL
fi

if [ -z "${HARBOR_PASSWORD:-}" ]; then
  echo "请输入 Harbor 密码:"
  read -rs HARBOR_PASSWORD
  echo
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Harbor:   $HARBOR_URL"
echo "Project:  $HARBOR_PROJECT"
echo "User:     $HARBOR_USERNAME"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ── 登录 ──
echo ""
echo "▶ 登录 Harbor..."
echo "$HARBOR_PASSWORD" | helm registry login "$HARBOR_URL" -u "$HARBOR_USERNAME" --password-stdin

# ── 添加依赖仓库 ──
echo ""
echo "▶ 添加依赖仓库..."
helm repo add elastic https://helm.elastic.co 2>/dev/null || true
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 2>/dev/null || true
helm repo add grafana https://grafana.github.io/helm-charts 2>/dev/null || true
helm repo add skywalking https://apache.jfrog.io/artifactory/skywalking-helm 2>/dev/null || true
helm repo add zipkin https://zipkin.io/zipkin-helm 2>/dev/null || true
helm repo add higress https://higress.io/helm-charts 2>/dev/null || true
helm repo add minio https://minio.github.io/operator 2>/dev/null || true

# ── 更新依赖 + 打包 + 推送 ──
PKGS=()
for category in infrastructure sourced custom; do
  for chart in "$CHARTS_DIR/charts/${category}"/*/; do
    if [ -f "${chart}Chart.yaml" ]; then
      name=$(basename "$chart")
      echo ""
      echo "▶ 处理: $name"

      # 更新依赖
      if grep -q "dependencies:" "${chart}Chart.yaml" 2>/dev/null; then
        helm dependency update "${chart}" 2>&1 | tail -1 || true
      fi

      # 打包
      pkg=$(helm package "${chart}" --destination /tmp/ 2>&1 | grep -oE '/tmp/[^ ]+\.tgz')
      PKGS+=("$pkg")
    fi
  done
done

# ── 推送到 Harbor ──
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "▶ 推送 ${#PKGS[@]} 个 Chart 到 Harbor..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

for pkg in "${PKGS[@]}"; do
  name=$(basename "$pkg")
  echo "  ↗ $name"
  helm push "$pkg" "oci://$HARBOR_URL/$HARBOR_PROJECT"
  rm -f "$pkg"
done

# ── 登出 ──
helm registry logout "$HARBOR_URL" 2>/dev/null || true

echo ""
echo "✅ 推送完成！"
echo ""
echo "使用方式:"
echo "  helm repo add myrepo oci://$HARBOR_URL/$HARBOR_PROJECT"
echo "  helm install mysql myrepo/mysql"
