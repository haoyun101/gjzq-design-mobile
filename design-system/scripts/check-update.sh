#!/usr/bin/env bash
# 国金证券C端客户端设计组件系统 · 升级自检
# ------------------------------------------------------------------
# 版本源(按优先级):
#   1) GitHub 发布仓 {REPO} 分支 {BRANCH} 下 {SUBDIR}/VERSION(首选)
#        仓库:https://github.com/haoyun101/gjzq-design-mobile
#   2) Design 站下载区的包文件名 {SITE_PKG}-vX.Y.Z.zip(仓库取不到时的备用)
#        站点:https://gjzq-design-mobile.netlify.app/index.html
# 规则:
#   - 仓库读得到版本 → 以仓库为准:不比本地新就静默结束,不再看站点;
#     比本地新就从仓库取包,取包失败才改从站点取。
#   - 仓库读不到版本(网络 / 仓库不可达 / 内容异常)→ 改看站点。
#   - 任一来源装包前都核对:包内含 SKILL.md,且包内 VERSION = 该来源声称的版本。
# 设计原则:失败永不阻断 skill 本体(任何异常都 exit 0 让本体继续)。
# ------------------------------------------------------------------
set -uo pipefail

# ===== 配置(可用环境变量覆盖)=====
REPO="${GJDS_UPDATE_REPO:-haoyun101/gjzq-design-mobile}"
BRANCH="${GJDS_UPDATE_BRANCH:-main}"
SUBDIR="${GJDS_UPDATE_SUBDIR:-design-system}"   # 本包在发布仓里的子目录
RAW_BASE="${GJDS_UPDATE_RAW_BASE:-https://raw.githubusercontent.com}"
ARCHIVE_BASE="${GJDS_UPDATE_ARCHIVE_BASE:-https://codeload.github.com}"
SITE_BASE="${GJDS_UPDATE_SITE_BASE:-https://gjzq-design-mobile.netlify.app}"
# 站点下载区包名前缀(按子目录给默认值;为空 = 不用站点备用)
case "$SUBDIR" in
  design-system) _site_pkg="guojin-ds-skill" ;;
  *)             _site_pkg="" ;;
esac
SITE_PKG="${GJDS_UPDATE_SITE_PKG-$_site_pkg}"
PROXY="${GJDS_UPDATE_PROXY-}"                  # 公网直连即可;需要时传入,如 http://127.0.0.1:7897

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOCAL_VERSION_FILE="$SKILL_DIR/VERSION"

local_ver="$(tr -d '[:space:]' < "$LOCAL_VERSION_FILE" 2>/dev/null || echo 0)"
[ -z "$local_ver" ] && local_ver=0

curl_opts=(-fsSL --max-time 15)
[ -n "$PROXY" ] && curl_opts+=(--proxy "$PROXY")

tmp="$(mktemp -d)"; trap 'rm -rf "${tmp}"' EXIT

# ===== 工具函数 =====
valid_ver() { case "$1" in ''|*[!0-9.]*) return 1 ;; esac; return 0; }
# $1 是否严格新于 $2(sort -V,semver 正确比大小)
is_newer() {
  [ "$1" != "$2" ] && [ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | tail -n1)" = "$1" ]
}
# 只用 rsync 安装,没有就不装。不回退 cp -rf,因为 cp -rf 有两个会闷声出错的毛病:
#   a) 不删文件——新版删掉的文件会留在本地,装完的目录指纹悄悄偏离签发件;
#   b) 原地截断重写,会把「正在运行的本脚本」写坏(bash 按偏移续读)。
# rsync 写临时文件再 rename,自覆盖安全,--delete 保证装完 = 签发件。
need_rsync() {
  if ! command -v rsync >/dev/null 2>&1; then
    echo "SKILL-UPDATE: 本机缺 rsync,本次不更新(本地 ${local_ver} 继续)。装上 rsync 后会自动更新。"
    exit 0
  fi
}
# install_dir <包目录> <声称版本> <来源名>:核对通过则安装并结束脚本;核对不过返回 1
install_dir() {
  local src="$1" ver="$2" label="$3" got
  if [ -z "$src" ] || [ ! -f "$src/SKILL.md" ]; then
    echo "SKILL-UPDATE: ${label}的包结构异常(未找到 SKILL.md)"
    return 1
  fi
  got="$(tr -d '[:space:]' < "$src/VERSION" 2>/dev/null || true)"
  if [ "$got" != "$ver" ]; then
    echo "SKILL-UPDATE: ${label}的包内版本(${got})与声称版本(${ver})不符"
    return 1
  fi
  rsync -a --delete "${src}/" "${SKILL_DIR}/" 2>/dev/null \
    || { echo "SKILL-UPDATE: 写入失败,保留本地继续"; exit 0; }
  chmod +x "${SKILL_DIR}/scripts/"*.sh 2>/dev/null || true
  echo "${ver}" > "${LOCAL_VERSION_FILE}"
  echo "SKILL-UPDATE: 已更新到 ${ver}(来源:${label})✅  请重新触发本 skill 以加载新版"
  exit 0
}

