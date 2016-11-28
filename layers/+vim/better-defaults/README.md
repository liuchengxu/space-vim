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

Key Binding   | Mode   | Description
:---:         | :---:  | :---:
`SPC q`       | Normal | 退出 (quit)
`SPC Q`       | Normal | 不保存直接退出
`SPC d`       | Normal | 向下 (down) 移动半屏
`SPC u`       | Normal | 向上 (up) 移动半屏
`SPC '`       | Normal | 在 vim 中打开shell
`SPC s c`     | Normal | 撤销搜索结果高亮
`SPC t p`     | Normal | 粘贴模式开关 (toggle pastemode)
`Ctrl j`      | Insert | j, 向下移动
`Ctrl k`      | Insert | k, 向上移动
`Ctrl h`      | Insert | h, 向左移动
`Ctrl l`      | Insert | l, 向右移动
`jj`          | Insert | `<Esc>`
`jk`          | Insert | `<Esc>`
`kk`          | Insert | `<Esc>`
`;;`          | Insert | `<Esc>`
`v`           | Visual | `<Esc>`
`U`           | Normal | 重做， redo (对应 `u` 为撤销，undo)
`H`           | Normal | 光标跳转到行首
`L`           | Normal | 光标跳转到行尾
`Y`           | Normal | 从光标处复制到行尾
`SPC f s`     | Normal |  保存（save）文件
`SPC f [1-9]` | Normal | 设置折叠 (fold) 层次，`f 0` 相当于全部折叠, `f 9` 相当于取消折叠全部展开

### Buffer

Key Binding | Mode   | Description
:---:       | :---:  | :---:
`SPC [1-9]` | Normal | 切换至对应编号[1-9]对应缓冲区
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



