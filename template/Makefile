# 查找 content/ 中路径不以下划线开头的所有 .typ 文件
# Find all .typ files in content/ that don't start with an underscore in their path
TYP_FILES := $(shell find content -name '*.typ' -not -path '*/_*')

# 生成 _site/ 中对应的 HTML 文件路径
# Generate corresponding HTML file paths in _site/
HTML_FILES := $(patsubst content/%.typ,_site/%.html,$(TYP_FILES))

# 主要目标 'html' 依赖于所有生成的 HTML 文件和资源
# The main target 'html' depends on all generated HTML files and assets
html: $(HTML_FILES) assets

# 将 .typ 文件编译为 .html 文件的模式规则
# $< 是第一个先决条件（.typ 文件）
# $@ 是目标（.html 文件）
# $(@D) 是目标的目录部分
# Pattern rule to compile .typ files to .html files
# $< is the first prerequisite (the .typ file)
# $@ is the target (the .html file)
# $(@D) is the directory part of the target
_site/%.html: content/%.typ
	@mkdir -p $(@D)
	typst compile --root .. --features html --format html $< $@

# 复制资源文件到构建目录 / Copy assets to build directory
assets:
	@mkdir -p _site/assets
	@cp -r assets/* _site/assets/
	@cp -r ../src/css/* _site/assets/

# 清理规则，删除生成的文件 / A clean rule to remove generated files
clean:
	rm -rf _site/*

.PHONY: html clean assets
