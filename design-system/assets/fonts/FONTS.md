# 字体资源登记

| 字体 | 用途 | 文件 | 页面生成可用字重 |
|---|---|---|---|
| GJTypeDisplay(数字字体) | 时间 / 涨跌幅 / 价格 / 金额 / 百分比等**数字与数字符号**(`--font-num`) | `assets/fonts/GJTypeDisplay-{Regular,Medium,Bold}.ttf` | R 400 / M 500 |
| 系统字体(中文 / 西文) | 中文与西文跟随系统;设计稿用 PingFang SC(`--font-sans`) | 系统自带,不随包 | R 400 / M 500 |

- GJTypeDisplay 覆盖 `0–9 $%&()*+,-./:<=>~¥≈≠≤≥`,不含字母;字母走 `--font-sans`。
- 字重规则见 `references/foundations.md` §3:页面生成只用 R(400)/ M(500)。`GJTypeDisplay-Bold` 随包提供,当 B(600)用,**仅在用户明确要求时使用**。
- 字体平台对应(切图 / 分发场景,Design「设计文件下载」页统一提供):PingFang = iOS 系统、思源黑体 = 安卓、微软雅黑 = Web、OPPO Sans = 切图免费商用、GJTypeDisplay = 数字。

## @font-face 声明

```css
@font-face{font-family:"GJTypeDisplay";font-weight:400;src:url("assets/fonts/GJTypeDisplay-Regular.ttf") format("truetype");}
@font-face{font-family:"GJTypeDisplay";font-weight:500;src:url("assets/fonts/GJTypeDisplay-Medium.ttf") format("truetype");}
/* 仅在用户明确要求时加入 */
@font-face{font-family:"GJTypeDisplay";font-weight:600;src:url("assets/fonts/GJTypeDisplay-Bold.ttf") format("truetype");}
```

单文件原型可 base64 内嵌(每个字重约 5KB);中文字体走系统,不内嵌。
