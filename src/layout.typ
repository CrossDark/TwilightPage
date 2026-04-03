// ============================================
// 布局工具模块 / Layout Utilities Module
// ============================================
// 提供页面布局相关的工具函数，包括边注、全宽内容、嵌套缩进等。
// Provides utility functions for page layout, including margin notes, full-width content, nested indentation, etc.

// TODO: 在边注中实现图表和带标题的图表
// TODO: figures and figures with captions inside margin notes

// ============================================
// 辅助函数 / Helper Functions
// ============================================

// 检查元素是否为标题 / Check if element is a heading
#let is-heading(it) = {
  it.func() == heading
}

// 递归包装函数 / Recursive wrapper function
// 根据标题深度对内容进行分组和包装
// Groups and wraps content based on heading depth
//
// 参数 / Parameters:
//   - body: 主体内容 / Body content
//   - depth: 要包装的标题深度 / Heading depth to wrap (默认 / default: 1)
//   - wrapper: 包装函数 / Wrapper function
#let wrapp-section(
  body,
  depth: 1,
  wrapper: none,
) = {
  // 当前部分的标题 / Current section heading
  let heading = none
  // 当前部分的内容 / Current section content
  let section = ()

  for it in body.at("children", default: ()) {
    let x = it.func()
    
    if (is-heading(it) and it.fields().at("depth") < depth) {
      // 如果是深度小于指定深度的标题 / If heading depth is less than specified
      if heading != none {
        wrapper(heading: heading, section: section.join())
        heading = none
        section = ()
      }
      it
    } else if is-heading(it) and it.fields().at("depth") == depth {
      // 如果是指定深度的标题 / If heading matches specified depth
      if heading != none {
        wrapper(heading, section.join())
        heading = none
        section = ()
      }
      heading = it
    } else if heading != none {
      // 继续当前部分 / Continue current section
      section.push(it)
    } else {
      // 不在任何部分内 / Not in any section
      it
    }
  }

  // 完成最后一部分 / Complete last section
  if heading != none {
    wrapper(heading, section.join())
  }
}

// 嵌套缩进块 / Nested indentation block
// 根据标题层级创建缩进效果，带有左侧边框线
// Creates indentation effect based on heading levels with left border line
//
// 参数 / Parameters:
//   - body: 主体内容 / Body content
//   - depth: 起始深度 / Starting depth (默认 / default: 1)
//   - line-color: 边框线颜色 / Border line color
//   - inset: 缩进距离 / Indentation distance (默认 / default: 1em)
#let nest-block(body, depth: 1, line-color: white, inset: 1em) = {
  wrapp-section(
    depth: depth,
    wrapper: (heading, content) => {
      block(
        stroke: (left: line-color),
        inset: (left: inset),
      )[
        #heading
        #nest-block(depth: depth + 1, content, line-color: line-color, inset: inset)
      ]
    }
  )[#body]
}

// 边注 / Margin Note
// 在页面边距中显示内容，符合 Tufte 风格的设计理念。
// Displays content in the page margin, following Tufte-style design principles.
//
// 参数 / Parameters:
//   - content: 边注内容 / Margin note content
// 返回 / Returns: HTML span 元素，带有 marginnote 类 / HTML span element with marginnote class
#let margin-note(content) = {
  html.span(class: "marginnote", content)
}

// TODO: 实现 <figure class="fullwidth">
// 可能需要内省或支持 `set html.figure(class: "fullwidth")`
// TODO: implement <figure class="fullwidth">
// possible requires introspection or `set html.figure(class: "fullwidth")` support

// 全宽内容 / Full Width Content
// 使内容跨越整个页面宽度，突破正文区域的边距限制。
// Makes content span the full page width, breaking out of the main text area margins.
//
// 参数 / Parameters:
//   - content: 要显示为全宽的内容 / Content to display at full width
// 返回 / Returns: HTML div 元素，带有 fullwidth 类 / HTML div element with fullwidth class
#let full-width(content) = {
  html.div(class: "fullwidth", content)
}
