// ============================================
// TwilightPage 主模块 / TwilightPage Main Module
// ============================================
// 本模块是 TwilightPage 模板的核心入口，提供网页生成的完整功能。
// This module is the core entry point of the TwilightPage template, providing complete web page generation functionality.

// 导入子模块 / Import submodules
#import "math.typ": template-math       // 数学公式处理 / Math formula handling
#import "refs.typ": template-refs       // 引用和交叉引用处理 / Reference and cross-reference handling
#import "notes.typ": template-notes     // 脚注和边注处理 / Footnote and margin note handling
#import "figures.typ": template-figures // 图表处理 / Figure handling
#import "layout.typ": full-width, margin-note, nest-block  // 布局工具 / Layout utilities

// 创建网站头部导航 / Create website header navigation
// 参数 / Parameters:
//   - links: 导航链接列表，格式为 ((href, title), ...) / List of navigation links in format ((href, title), ...)
// 返回 / Returns: HTML header 元素 / HTML header element
#let make-header(links) = html.header(
  if links != none {
    html.nav(
      for (href, title) in links {
        html.a(href: href, title)
      },
    )
  },
)

// TwilightPage 网页模板主函数 / TwilightPage web template main function
// 生成完整的 HTML 网页，集成 Tufte CSS 样式和各类内容处理功能。
// Generates a complete HTML webpage with Tufte CSS styling and various content processing features.
//
// 参数 / Parameters:
//   - header-links: 头部导航链接列表 / Header navigation links list (默认 / default: none)
//   - title: 网页标题 / Webpage title (默认 / default: "TwilightPage")
//   - lang: 语言代码 / Language code (默认 / default: "en")
//   - css: CSS 样式表 URL 列表 / List of CSS stylesheet URLs
//   - content: 页面主要内容 / Main page content
#let twilightpage-web(
  header-links: none, // 头部导航链接列表 / Header navigation links list (默认 / default: none)
  title: "TwilightPage", // 网页标题 / Webpage title (默认 / default: "TwilightPage")
  lang: "zh", // 语言代码 / Language code
  css: (
    "https://cdnjs.cloudflare.com/ajax/libs/tufte-css/1.8.0/tufte.min.css",  // Tufte CSS 基础样式 / Tufte CSS base styles
    "/assets/tufted.css",   // TwilightPage 自定义样式 / TwilightPage custom styles
    "/assets/custom.css",   // 用户自定义样式 / User custom styles
  ),
  content,
) = {
  // 应用各类内容处理模板 / Apply various content processing templates
  // 这些 show 规则会转换特定类型的内容为 HTML 格式
  // These show rules transform specific content types into HTML format
  show: template-math     // 应用数学公式处理 / Apply math formula processing
  show: template-refs     // 应用引用处理 / Apply reference processing
  show: template-notes    // 应用脚注处理 / Apply footnote processing
  show: template-figures  // 应用图表处理 / Apply figure processing

  // 设置文档语言 / Set document language
  set text(lang: lang)

  // 生成 HTML 文档结构 / Generate HTML document structure
  html.html(
    lang: lang,
    {
      // ========== HTML Head 部分 / HTML Head Section ==========
      html.head({
        // 字符编码和视口设置 / Character encoding and viewport settings
        html.meta(charset: "utf-8") // 字符编码 / Character encoding
        html.meta(name: "viewport", content: "width=device-width, initial-scale=1") // 视口设置 / Viewport settings
        html.title(title)  // 页面标题 / Page title

        // 链接所有 CSS 样式表 / Link all CSS stylesheets
        for (css-link) in css {
          html.link(rel: "stylesheet", href: css-link) // 链接 CSS 样式表 / Link CSS stylesheet
        }
      })

      // ========== HTML Body 部分 / HTML Body Section ==========
      html.body({
        // 渲染网站头部导航 / Render website header navigation
        make-header(header-links)

        // 主内容区域，使用 article 和 section 语义化标签
        // Main content area using semantic article and section tags
        html.article(
          html.section(content),
        )
      })
    },
  )
}

// Abyss 深渊主题 / Abyss dark theme
// 提供深色配色方案，适合低光环境阅读
// 支持根据标题层级自动缩进内容
// Provides a dark color scheme, suitable for low-light reading
// Supports automatic content indentation based on heading levels
//
// 参数 / Parameters:
//   - header-links: 头部导航链接列表 / Header navigation links list (默认 / default: none)
//   - title: 网页标题 / Webpage title (默认 / default: "TwilightPage")
//   - lang: 语言代码 / Language code (默认 / default: "zh")
//   - indent: 是否启用缩进 / Enable indentation (默认 / default: true)
//   - indent-color: 缩进线颜色 / Indentation line color (默认 / default: #30363d)
//   - indent-size: 缩进距离 / Indentation size (默认 / default: 1.5em)
//   - content: 页面主要内容 / Main page content
#let abyss(
  header-links: none,
  title: "TwilightPage",
  lang: "zh",
  indent: true,
  indent-color: rgb(48, 54, 61),
  indent-size: 1.5em,
  content,
) = {
  // 应用 abyss 主题特定的 CSS
  let abyss-css = (
    "https://cdnjs.cloudflare.com/ajax/libs/tufte-css/1.8.0/tufte.min.css",
    "/assets/tufted.css",
    "/assets/abyss.css",  // Abyss 主题样式 / Abyss theme styles
    "/assets/custom.css",
  )
  
  // 如果启用缩进，应用嵌套缩进块
  // If indentation is enabled, apply nested indentation block
  let processed-content = if indent {
    nest-block(
      content,
      depth: 1,
      line-color: indent-color,
      inset: indent-size,
    )
  } else {
    content
  }
  
  // 调用主模板函数
  twilightpage-web(
    header-links: header-links,
    title: title,
    lang: lang,
    css: abyss-css,
    processed-content,
  )
}
