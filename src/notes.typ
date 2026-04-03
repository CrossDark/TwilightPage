// ============================================
// 脚注处理模块 / Footnote Processing Module
// ============================================
// 处理脚注的渲染，将脚注内容显示为边注（margin note），实现双向链接。
// Handles rendering of footnotes, displaying footnote content as margin notes
// with bidirectional linking.

// 脚注模板 / Footnote Template
// 将传统脚注转换为 Tufte 风格的边注，带有可点击的引用链接。
// Converts traditional footnotes to Tufte-style margin notes with clickable reference links.
//
// 参数 / Parameters:
//   - content: 文档内容 / Document content
// 返回 / Returns: 处理后的内容 / Processed content
#let template-notes(content) = {
  // 自定义脚注渲染规则 / Custom footnote rendering rule
  show footnote: it => {
    if target() == "html" {
      // 获取脚注编号 / Get footnote number
      let number = counter(footnote).display(it.numbering)
      // 定义脚注内容的 ID（用于锚点跳转）/ ID for footnote content (for anchor jumping)
      let fn-id = "fn-" + number
      // 定义引用的 ID（用于返回链接）/ ID for reference (for backlink)
      let ref-id = "fnref-" + number

      // 正文中的数字引用 / Numeric references in the main text
      // 显示为上标链接，点击跳转到边注中的脚注内容
      // Displayed as superscript link, clicking jumps to footnote content in margin
      html.sup(class: "footnote-ref", html.a(
        class: "footnote-ref-link",
        href: "#" + fn-id,    // 链接到脚注内容 / Link to footnote content
        id: ref-id,           // 设置引用锚点 ID / Set reference anchor ID
        number,               // 显示编号 / Display number
      ))

      // 边注中的脚注内容 / Footnote content in the margin
      // 在边注中显示脚注编号（可点击返回正文）和脚注文本
      // Display footnote number (clickable to return to main text) and footnote text in margin
      html.span(
        class: "marginnote",
        id: fn-id,  // 设置脚注内容锚点 ID / Set footnote content anchor ID
        // 边注中的编号也是可点击的链接，点击返回正文引用处
        // Number in margin is also a clickable link to return to reference in main text
        html.sup(html.a(class: "footnote-ref-link", href: "#" + ref-id, number)) + [ ] + it.body,
      )
    }
  }
  content
}