# ===== 1. 首选:GitHub 发布仓 =====
repo_ver="$(curl "${curl_opts[@]}" "${RAW_BASE}/${REPO}/${BRANCH}/${SUBDIR}/VERSION" 2>/dev/null | tr -d '[:space:]' || true)"
if valid_ver "$repo_ver"; then
  is_newer "$repo_ver" "$local_ver" || exit 0   # 仓库为准:已最新或本地更新,静默继续
  echo "SKILL-UPDATE: 发现新版本 ${repo_ver}(本地 ${local_ver}),从仓库更新…"
  need_rsync
  if curl "${curl_opts[@]}" "${ARCHIVE_BASE}/${REPO}/zip/refs/heads/${BRANCH}" -o "${tmp}/repo.zip" 2>/dev/null \
     && unzip -q -o "${tmp}/repo.zip" -d "${tmp}/repo" 2>/dev/null; then
    src="$(find "${tmp}/repo" -maxdepth 2 -type d -name "${SUBDIR}" -print -quit 2>/dev/null || true)"
    install_dir "$src" "$repo_ver" "仓库"
  else
    echo "SKILL-UPDATE: 仓库下载 / 解压失败"
  fi
  echo "SKILL-UPDATE: 仓库取包未成功,改从站点取…"
else
  echo "SKILL-UPDATE: 仓库读不到版本(网络 / 仓库不可达 / 内容异常),改查站点…"
fi

# ===== 2. 备用:Design 站下载区 =====
if [ -z "$SITE_PKG" ]; then
  echo "SKILL-UPDATE: 本包无站点备用源,用本地 ${local_ver} 继续"
  exit 0
fi
html="$(curl "${curl_opts[@]}" "${SITE_BASE}/index.html" 2>/dev/null || true)"
if [ -z "$html" ]; then
  echo "SKILL-UPDATE: 站点也不可达,用本地 ${local_ver} 继续"
  exit 0
fi
zip_path="$(printf '%s' "$html" | grep -oE "[^\"' ]*${SITE_PKG}-v[0-9]+\.[0-9]+\.[0-9]+\.zip" | head -n1 || true)"
site_ver="$(printf '%s' "$zip_path" | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+\.zip$' | sed 's/^v//; s/\.zip$//' || true)"
if ! valid_ver "$site_ver"; then
  echo "SKILL-UPDATE: 未能在站点解析到版本号,用本地 ${local_ver} 继续"
  exit 0
fi
is_newer "$site_ver" "$local_ver" || exit 0     # 站点不比本地新,静默继续
echo "SKILL-UPDATE: 站点有新版本 ${site_ver}(本地 ${local_ver}),从站点更新…"
need_rsync
case "${zip_path}" in
  http*) dl_url="${zip_path}" ;;
  /*)    dl_url="${SITE_BASE}${zip_path}" ;;
  *)     dl_url="${SITE_BASE}/${zip_path#./}" ;;
esac
curl "${curl_opts[@]}" "${dl_url}" -o "${tmp}/site.zip" 2>/dev/null \
  || { echo "SKILL-UPDATE: 站点下载失败,保留本地继续"; exit 0; }
unzip -q -o "${tmp}/site.zip" -d "${tmp}/site" 2>/dev/null \
  || { echo "SKILL-UPDATE: 站点包解压失败,保留本地继续"; exit 0; }
skillmd="$(find "${tmp}/site" -maxdepth 3 -name SKILL.md -print -quit 2>/dev/null || true)"
src=""; [ -n "$skillmd" ] && src="$(dirname "$skillmd")"
install_dir "$src" "$site_ver" "站点"
echo "SKILL-UPDATE: 放弃本次更新,用本地 ${local_ver} 继续"
exit 0
