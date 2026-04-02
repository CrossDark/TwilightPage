// 数学公式模板 / Math template
#let template-math(content) = {
  // 设置公式编号格式 / Set equation numbering format
  set math.equation(numbering: "(1)")

  // 行内公式 / Inline equation
  show math.equation.where(block: false): it => {
    if target() == "html" {
      html.span(role: "math", html.frame(it))
    } else {
      it
    }
  }

  // 块级公式 / Block equation
  show math.equation.where(block: true): it => {
    if target() == "html" {
      html.figure(role: "math", html.frame(it))
    } else {
      it
    }
  }

  content
}
