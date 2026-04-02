#import "math.typ": template-math
#import "refs.typ": template-refs
#import "notes.typ": template-notes
#import "figures.typ": template-figures
#import "layout.typ": full-width, margin-note

#let make-header(links) = html.header(
  if links != none {
    html.nav(
      for (href, title) in links {
        html.a(href: href, title)
      },
    )
  },
)

#let twilightpage-web(
  header-links: none,
  title: "TwilightPage",
  lang: "en",
  css: (
    "https://cdnjs.cloudflare.com/ajax/libs/tufte-css/1.8.0/tufte.min.css",
    "/assets/tufted.css",
    "/assets/custom.css",
  ),
  content,
) = {
  // 应用样式 / Apply styling
  show: template-math
  show: template-refs
  show: template-notes
  show: template-figures

  set text(lang: lang)

  html.html(
    lang: lang,
    {
      // 头部 / Head
      html.head({
        html.meta(charset: "utf-8")
        html.meta(name: "viewport", content: "width=device-width, initial-scale=1")
        html.title(title)

        // 样式表 / Stylesheets
        for (css-link) in css {
          html.link(rel: "stylesheet", href: css-link)
        }
      })

      // 主体 / Body
      html.body({
        // 添加网站头部 / Add website header
        make-header(header-links)

        // 主内容 / Main content
        html.article(
          html.section(content),
        )
      })
    },
  )
}
