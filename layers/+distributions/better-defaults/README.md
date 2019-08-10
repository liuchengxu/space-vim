# Better-defaults layer

## Table of Contents

<!-- TOC GFM -->

* [Description](#description)
* [Install](#install)
* [Key Bindings](#key-bindings)
  * [Basic](#basic)
  * [Buffer](#buffer)
  * [Tab](#tab)
  * [Window](#window)
  * [Others](#others)
* [Related Projects](#related-projects)

<!-- /TOC -->


## Description

This layer has defined a ton of fundamental key bindings. You can see the keybings.vim for more information and modify the existing key mappings in `UserConfig()`.

这个 Layer 涉及比较多的基本操作，但是记忆起来应当不是很复杂，快捷键一般控制在两个。如果想要修改已有的键位，可在 `UserConfig()` 中进行调整。

## Install

This layer has been enabled as the default layer. 已默认启用。

## Key Bindings

### Basic

Key Binding            | Mode       | Description
:---:                  | :---:      | :---:
<kbd>SPC q</kbd>       | Normal     | **q**uit, 退出
<kbd>SPC Q</kbd>       | Normal     | quit without saving, 不保存强制退出
<kbd>SPC d</kbd>       | Normal     | go **d**own half page, 向下移动半屏
<kbd>SPC u</kbd>       | Normal     | go **u**p half page, 向上移动半屏
<kbd>SPC '</kbd>       | Normal     | open shell, 在 vim 中打开 shell
<kbd>SPC s c</kbd>     | Normal     | **s**earch result highlight *c*ountermand, 取消搜索结果高亮
<kbd>SPC t p</kbd>     | Normal     | **t**oggle **p**astemode, 粘贴模式开关
<kbd>Ctrl j</kbd>      | **Insert** | j, 向下移动
<kbd>Ctrl k</kbd>      | **Insert** | k, 向上移动
<kbd>Ctrl h</kbd>      | **Insert** | h, 向左移动
<kbd>Ctrl l</kbd>      | **Insert** | l, 向右移动
<kbd>jj</kbd>          | **Insert** | <kbd>\<Esc></kbd>
<kbd>jk</kbd>          | **Insert** | <kbd>\<Esc></kbd>
<kbd>kk</kbd>          | **Insert** | <kbd>\<Esc></kbd>
<kbd>v</kbd>           | **Visual** | <kbd>\<Esc></kbd>
<kbd>U</kbd>           | Normal     | redo, 重做(对应 <kbd>u</kbd> 为撤销，undo)
<kbd>H</kbd>           | Normal     | beginning of line, 光标跳转到行首
<kbd>L</kbd>           | Normal     | end of line, 光标跳转到行尾
<kbd>Y</kbd>           | Normal     | yank from cursor to end of line, 从光标处复制到行尾
<kbd>SPC f s</kbd>     | Normal     | **f**ile **s**ave, 保存文件
<kbd>SPC f [1-9]</kbd> | Normal     | **f**old level, 设置折叠层次，`f 0` 相当于全部折叠, `f 9` 相当于取消折叠全部展开

### Buffer

Key Binding          | Mode   | Description
:---:                | :---:  | :---:
<kbd>SPC b p</kbd>   | Normal | **p**revious **b**uffer, 上一个缓冲区
<kbd>SPC b n</kbd>   | Normal | **n**ext **b**uffer, 下一个缓冲区
<kbd>SPC b d</kbd>   | Normal | **d**elete current buffer, 删除当前缓冲区
<kbd>SPC b k</kbd>   | Normal | **k**ill current buffer, 杀掉当前缓冲区
<kbd>[ b</kbd>       | Normal | previous buffer, 上一个缓冲区
<kbd>] b</kbd>       | Normal | next buffer, 下一个缓冲区

### Tab

Key Binding          | Mode   | Description
:---:                | :---:  | :---:
<kbd>[ t</kbd>       | Normal | previous tab
<kbd>] t</kbd>       | Normal | next tab

### Window

Key Binding        | Mode   | Description
:---:              | :---:  | :---:
<kbd>SPC [1-9]</kbd> | Normal | switch to window with number [1-9], 切换至对应编号[1-9]对应的 window
<kbd>SPC w j</kbd> | Normal | window-down, 移动至下方窗口
<kbd>SPC w k</kbd> | Normal | window-up, 移动至上方窗口
<kbd>SPC w h</kbd> | Normal | window-left, 移动至左侧窗口
<kbd>SPC w l</kbd> | Normal | window-right, 移动至右侧窗口
<kbd>SPC w J</kbd> | Normal | 向下扩大当前窗口
<kbd>SPC w K</kbd> | Normal | 向上扩大当前窗口
<kbd>SPC w H</kbd> | Normal | 向右扩大当前窗口
<kbd>SPC w L</kbd> | Normal | 向左扩大当前窗口
<kbd>SPC w v</kbd> | Normal | split-window-right, 竖直分割窗口， 等同于 `SPC w |`
<kbd>SPC w 2</kbd> | Normal | layout-double-columns, 将窗口分割为两列，等同于`SPC w v`
<kbd>SPC w s</kbd> | Normal | split-window-below, 水平分割窗口， 等同于 `SPC w -`
<kbd>SPC w d</kbd> | Normal | delete-window, 关闭 (cancel, 记 **d**elete) 当前窗口
<kbd>SPC w q</kbd> | Normal | quit-window, 退出 (**q**uit) 当前窗口，若是最后一个窗口则退出vim
<kbd>SPC w w</kbd> | Normal | other-window, 在所有窗口中循环移动
<kbd>SPC w r</kbd> | Normal | window-replace, 向右或向下方交换 (**r**eplace) 窗口
<kbd>SPC w m</kbd> | Normal | GUI 环境下 vim 窗口最大化 (**m**aximum) 开关

### Others

Key Binding          | Mode   | Description
:---:                | :---:  | :---:
<kbd>SPC x d</kbd>   | Normal | delete trailing whitespace, 去掉行尾多余空格 (te**x**t **d**elete)
<kbd>SPC f R</kbd>   | Normal | reload .vimrc, 重新加载 .vimrc (**f**ile **R**esource)
<kbd>SPC b h</kbd>   | Normal | **b**uffer **h**ome, 主 buffer

## Related Projects

- [vim-easyclip](https://github.com/svermeulen/vim-easyclip)
- [vim-markbar](https://github.com/Yilin-Yang/vim-markbar)
