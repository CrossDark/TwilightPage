#import "../index.typ": template, twilightpage
#show: template.with(title: "Quick Start")

= Quick Start

== Installation

To initialize a new project using the `twilightpage` template, run the following command in your terminal:

```sh
typst init @preview/twilightpage:0.1.1 my-website
cd my-website
```

== Building

The template includes a `Makefile` to automate the build process. To build the website, run:

```sh
make html
```

This command compiles all `.typ` files in the `content/` directory into HTML files in the `_site/` directory.
