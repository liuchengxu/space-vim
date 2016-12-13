# Better-defaults layer

## Table of Contents

<!-- vim-markdown-toc GFM -->
* [Description](#description)
* [Install](#install)
* [Key Bindings](#key-bindings)
    * [Basic](#basic)
    * [Buffer](#buffer)
    * [Window](#window)
    * [easy-motion](#easy-motion)
    * [Others](#others)

<!-- vim-markdown-toc -->

## Description

这个 Layer 涉及比较多的基本操作，但是记忆起来应当不是很复杂，快捷键一般控制在两个。

## Install

已默认启用。

## Key Bindings

### Basic

Key Binding            | Mode   | Description
:---:                  | :---:  | :---:
<kbd>SPC q</kbd>       | Normal | 退出 (**q**uit)
<kbd>SPC Q</kbd>       | Normal | 不保存直接退出
<kbd>SPC d</kbd>       | Normal | 向下 (**d**own) 移动半屏
<kbd>SPC u</kbd>       | Normal | 向上 (**u**p) 移动半屏
<kbd>SPC '</kbd>       | Normal | 在 vim 中打开 shell
<kbd>SPC s c</kbd>     | Normal | 撤销搜索结果高亮 (**s**earch result highlight *c*ountermand)
<kbd>SPC t p</kbd>     | Normal | 粘贴模式开关 (**t**oggle **p**astemode)
<kbd>Ctrl j</kbd>      | Insert | j, 向下移动
<kbd>Ctrl k</kbd>      | Insert | k, 向上移动
<kbd>Ctrl h</kbd>      | Insert | h, 向左移动
<kbd>Ctrl l</kbd>      | Insert | l, 向右移动
<kbd>jj</kbd>          | Insert | <kbd>\<Esc></kbd>
<kbd>jk</kbd>          | Insert | <kbd>\<Esc></kbd>
<kbd>kk</kbd>          | Insert | <kbd>\<Esc></kbd>
<kbd>v</kbd>           | Visual | <kbd>\<Esc></kbd>
<kbd>U</kbd>           | Normal | 重做， redo (对应 <kbd>u</kbd> 为撤销，undo)
<kbd>H</kbd>           | Normal | 光标跳转到行首
<kbd>L</kbd>           | Normal | 光标跳转到行尾
<kbd>Y</kbd>           | Normal | 从光标处复制到行尾
<kbd>SPC f s</kbd>     | Normal | 保存文件 (**f**ile **s**ave)
<kbd>SPC f [1-9]</kbd> | Normal | 设置折叠 (**f**old) 层次，`f 0` 相当于全部折叠, `f 9` 相当于取消折叠全部展开

### Buffer

Key Binding          | Mode   | Description
:---:                | :---:  | :---:
<kbd>SPC [1-9]</kbd> | Normal | 切换至对应编号[1-9]对应缓冲区
<kbd>SPC b p</kbd>   | Normal | 上一个 (**p**revious) 缓冲区
<kbd>SPC b n</kbd>   | Normal | 下一个 (**n**ext) 缓冲区
<kbd>\<Tab></kbd>    | Normal | 切换 buffer, 等同于 <kbd>SPC b n</kbd>
<kbd>SPC b d</kbd>   | Normal | 删除 (**d**elete) 当前缓冲区
<kbd>SPC b k</kbd>   | Normal | 杀掉 (**k**ill) 缓冲区

### Window

Key Binding        | Mode   | Description
:---:              | :---:  | :---:
<kbd>SPC w j</kbd> | Normal | 移动至下方窗口
<kbd>SPC w k</kbd> | Normal | 移动至上方窗口
<kbd>SPC w h</kbd> | Normal | 移动至左侧窗口
<kbd>SPC w l</kbd> | Normal | 移动至右侧窗口
<kbd>SPC w J</kbd> | Normal | 向下扩大当前窗口
<kbd>SPC w K</kbd> | Normal | 向上扩大当前窗口
<kbd>SPC w H</kbd> | Normal | 向右扩大当前窗口
<kbd>SPC w L</kbd> | Normal | 向左扩大当前窗口
<kbd>SPC w v</kbd> | Normal | 竖直分割窗口， 等同于 `SPC w |`
<kbd>SPC w 2</kbd> | Normal | 将窗口分割为两列，等同于`SPC w v`
<kbd>SPC w s</kbd> | Normal | 水平分割窗口， 等同于 `SPC w -`
<kbd>SPC w d</kbd> | Normal | 关闭 (cancel, 记 **d**elete) 当前窗口
<kbd>SPC w q</kbd> | Normal | 退出 (**q**uit) 当前窗口，若是最后一个窗口则退出vim
<kbd>SPC w w</kbd> | Normal | 在所有窗口中循环移动
<kbd>SPC w r</kbd> | Normal | 向右或向下方交换 (**r**eplace) 窗口
<kbd>SPC w m</kbd> | Normal | GUI 环境下 vim 窗口最大化 (**m**aximum) 开关

### easy-motion

Key Binding          | Mode   | Description
:---:                | :---:  | :---:
<kbd>SPC j w         | Nomral | 单词跳转 (jump to word)
<kbd>SPC j l         | Nomral | 行间跳转 (jump to line)
<kbd>SPC SPC w</kbd> | Normal | 快速词间移动(向前)
<kbd>SPC SPC b</kbd> | Normal | 快速词间移动 (向后)
<kbd>SPC SPC s</kbd> | Normal | 快速字符搜索 (双向)
<kbd>SPC SPC f</kbd> | Normal | 快速字符搜索 (向前)
<kbd>SPC SPC j</kbd> | Normal | 快速行间移动 (向下)
<kbd>SPC SPC k</kbd> | Normal | 快速行间移动 (向上)

### Others

Key Binding          | Mode   | Description
:---:                | :---:  | :---:
<kbd>SPC x d</kbd>   | Normal | 去掉行尾多余空格 (te**x**t **d**elete)
<kbd>SPC f R</kbd>   | Normal | 重新加载 .vimrc (**f**ile **R**esource)
<kbd>SPC b h</kbd>   | Normal | 主 buffer (**b**uffer **h**ome)
