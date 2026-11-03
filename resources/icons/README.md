# 组件专用图标

只在某个组件里使用的图标,**不进通用图标库**(iconfont / skill `assets/icons`)。skill 对应章节写明用途,图标按需从这里拉取:

`https://raw.githubusercontent.com/haoyun101/gjzq-design-mobile/main/resources/icons/<组件>/<文件名>`

skill 包 `assets/icons/components/<组件>/` 里有同一份,**生成页面默认用包内那份**(不依赖网络);这里用于单独拿图和换图,换图后两边同步。

均为 Figma 组件直接导出的 SVG,颜色为 Figma 原值;单色图标使用时按章节规定的颜色 token 覆盖。

## input-box(C24 输入框)

| 文件 | 内容 | 尺寸 | Figma |
|---|---|---|---|
| `step-add.svg` | 加(4 粗圆头十字,撑满 32) | 32×32 | 图标/交易买卖加减 · 名称=加 17965:21560 |
| `step-sub.svg` | 减(32×4 圆头横条) | 32×32 | 图标/交易买卖加减 · 名称=减 17965:21559 |
| `doc-info.svg` | 信息说明(两张叠放的文档,线性) | 32×32 | 信息说明 17894:30603 |

加减颜色按场景:买 `--CN1` / 卖 `--CN3` / 新股新债 `--CI2`;信息说明默认 `--CI3`。

## floating-entry(C32 悬浮入口 · AI 播客浮窗)

| 文件 | 内容 | 尺寸 | Figma |
|---|---|---|---|
| `podcast.svg` | AI 播客图标(渐变圆底) | 84×84 | 19156:1289 |
| `play.svg` | 播放(暂停态时显示) | 48×48 | 15567:10364 |
| `pause.svg` | 暂停(播放中显示) | 48×48 | 15567:10346 |

## keyboard(C33 安全键盘)

| 文件 | 内容 | 尺寸 | Figma |
|---|---|---|---|
| `delete.svg` | 删除键 | 60×60 | 键盘icon/删除 13018:7584 |
| `shift.svg` | 大小写切换(Shift) | 60×60 | 键盘icon/切换 13018:13981 |
| `voice.svg` | 语音 tab 图标 | 32×32 | 键盘icon/语音 13018:7596 |
| `collapse.svg` | 键盘收起 | 36×36 | 键盘/键盘icon/键盘收起 16531:3513 |
| `logo.svg` | 安全提示 logo(多色) | 32×32 | 键盘logo 16530:2989 |

## footer(C22 页脚)

| 文件 | 内容 | 尺寸 | 原名 |
|---|---|---|---|
| `hot.svg` | 客服热线 | 40×40 | icf_func_btn-btm-hot |
| `feed.svg` | 意见反馈 | 40×40 | icf_func_btn-btm-feed |
| `serv.svg` | 在线客服 | 40×40 | icf_func_btn-btm-serv |
| `prof.svg` | 专业团队 | 40×40 | icf_func_btn-btm-prof |
| `logo.svg` | 国金出品 | 40×40 | icf_func_btn-btm-logo |
| `accmp.svg` | 暖心陪伴 | 40×40 | icf_func_btn-btm-accmp |

浅灰圆底 + 描边 + 图形三层,颜色全部用 `currentColor`(不同透明度),使用时把 `color` 设为 `--CI3`(与 skill 页脚组件一致)。这组图标转成 iconfont 单色字形后圆底和图形会糊成一块,所以只用这里的 SVG,不用字体。
