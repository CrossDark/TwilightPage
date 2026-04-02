#import "layout.typ": margin-note

// 图表模板 / Figure template
#let template-figures(content) = {
  // 重新定义图表标题以使用边注 / Redefine figure caption to use marginnote
  show figure.caption: it => html.span(
    class: "marginnote",
    it.supplement + sym.space.nobreak + it.counter.display() + it.separator + it.body,
  )

  // 重新定义图表本身 / Redefine figure itself
  show figure: it => if target() == "html" {
    html.figure({
      it.caption
      it.body
    })
  }

  content
}
