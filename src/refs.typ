// ============================================
// 引用和交叉引用处理模块 / Reference and Cross-Reference Processing Module
// ============================================
// 处理文档中的引用和交叉引用，支持公式引用、标题引用等。
// Handles references and cross-references in documents, supporting equation references,
// heading references, etc.

// 引用模板 / Reference Template
// 自定义各类引用的渲染方式。
// Customizes rendering of various types of references.
//
// 参数 / Parameters:
//   - content: 文档内容 / Document content
// 返回 / Returns: 处理后的内容 / Processed content
#let template-refs(content) = {
  // 自定义引用渲染规则 / Custom reference rendering rule
  show ref: it => {
    // 别名定义，简化后续代码 / Aliases for cleaner code
    let eq = math.equation    // 公式元素类型 / Equation element type
    let el = it.element       // 被引用的元素 / Referenced element

    // 公式引用处理 / Equation Reference Processing
    // 当引用目标是数学公式时，使用公式自身的编号格式显示引用。
    // When the reference target is a math equation, display using the equation's own numbering format.
    if el != none and el.func() == eq {
      // 创建指向公式位置的链接，显示公式编号
      // Create link to equation location, displaying equation number
      return link(el.location(), numbering(
        el.numbering,                       // 使用公式的编号格式 / Use equation's numbering format
        ..counter(eq).at(el.location()),    // 获取公式在目标位置的计数器值 / Get counter value at target location
      ))
    }

    // 标题引用处理 / Heading Reference Processing
    // 当引用目标是标题时，用引号包裹标题文本显示。
    // When the reference target is a heading, display with the heading text wrapped in quotes.
    if el != none and el.func() == heading {
      // 使用智能引号包裹标题内容 / Wrap heading content with smart quotes
      return smartquote() + it.element.body + smartquote()
    }

    it
  }

  content
}
