// ============================================
// 图表处理模块 / Figure Processing Module
// ============================================
// 处理图表及其标题的渲染，将标题显示为边注（margin note），符合 Tufte 风格。
// Handles rendering of figures and their captions, displaying captions as margin notes
// following Tufte-style design.

// 导入布局工具 / Import layout utilities
#import "layout.typ": margin-note

// 图表模板 / Figure Template
// 应用图表的样式和渲染规则，将图表标题移至边注。
// Applies styling and rendering rules for figures, moving captions to margin notes.
//
// 参数 / Parameters:
//   - content: 文档内容 / Document content
// 返回 / Returns: 处理后的内容 / Processed content
#let template-figures(content) = {
  // 重新定义图表标题以使用边注 / Redefine figure caption to use marginnote
  // 标题格式: "Figure 1: 标题内容" / Caption format: "Figure 1: Caption content"
  show figure.caption: it => html.span(
    class: "marginnote",
    it.supplement + sym.space.nobreak + it.counter.display() + it.separator + it.body,
  )

  // 重新定义图表本身的渲染 / Redefine figure rendering itself
  // 在 HTML 输出中，将标题放在图表主体之前，并包装在 figure 元素中。
  // In HTML output, place caption before figure body and wrap in figure element.
  show figure: it => if target() == "html" {
    html.figure({
      it.caption  // 边注形式的标题 / Caption as margin note
      it.body     // 图表主体内容 / Figure body content
    })
  }

  content
}
