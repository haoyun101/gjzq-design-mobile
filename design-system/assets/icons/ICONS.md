# 图标体系 · Icons(Assets)

> skill 的图标资产与管理规范。**图标名 = Figma 图标组件名**(Figma《佣金宝组件库 V2.0》「Icon 图标」页),iconfont、Figma、skill、站点四处同名。

## 零、命名规则(硬规则)

**适用范围**:skill 里的图标类名与文件名;用 skill 新建 / 导出图标;往 Figma 写页面时的**图标图层名**。一律按本节命名,不自创。

| 类型 | 格式 | 什么图标 | 示例 |
|---|---|---|---|
| 上传 iconfont 的图标 | `icf_{归属}_{名称}` | 纯单色、无渐变无动效 | `icf_nav_src`、`icf_gen_add-wl` |
| 需要切图的图标 | `slice_{归属}_{名称}` | 渐变 / 多色 / 运营插画 / 动效 | `slice_watch_edit`、`slice_bot-nav_home` |

- **归属**(英文缩写,受控词表,新增归属须用户拍板):
  - `icf`:`nav` 导航栏图标 · `gen` 通用图标 · `func` 功能性图标
  - `slice`:`all-func` 全部功能 · `list` 列表 · `op-home` 首页金刚区运营 · `trade-pg` 交易页面 · `bot-nav` 底部导航栏 · `watch` 自选 · `title` 标题 · `flag` 国旗 · `notify-br` 通知栏 · `qa` 问答 · `wp-benefit` 财富宝权益 · `inv-calendar` 投资日历 · `other` 其他 · `hold-curr` 持仓币种 · `VIP-card` VIP 服务卡片 · `vip-serv` VIP 服务
- **名称**:英文缩写,多个词用 `-` 连接;带尺寸的加后缀(如 `slice_title_hot-news-32px`)。
- **中文名**:写在 Figma 组件描述里(用于检索);skill 记在 `fonts/iconfont.css` 行尾注释与 `library-index.json` 的 `gloss`。
- **变体**:Figma 组件集的变体按属性值区分。导出文件时,文件名 = `{组件名}-{属性值}`,多个属性按 Figma 属性顺序依次连接,如 `slice_watch_signal-ena-w.svg`(状态=ena、黑/白版=w);iconfont 变体同理(`icf_func_sort-asc`)。文件名只用 ASCII 字母、数字、`_`、`-`。
- **类名不带前缀**:iconfont 平台下载的 css 会自动加 `icon-` 前缀,skill 的 `fonts/iconfont.css` 由 `iconfont.json` 生成,**不带该前缀**,类名即图标名。
- `slice` 图标名以 Figma 原样为准;`icf` 图标必须 iconfont、Figma、skill、站点四处一致。
- **命名结构怎么读(还原设计稿时)**:设计稿里的切图 / 图标图层名按 `【实现方式】_【场景/类别/模块】_【图标名称_状态】` 三段读,如 `qietu_benefit_img_orig-bg` = 实现方式 `qietu` · 模块 `benefit` · 名称与状态 `img_orig-bg`。**【】里是设计师给定的固定信息,AI 不判断、不改写,原样沿用**:前缀不是 `icf` / `slice`、归属不在上面词表里、名称里带项目名(如 `AI+` 的 `+`)都照用,不报为不合规。上面的格式、受控词表与「只用 ASCII」约束的是 AI **新建 / 自己命名**的图标。

## 一、图标分类与选用规则

| 图标类型 | 特征 | 用什么格式 | 存放位置 | 引用方式 |
|---|---|---|---|---|
| **通用单色图标**(icf) | 线性 / 面性,纯单色,无渐变无动画 | **IconFont 字体** | `fonts/` | `<i class="iconfont icf_xxx"></i>` |
| **多色 / 渐变 / 特效图标** | 双色、渐变、内阴影等,字体无法承载 | **SVG** | `common/`、`{场景}/`、`bottom-nav/`、`gradient/`;只在某个组件里用的放 `components/{组件}/` | 直接引用 .svg |
| **动画图标** | 含动效(呼吸 / 旋转 / Lottie…) | **SVG+CSS / Lottie JSON** | `gradient/`(简单)或外部资源库(复杂) | 引用文件或写引用说明 |

**判断流程**:纯单色且无动效 → 字体;带渐变 / 多色 / 特效 / 动画 → SVG 或 Lottie。**字体不能承载渐变与动画。**

**组件专用图标**(`components/`):只在一个组件里用,不进通用图标库。footer(C22 页脚 6 个)· input-box(C24 加 / 减 / 信息说明)· keyboard(C33 删除 / Shift / 语音 / 收起 / logo)· floating-entry(C32 播客 / 播放 / 暂停)。同一份也在发布仓库 `resources/icons/` 下;**包内这份是默认取用来源**,仓库用于单独拿图和换图,换图后两边同步。

## 二、IconFont 字体(icf)

