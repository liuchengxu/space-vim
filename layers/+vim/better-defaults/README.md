# Better-defaults layer

**Table of Contents**

<!-- vim-markdown-toc GFM -->
* [Description](#description)
* [Install](#install)
* [Key Bindings](#key-bindings)
    * [Buffer](#buffer)
    * [Window](#window)

<!-- vim-markdown-toc -->

## Description

## Install

## Key Bindings

Key Binding            | Mode   | Description
:---:                  | :---:  | :---:
<kbd>SPC q</kbd>       | Normal | 退出 (quit)
<kbd>SPC Q</kbd>       | Normal | 不保存直接退出
<kbd>SPC d</kbd>       | Normal | 向下 (down) 移动半屏
<kbd>SPC u</kbd>       | Normal | 向上 (up) 移动半屏
<kbd>SPC '</kbd>       | Normal | 在 vim 中打开shell
<kbd>SPC s c</kbd>     | Normal | 撤销搜索结果高亮
<kbd>SPC t p</kbd>     | Normal | 粘贴模式开关 (toggle pastemode)
<kbd>Ctrl j</kbd>      | Insert | j, 向下移动
<kbd>Ctrl k</kbd>      | Insert | k, 向上移动
<kbd>Ctrl h</kbd>      | Insert | h, 向左移动
<kbd>Ctrl l</kbd>      | Insert | l, 向右移动
<kbd>jj</kbd>          | Insert | <kbd><Esc></kbd>
<kbd>jk</kbd>          | Insert | <kbd><Esc></kbd>
<kbd>kk</kbd>          | Insert | <kbd><Esc></kbd>
<kbd>v</kbd>           | Visual | <kbd><Esc></kbd>
<kbd>U<kbd>            | Normal | 重做， redo (对应 <kbd>u</kbd> 为撤销，undo)
<kbd>H<kbd>            | Normal | 光标跳转到行首
<kbd>L<kbd>            | Normal | 光标跳转到行尾
<kbd>Y<kbd>            | Normal | 从光标处复制到行尾
<kbd>SPC f s</kbd>     | Normal |  保存（save）文件
<kbd>SPC f [1-9]</kbd> | Normal | 设置折叠 (fold) 层次，`f 0` 相当于全部折叠, `f 9` 相当于取消折叠全部展开

### Buffer

Key Binding | Mode   | Description
:---:       | :---:  | :---:
<kbd>SPC [1-9]</kbd> | Normal | 切换至对应编号[1-9]对应缓冲区
`SPC b p`   | Normal | 上一个 (previous) 缓冲区
`SPC b n`   | Normal | 下一个 (next) 缓冲区
`SPC b d`   | Normal | 删除 (delete) 当前缓冲区
`SPC b k`   | Normal | 杀掉 (kill) 缓冲区
`SPC b b`   | Normal | 显示缓冲区 (buffer)

### Window

Key Binding | Mode   | Description
:---:       | :---:  | :---:
`SPC w j`   | Normal | 移动至下方窗口
`SPC w k`   | Normal | 移动至上方窗口
`SPC w h`   | Normal | 移动至左边窗口
`SPC w l`   | Normal | 移动至右边窗口
`SPC w v`   | Normal | 竖直分割窗口， 等同于 `SPC w |`
`SPC w 2`   | Normal | 将窗口分割为两列，等同于`SPC w v`
`SPC w s`   | Normal | 水平分割窗口， 等同于 `SPC w -`
`SPC w d`   | Normal | 关闭 (cancel) 当前窗口
`SPC w q`   | Normal | 退出 (quit) 当前窗口，若是最后一个窗口则退出vim
`SPC w w`   | Normal | 在所有窗口中循环移动
`SPC w r`   | Normal | 向右或向下方交换 (replace) 窗口



