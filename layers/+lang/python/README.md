# Python layer


**Table of Contents**

<!-- vim-markdown-toc GFM -->
* [Description](#description)
* [Install](#install)
* [Key Bindings](#key-bindings)

<!-- vim-markdown-toc -->

## Description

如果启用 `syntax-checking` Layer, 在语法检查时 vim8 使用 ale, 否则使用 syntastic. 需要安装 flake8 这一语法检查工具.

## Install

在 .spacevim UserInit() 中启用 `Layer 'python'`.

## Key Bindings

Key Binding    | Mode   | Description
:---:          | :---:  | :---:
<kbd>F5</kbd>  | Normal | 运行
<kbd>, =</kbd> | Normal | yapf 格式化代码
