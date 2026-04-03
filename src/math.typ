// ============================================
// 数学公式处理模块 / Math Formula Processing Module
// ============================================
// 处理数学公式的渲染，支持行内公式和块级公式，针对 HTML 输出进行优化。
// Handles rendering of mathematical equations, supporting inline and block equations,
// optimized for HTML output.

// 数学公式模板 / Math Template
// 应用数学公式的样式和渲染规则。
// Applies styling and rendering rules for mathematical equations.
//
// 参数 / Parameters:
//   - content: 文档内容 / Document content
// 返回 / Returns: 处理后的内容 / Processed content
#let template-math(content) = {
  // 设置公式编号格式为 (1), (2), (3)...
  // Set equation numbering format to (1), (2), (3)...
  set math.equation(numbering: "(1)")

  // 行内公式处理 / Inline Equation Processing
  // 将行内数学公式渲染为带有 role="math" 的 HTML span，提高可访问性。
  // Renders inline math equations as HTML spans with role="math" for better accessibility.
  show math.equation.where(block: false): it => {
    if target() == "html" {
      // 使用 html.frame 包装公式内容 / Wrap equation content with html.frame
      html.span(role: "math", html.frame(it))
    } else {
      // 非 HTML 目标保持原样 / Keep as-is for non-HTML targets
      it
    }
  }

  // 块级公式处理 / Block Equation Processing
  // 将块级数学公式渲染为带有 role="math" 的 HTML figure 元素。
  // Renders block math equations as HTML figure elements with role="math".
  show math.equation.where(block: true): it => {
    if target() == "html" {
      // 使用 figure 元素包装，符合语义化 HTML 标准
      // Wrap with figure element for semantic HTML compliance
      html.figure(role: "math", html.frame(it))
    } else {
      // 非 HTML 目标保持原样 / Keep as-is for non-HTML targets
      it
    }
  }

  content
}
