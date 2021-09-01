# SDScom XSL
Style sheet documents of SDScom.

## About
`sdscom-xsl` is a GitHub repository for creating new SDScom-powered HTML, maintained by author @EpicKris. You can also use it as your own SDScom XML prototyping sandbox. It's built with SDScom XML v4.4 with plans to update for v5.

## What's included
- XSL (`SDSComXSL_XX.xsl`) to demonstrate how to include SDScom XSL.
- Includes [Bootstrap](https://getbootstrap.com) (currently using v5) source files via npm.
- npm scripts (see `package.json`) for compiling and autoprefixing Sass, watching for changes, and starting a basic local server.
- Stylesheet (`scss/starter.scss`) to include and customize Bootstrap.

XSL files with language suffix offer usable transformations, with `SDSComXSL_XX.xsl` being the main file (insert uppercase ISO 639-1 language code for `XX`).
Add:
`<?xml-stylesheet type="text/xsl" href="https://raw.githubusercontent.com/EpicKris/esdscom-xsl/main/SDSComXSL_XX.xsl"?>`
to the XML file(s) to facilitate automatic transformation, for example.

Tested with Saxon JS v2.2 for transformation.