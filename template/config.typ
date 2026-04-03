// 导入 TwilightPage 包 / Import TwilightPage package
#import "@preview/twilightpage:0.0.1"

// 定义模板配置 / Define template configuration
#let template = twilightpage.twilightpage-web.with(
  // 头部导航链接 / Header navigation links
  header-links: (
    "/": "Home",
    "/docs/": "Docs",
    "/blog/": "Blog",
    "/cv/": "CV",
  ),
  // 网站标题 / Website title
  title: "TwilightPage",
)
