// TODO: 在边注中实现图表和带标题的图表
// TODO: figures and figures with captions inside margin notes

// 边注 / Margin note
#let margin-note(content) = {
  html.span(class: "marginnote", content)
}

// TODO: 实现 <figure class="fullwidth">
// 可能需要内省或支持 `set html.figure(class: "fullwidth")`
// TODO: implement <figure class="fullwidth">
// possible requires introspection or `set html.figure(class: "fullwidth")` support

// 全宽 / Full width
#let full-width(content) = {
  html.div(class: "fullwidth", content)
}