- 字体文件:`fonts/iconfont.woff2`;样式表:`fonts/iconfont.css`(@font-face + 全部类名,行尾注释为中文含义)。
- **用法**:引入 iconfont.css,写 `<i class="iconfont icf_nav_src"></i>`;颜色用 CSS `color`(继承 currentColor),大小用 `font-size`。顶部导航图标 48×48(750 标注)。
- **完整清单**:`icon-palette.html`(可视)/ `library-index.json` → `icons.iconfont`(类名 · unicode · 中文)。共 76 个:`nav` 12 · `gen` 60 · `func` 4(含 `icf_func_sort-*` 3 个变体)。
- **易混**:
  - 二级导航**返回**用 `icf_gen_exit`(线性 `<`),不要用实心箭头 `icf_gen_sol-lt`。
  - 「换一换」双箭头是 `icf_gen_ref`;单箭头刷新是 `icf_nav_refr`。
  - 「通知」喇叭是 `icf_gen_notif`;「订阅」铃铛是 `icf_gen_sub`;「消息」信封是 `icf_nav_msg`。
  - 清除 / 关闭 `icf_gen_bg-close`(实心圆底 + 镂空 ×,单色字体):纯色底上染 `--CI6`,放在图片上染 `--CB19`;不另做图片版。
  - 说明 `icf_gen_desc`(i)与提示 `icf_gen_description`(!)是两个图标;输入框里的「信息说明」(两张叠放的文档)是组件专用图标(`components/input-box/doc-info.svg`),不要用 `icf_gen_desc` 代替。
  - 输入框的交易加减按钮用组件专用图标(`components/input-box/step-add.svg` / `step-sub.svg`,4 粗、撑满 32),不要用细的 `icf_gen_add`。
  - 页脚的 6 个圆底图标(客服热线 / 意见反馈 / 在线客服 / 专业团队 / 国金出品 / 暖心陪伴)是组件专用图标(`components/footer/`),iconfont 里没有,不要拿通用图标拼。
- **扩展**:新增 icf 图标时,在 iconfont 平台按本文件零章命名并更新字体库 → 用户提供下载包 → 替换 `iconfont.woff2`,按 `iconfont.json` 重新生成 `iconfont.css`(去掉平台 `icon-` 前缀)→ 跑 `scripts/build-index.py`。

## 三、SVG 图标

### 表头排序(`common/`)
双色(选中态红、未选灰),字体无法承载,用 SVG;名称与 Figma `icf_func_sort` 变体一致。16×24。

| 文件 | 用途 |
|---|---|
| `common/icf_func_sort-def.svg` | 默认(双三角灰) |
| `common/icf_func_sort-asc.svg` | 升序(上三角红) |
| `common/icf_func_sort-desc.svg` | 降序(下三角红) |

### 标题栏 & 标签栏(`common/`)
渐变 / 多色,用 SVG。`slice_title_lurker-32px` 与 Figma 同名;VIP 图形、影子账户徽标在 Figma 里是 原子-tab 内的未命名图形,按 slice 规则命名。

| 文件 | 尺寸 | 用途 |
|---|---|---|
| `common/slice_title_lurker-32px.svg` | 36×36 | 标题栏-单行 左侧图标 |
| `common/slice_tab_vip-sel.svg` | 64×32 | 原子-tab-文字+红线VIP-M 选中 |
| `common/slice_tab_vip-un.svg` | 55×32 | 原子-tab-文字+红线VIP M 未选、S 档 |
| `common/slice_tab_shadow-vip-m-sel.svg` / `-m-un.svg` | 42×24 | 原子-tab-胶囊-影子账户-M 选中 / 未选徽标 |
| `common/slice_tab_shadow-vip-s-sel.svg` / `-s-un.svg` | 40×22 | 原子-tab-胶囊-影子账户-S 选中 / 未选徽标 |

### Toast 重状态(`common/`)
Figma 组件 `slice_other_toast`(18542:31411)四个变体,100×100 白色,用于 toast-重状态。

| 文件 | 用途 |
|---|---|
| `common/slice_other_toast-success.svg` | 成功 |
| `common/slice_other_toast-failure.svg` | 失败 |
| `common/slice_other_toast-warning.svg` | 警告 |
| `common/slice_other_toast-loading.svg` | 加载中(使用时匀速旋转) |


### 图标兜底(`common/`)
Figma 图标页里定好的图标兜底组件,图标加载中 / 失败时替代原图标;`-w` 白版、`-b` 黑版。用法规则见 C11 占位图。

| 文件 | 尺寸 | Figma 组件 |
|---|---|---|
| `common/slice_all-func_fallback-img-w.svg` / `-b.svg` | 64 | `slice_all-func_fallback-img` |
| `common/slice_vip-serv_fallback-img.svg` | 88 | `slice_vip-serv_fallback-img`(白 / 黑页面通用) |
| `common/slice_list_fallback-img-w.svg` / `-b.svg` | 48 | `slice_list_fallback-img` |
| `common/icf_nav_fallback-img-w.svg` / `-b.svg` | 48 | `icf_nav_fallback-img` |
| `common/icf_gen_fallback-img-w.svg` / `-b.svg` | 48 | `icf_gen_fallback-img` |

兜底logo(圆盘用;母组件为方形,使用时由容器裁成圆):`common/fallback-logo-{w|b}-{std|lg}.svg`,标准版 100 / 放大版 160,Figma `兜底logo` 21431:1764。


