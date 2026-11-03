# 头像与 AI 投顾形象(C34)

DS 第 34 章《头像 Avatar》的位图资产。skill 只写名称和规则，图片按需从这里拉取：

`https://raw.githubusercontent.com/haoyun101/gjzq-design-mobile/main/resources/avatars/<文件名>`

- 来源:Figma「Avatar 头像」页(3615:43430)组件母版，1x 导出(暂用，使用中如发现不够清晰再换高清版)。
- 头像母版 80×80 圆形透明底；客服含 2px 描边、小宝含投影，所以画布略大于 80。
- 形象 100×100 不裁圆，透明底。
- 小宝、兜底按皮肤取 `-w`(浅色) / `-b`(深色)。
- 「思考中」就是底部导航栏的智能体球组件:skill 内优先用 `assets/icons/gradient/agent-orb-wave.svg`,这里的 PNG 由它 2x 渲染而来，便于单独拉取。
- 取不到任何头像时用兜底头像。

| 文件 | 内容 | 尺寸 | 模式 |
|---|---|---|---|
| `avatar-xiaobao-w.png` | 小宝 白版(浅色皮肤) | 80×81 | RGBA |
| `avatar-xiaobao-b.png` | 小宝 黑版(深色皮肤) | 80×81 | RGBA |
| `avatar-agent-orb.png` | 智能体球(思考中)· 同底部导航 `agent-orb-wave` | 264×256(132×128 的 2x) | RGBA |
| `avatar-ai-xuanhaogu.png` | AI选好股 | 80×80 | RGBA |
| `avatar-ai-gupiaojietao.png` | AI股票解套 | 80×80 | RGBA |
| `avatar-ai-touetf.png` | AI投ETF | 80×80 | RGBA |
| `avatar-ai-jijinhuiben.png` | AI基金回本 | 80×80 | RGBA |
| `avatar-ai-yingzizhanghu.png` | AI影子账户 | 80×80 | RGBA |
| `avatar-ai-xuanhaoji.png` | AI选好基 | 80×80 | RGBA |
| `avatar-ai-chaxinhao.png` | AI查信号 | 80×80 | RGBA |
| `avatar-ai-plus-tougu.png` | AI+投顾 | 80×80 | RGBA |
| `avatar-user-default.png` | 用户默认 | 80×80 | RGBA |
| `avatar-tougu.png` | 投顾 | 80×80 | RGBA |
| `avatar-kefu.png` | 客服(含 2px 描边) | 84×84 | RGBA |
| `avatar-fallback-w.png` | 兜底 白版(浅色皮肤) | 80×80 | RGBA |
| `avatar-fallback-b.png` | 兜底 黑版(深色皮肤) | 80×80 | RGBA |
| `figure-ai-xuanhaogu.png` | AI选好股 形象 | 100×100 | RGBA |
| `figure-ai-gupiaojietao.png` | AI股票解套 形象 | 100×100 | RGBA |
| `figure-ai-touetf.png` | AI投ETF 形象 | 100×100 | RGBA |
| `figure-ai-jijinhuiben.png` | AI基金回本 形象 | 100×100 | RGBA |
| `figure-ai-yingzizhanghu.png` | AI影子账户 形象 | 100×100 | RGBA |
| `figure-ai-xuanhaoji.png` | AI选好基 形象 | 100×100 | RGBA |
| `figure-ai-chaxinhao.png` | AI查信号 形象 | 100×100 | RGBA |
