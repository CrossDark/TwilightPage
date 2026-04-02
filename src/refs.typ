// 引用模板 / Reference template
#let template-refs(content) = {
  show ref: it => {
    // 别名 / Aliases
    let eq = math.equation
    let el = it.element

    // 公式引用 / Equation reference
    if el != none and el.func() == eq {
      // 覆盖公式引用 / Override equation references.
      return link(el.location(), numbering(
        el.numbering,
        ..counter(eq).at(el.location()),
      ))
    }

    // 标题引用 / Heading reference
    if el != none and el.func() == heading { return smartquote() + it.element.body + smartquote() }

    it
  }

  content
}