### 资讯(`common/`)

| 文件 | 尺寸 | 用途 |
|---|---|---|
| `common/slice_news_follow.svg` | 32×32 | 资讯列表「提及自选」图标(红色渐变圆 + 白色心形;Figma 用旧库「线性图标/导航栏图标/关注」,按用户 10-29 指示用切图) |

### 标签(`common/`)

| 文件 | 尺寸 | 用途 |
|---|---|---|
| `common/slice_other_live-24px.svg` | 20×20 | 带图标标签的默认图标(直播,白色竖条;`fill=currentColor`,随标签字色);Figma `3975:28798` |

### 图片上的关闭(`common/`)

| 文件 | 尺寸 | 用途 |
|---|---|---|

### 自选(`market/`)

| 文件 | 用途 |
|---|---|
| `market/slice_watch_edit.svg` | 列表表头-左 · 编辑,32px |
| `market/slice_watch_multi-col.svg` | 列表表头-左 · 多股同列,32px |
| `market/slice_watch_chart-off.svg` / `-chart-on.svg` | 列表表头-左 · 走势图关 / 开,32px |
| `market/slice_watch_add-stk.svg` | 自选按钮 · 添加股票 |
| `market/slice_watch_img-recog.svg` | 自选按钮 · 图片识股 |
| `market/slice_watch_signal-{ena\|off\|disab}-{w\|b}.svg` | 自选 tab 信号:开启 / 关闭 / 禁用 × 白版 / 黑版 |
| `market/shishi.svg` | 实时(异动活跃)红波形,32×32 |

### 底部导航栏(`bottom-nav/`)
48×48。**选中态带径向渐变(CP1 #FF7067 → CP0 #F93838),必须 SVG**;未选中态单色,已设 currentColor。一个 tab 的选中 / 未选中必须同一图标成对。

| Tab | 未选中 | 选中(渐变) |
|---|---|---|
| 首页 | `slice_bot-nav_home-unsel.svg` | `slice_bot-nav_home-sel.svg` |
| 自选 | `slice_bot-nav_watchlist-unsel.svg` | `slice_bot-nav_watchlist-sel.svg` |
| 交易 | `slice_bot-nav_trade-unsel.svg` | `slice_bot-nav_trade-sel.svg` |
| 理财 | `slice_bot-nav_wealth-unsel.svg` | `slice_bot-nav_wealth-sel.svg` |
| 我的 | `slice_bot-nav_me-unsel.svg` | `slice_bot-nav_me-sel.svg` |
| 首页刷新态 | — | `slice_bot-nav_home-ref.svg` |

### 渐变 / 特效(`gradient/`)

| 文件 | 含义 | 用途 | 规格 |
|---|---|---|---|
| `xiaobao.svg` | AI 智能体小宝(正常态) | top-nav 顶部机器人;自选 / 交易 / 理财左侧图标 | 180×182,多重渐变 |
| `agent-close.svg` | 智能体导航关闭 | 智能体场景右侧关闭 | 48×48,线性渐变圆形 |
| `dajia-zaikan.svg` | 「大家都在看」蓝渐变字标 | 底部信息栏 | 140×44 |

- **小宝 ≠ 智能体球**,不可互相占位:top-nav 用 `xiaobao.svg`,底导用智能体球(见下条)。sandbox-header 内含 `<symbol id="gj-xb">`,粘了 sandbox-header 即可 `<svg width=W height=H><use href="#gj-xb"/></svg>`(原比例 180×182)。
- **智能体球不在包内**:统一从发布仓库拉取 `https://raw.githubusercontent.com/haoyun101/gjzq-design-mobile/main/resources/avatars/avatar-agent-orb.png`(132×128,2x 图;C34 头像「思考中」同一文件)。**勿替换成更轻的占位**。

### 复杂动画
逐帧动画 / Lottie 等大资源不放进 skill,只写引用说明(资源名 + 外部路径),资源放设计资源库。

## 四、库内无资产(用前别找,勿手画占位当真资产)
- **筛选漏斗**(行情二级 tab 筛选 `93:3639` / `93:3664`):iconfont 近似或省略。
- **火箭**(个股异动「火箭 28M」):iconfont 箭头替代或省略。
- 设置图标复用 `icf_nav_sett`;列表更多「>」为参考实现内联细 chevron,非独立库图标。
- **组件专用图标与插画**:C22 / C24 / C32 / C33 的专用图标在 `components/{组件}/`(见第一节);C27 缺省图插画和 C34 头像为大图,只放发布仓库(`resources/illustrations/empty/`、`resources/avatars/`),按链接引用。

## 五、目录
```
assets/icons/
├── ICONS.md          本文件
├── icon-palette.html iconfont 可视清单(build-index.py 生成)
├── fonts/            iconfont.woff2 + iconfont.css
├── common/           通用多色 SVG(表头排序)
├── market/           行情 / 自选 SVG
├── bottom-nav/       底部导航 SVG
└── gradient/         渐变 / 特效 SVG
```
引用用相对路径,如 `assets/icons/common/icf_func_sort-def.svg`。
