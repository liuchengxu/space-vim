![space-vim](doc/img/space-vim.png)
======================================

:us: [English](doc/tutorial_en.md)

:warning: 目前文档稍落后，如有内容不符当前配置，请以 vim 配置为准，文档将会随后更新。

**Table of Contents**

<!-- vim-markdown-toc GFM -->
* [前言](#前言)
    * [安装](#安装)
        * [Linux/macOS](#linuxmacos)
        * [Windows](#windows)
        * [注意事项](#注意事项)
    * [理解 vim 键位](#理解-vim-键位)
* [基本篇](#基本篇)
    * [vim-better-default](#vim-better-default)
        * [基本操作](#基本操作)
        * [缓冲区](#缓冲区)
        * [文件与折叠](#文件与折叠)
        * [窗口](#窗口)
* [插件篇](#插件篇)
    * [vim-airline](#vim-airline)
    * [space-vim-dark](#space-vim-dark)
    * [vim-colorschemes](#vim-colorschemes)
    * [nerdtree](#nerdtree)
        * [nerdtree-git-plugin](#nerdtree-git-plugin)
        * [vim-nerdtree-syntax-highlight](#vim-nerdtree-syntax-highlight)
    * [tabular](#tabular)
    * [vim-easymotion](#vim-easymotion)
    * [fzf.vim](#fzfvim)
    * [unite.vim](#unitevim)
    * [AsyncRun.vim](#asyncrunvim)
    * [syntastic](#syntastic)
    * [ale](#ale)
    * [YouCompleteMe](#youcompleteme)
* [个性化](#个性化)

<!-- vim-markdown-toc -->

## 前言

首先关于 vim , emacs 与 IDE 之间长久以来的争论这里并不讨论，我不排斥这其中的任何一个，这些工具我都在使用，各有所长，自己用着方便就好。

对 vim 稍微有点了解以后，你会发现配置 vim 在思路上其实很简单，无非是一个 `.vimrc` 文件外加安装各种 vim 插件.不过从一个新手开始的话还是挺折腾的.毕竟，默认情况下连 `.vimrc` 这个文件都没有，需要自行创建。

其实现在已经有很多有名气的 vim 配置，但还是自己 “孕育” 而成的才能知根知底，追求 “心中有剑” 而不仅是 “手中有剑”。我建议您在初期的时候可以试一下那些一流的成品配置， 我也是这么做的，我玩过看过 github 上很多有名的配置, 也 ”steal“ 了很多东西。
不过在有了一定基础后，还是自己打造一个属于自己的配置更称心如意。

接下来的部分只是大致介绍一下我的想法，很多方面并不会深入探讨，仅以一个 ”用家“ 的身份说几句。希望 space-vim 能对您有所助益, 尤其是对于初学者而言希望您能在本文有所收获。

space-vim 的键位绑定启发自 spacemacs，这也是为什么叫做 space-vim. 我同时使用 spacemacs 与 vim, 在桌面环境时倾向于 spacemacs, 终端环境时倾向于 vim. 有了 vim 的基础， 也帮助我能够快速上手 spacemacs.

![screenshot](doc/img/screenshot.png)

### 安装

#### Linux/macOS

对于 linux and macOS, 可以通过 curl 或 wget 执行执行下面的命令进行快速安装。

- curl

    ```sh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"
    ```

- wget

    ```sh
    sh -c "$(wget -qO- https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"
    ```

#### Windows

On the way.......

#### 注意事项

在安装 vim 时, 因为不太熟悉可能会走一条捷径， 贪图一个简单的安装命令就搞定, 比如 ubuntu 下 `sudo apt install vim`。不过后期可能会因为缺少某些功能而发生一些问题。 因此， 在前期安装 vim 时最好就将这些问题搞定, 比如编译支持 python 的vim, 因为 后面的插件 YouCompleteMe 需要这一特性.

mac 下使用 brew 安装的话非常方便， 可以使用 `brew info vim` 看有哪些安装选项，并在安装时指定编译选项：

```sh
brew install vim --with-lua --with-python3 --with-override-system-vi
```
其他平台下，网络上有很多指引，这里不再赘述。

另外，有些插件用到的一些工具也要安装, 下面给出 mac 下的一些安装途径， 其他平台下可对应查找安装途径:

```sh
# tools used by some plugins, you need install them to make all the plugins work
# you can install them with brew painlessly as followed,
# if you use linux or windows, install them on your own, it is not too difficult.

#### syntastic
npm install jsl jshint
brew install flake8
brew install tidy-html5 shellcheck the_silver_searcher

#### tagbar
brew install ctags

#### youcompleteme
brew install cmake
```

### 理解 vim 键位

space-vim 的前缀键设置为空格键， 来源于 spacemacs (当然在此之前已经有很多人设置空格键为 Leader 键，不过其键位设置原则并没有 spacemacs 这么 "科学"). spacemacs 除了外观漂亮，社区驱动等等优点，使用空格键作为 evil 的前缀键可能也是其中一个成功的卖点，因为可以减轻手指负担，毕竟“触手可及”.

```vim
let mapleader="\<Space>"
```

从现代键盘设计的角度看，空格键理应受到优待, 毕竟一个人在 “VIP” 区占了好几个位.即使 HHKB 这样的神器，也有空格键的一席之地.

![hhkb](doc/img/hhkb.jpg)

此外，关于 vim 自身的键位设定，开始时能会觉得很奇怪为什么会这样，因为以前的键盘长这样:

![ancient_keyboard](doc/img/ancient_keyboard.png)

![ADM-3A](doc/img/ADM-3A.png)

看到这个，也就应该能够理解为什么 vim 使用 hjkl 作为方向键，因为物理条件就是这样.

## 基本篇
要想使用 vim 提高效率，记住一些快捷键是必然的. 要想记住一些快捷键，一来是要熟能生巧，二来是要快捷键的安排合理有效，这一点上借鉴了 spacemacs 的 “Mnemonics” 原则，非常易于记忆。

介绍具体的快捷键之前，先来了解一下一些基本概念，比如 buffer, 比如 window, 否则即使知道快捷键是什么也不知道该怎么用.如下图中的红色边框区域都是 window , `<Leader> w` 都是 window 相关操作的快捷键.

比如我们打开了 NERDTree， 那么如何从 NERDTree 中跳回到 buffer 区进行编辑呢？执行窗口操作 `<Leader> w l` 即可跳到左边的 "窗口".
要知道我第一次进入 NERDTree，不知道怎么回到 buffer 时，没办法只能退出 vim 再重新打开文件 -_|.

![intro](doc/img/basical_conceptions.png)

下面是一些使用频率较高的快捷键， 经常使用熟练以后,很多操作已经成为一种下意识地行为.

基本篇大都是一些常用命令的快捷键映射或是默认的一些功能键，由于想精简 `.vimrc` ，于是我将一些常见且不经常改动的设置包装成一个插件进行载入，详情查看下一部分的 [vim-better-default](#vim-better-default)。

下面表格中的快捷键按使用频率排序.

Key Binding    | Description
:---:          | :---:
`<F5>`         | 编译运行c， cpp, python等文件
`%`            | 光标停留在括号处，% 跳转到对应匹配的括号
`Ctrl + c`     | 复制
`Ctrl + v`     | 粘贴
`<Leader> f R` | 重新加载 vimrc
`<Leader> w m` | GUI 环境下为窗口最大化切换开关

### [vim-better-default](https://github.com/liuchengxu/vim-better-default)

之所以会有这个插件, 是开始时觉得 .vimrc 太长了，而且里面有很多都是常见，“人手必备” 的配置，就将这部分内容抽离了出来. 一来能够简化 .vimrc, 二来对于初学者也能有点帮助，至少不用到处零星点点地复制粘贴别人的 .vimrc.

#### 基本操作

Key Binding    | Mode   | Description
:---:          | :---:  | :---:
`<Leader> q`   | Normal | 退出 (quit)
`<Leader> Q`   | Normal | 不保存直接退出
`<Leader> d`   | Normal | 向下 (down) 移动半屏
`<Leader> u`   | Normal | 向上 (up) 移动半屏
`U`            | Normal | 重做， redo (对应 `u` 为撤销，undo)
`H`            | Normal | 光标跳转到行首
`L`            | Normal | 光标跳转到行尾
`Y`            | Normal | 从光标处复制到行尾
`<Leader> '`   | Normal | 在 vim 中打开shell
`<Leader> s c` | Normal | 撤销搜索结果高亮
`<Leader> t p` | Normal | 粘贴模式开关 (toggle pastemode)
`Ctrl j`       | Insert | j, 向下移动
`Ctrl k`       | Insert | k, 向上移动
`Ctrl h`       | Insert | h, 向左移动
`Ctrl l`       | Insert | l, 向右移动
`jj`           | Insert | `<Esc>`
`jk`           | Insert | `<Esc>`
`kk`           | Insert | `<Esc>`
`;;`           | Insert | `<Esc>`
`v`            | Visual | `<Esc>`

`<ESC>` 可能是使用非常多的一个键， 如果将 `jj`, `jk` 几个快速退出插入模式的快捷键熟记于心，应当会减轻不少 "切换" 的压力。 另外，新手请注意默认情况下 `Ctrl + [` 也是 `<ESC>`. 按一下 `v` 进入 `visual mode`, 再按一下离开 `visual mode` 也很方便。

#### 缓冲区

缓冲区 (buffer) 操作， `<Leader> b`.

我最常用的是 `<Leader> [1-9]`， 直接前缀键加上对应的 buffer 编号即可跳转到该 buffer.
在 `spacemacs` 中， `<Leader> [1-9]` 是跳转到对应的 window. 因为 emacs 中 window 是有编号的,而 vim 中 window 没有编号, buffer 有编号. 此外很多人会使用 vim-airline，在 vim-airline 中上方也会显示 buffer 的编号，很方便。

Key Binding       | Description
:---:             | :---:
`<Leader> [1-9]`  | 切换至对应编号[1-9]对应缓冲区
`<Leader> b p	` | 上一个 (previous) 缓冲区
`<Leader> b n	` | 下一个 (next) 缓冲区
`<Leader> b d	` | 删除 (delete) 当前缓冲区
`<Leader> b k`    | 杀掉 (kill) 缓冲区
`<Leader> b b	` | 显示缓冲区 (buffer)

两个删除缓冲区命令的区别：

- `<Leader> b d` : buffer delete.

- `<Leader> b k` (实际映射的是bw) : like bd， but really delete the buffer. Everything related to the buffer is lost. All marks in this buffer become invalid, option settings are lost, etc. Don’t use this unless you know what you are doing.

#### 文件与折叠
文件 (file) 与折叠 (fold)， `<Leader> f`.

打开文件时，可能有些人不太喜欢全部折叠起来，`<Leader> f 9` 即可全部展开.

Key Binding        | Description
:---:              | :---:
`<Leader> f s`     | 保存（save）文件
`<Leader> f [1-9]` | 设置折叠 (fold) 层次，`f 0` 相当于全部折叠, `f 9` 相当于取消折叠全部展开


#### 窗口

窗口 (window) 操作, `<Leader> w`.

关于分割窗口的功能，我还常常使用 [tmux](https://tmux.github.io) 来实现，因为它也非常值得学习.

Key Binding       | Description
:---:             | :---:
`<Leader> w j	` | 移动至下方窗口
`<Leader> w k	` | 移动至上方窗口
`<Leader> w h	` | 移动至左边窗口
`<Leader> w l	` | 移动至右边窗口
`<Leader> w v`    | 竖直分割窗口， 等同于 `<Leader> w |`
`<Leader> w 2`    | 将窗口分割为两列，等同于`<Leader> w v`
`<Leader> w s`    | 水平分割窗口， 等同于 `<Leader> w -`
`<Leader> w d	` | 关闭 (cancel) 当前窗口
`<Leader> w q	` | 退出 (quit) 当前窗口，若是最后一个窗口则退出vim
`<Leader> w w	` | 在所有窗口中循环移动
`<Leader> w r`    | 向右或向下方交换 (replace) 窗口

## 插件篇

插件并不是越多越好，每个插件我们常用的大多只是其中一小部分功能而已. 插件装多了，vim 一样会慢. 当然也不是配置地功能越强大越好, 选择合适且真正用得到的功能，在这些地方用的舒心即可。

有些插件 “即装即用”，基本不用配置, 或是 "一次配置，终身使用". 有些则稍麻烦一些，不仅是在配置上需要注意，使用上也可能会有一些学习成本，需要有一点耐心才能看到它带来的效果.

关于插件的更多配置，可以直接查看 [.vimrc.plug.conf](https://github.com/liuchengxu/space-vim/blob/master/.vimrc.plug.conf) 对应信息.

我不使用 vim 的标签页 (tab) 功能，所以关于 `<Leader> t` 的快捷键都不涉及 tab 操作.

Key Binding    | Description
:---:          | :---:
`<F4>`         | NERDTree (NERD -> 4个字母)
`<F6>`         | Tagbar (Tagbar -> 6个字母)
`<Leader> ?`   | 查看快捷键绑定
`<Leader> ;;`  | 智能注释
`<Leader> b h` | vim起始页（**b**uffer **h**ome）(等同于 `<Leader> f r`)
`<Leader> f r` | 查看最近文件 (**f**ile opened **r**ecently)
`<Leader> x d` | 去除行尾多余空格 (te**x**t **d**elete trailing whitespaces)

### [vim-airline](https://github.com/vim-airline/vim-airline)

vim-airline 最好搭配 [powerline fonts](https://github.com/powerline/fonts) 字体， space-vim 默认不使用. 不过推荐安装:

```sh
git clone https://github.com/powerline/fonts.git ~/.fonts
sh ~/.fonts/install.sh
```

powerline font 安装完成后，在 `.vimrc.plug.conf`中的 air-line 中启用字体：

```vim
let g:airline_powerline_fonts=1
```

设置 terminal 字体：

终端环境下 vim 的字体服从于 terminal 的字体设置，GUI 环境下可直接在配置文件中进行设置. 因此安装完成后需要在 terminal 的字体设置中将原有字体改为带有 for powerline 样式的字体，否则会出现状态栏乱码. 比如 iterm2 中字体设置：

![powerline_setting](doc/img/iterm2_powerline_setting.png)

### [space-vim-dark](https://github.com/liuchengxu/space-vim-dark)

因为我想要 vim 与 spacemacs 有着类似的主题，所以自己写了这个 colorscheme. 如果想要其他颜色主题，可以安装下面的[vim-colorschemes](https://github.com/flazz/vim-colorschemes).

![space-vim-dark](doc/img/screenshot.png)

### [vim-colorschemes](https://github.com/flazz/vim-colorschemes)

这个插件里面收集了很多的颜色主题, 想要换换新主题时，不妨安装这个插件。

安装 [vim-colorschemes](https://github.com/flazz/vim-colorschemes)：

```sh
echo "Plug 'vim-colorschemes/vim-colorschemes'" >> ~/.vimrc.plug.local

vim +PlugInstall! +qall
```

选择主题进行切换，比如 molokai:

```sh
echo "color molokai" >> ~/.vimrc.local
```

这时再打开 vim 应该就能看到效果了.

### [nerdtree](https://github.com/scrooloose/nerdtree)

文件浏览器，非常实用。

下面两个关于 nerdtree 的插件个人来讲，美观性大于实用性，不过要的就是漂亮 :tada:.

#### [nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin)

在 nerdtree 中显示 git 仓库中文件的状态.

#### [vim-nerdtree-syntax-highlight](https://github.com/tiagofumo/vim-nerdtree-syntax-highlight)

按文件类型，扩展名等高亮显示 nerdtree 中的文件.

### [tabular](https://github.com/godlygeek/tabular)

Key Binding | Description
:---:       | :---:
`<Leader> a |` | 按 `|` 对齐
`<Leader> a :` | 按 `:` 对齐
`<Leader> a =` | 按 `=` 对齐

可能 `<Leader> a |` 是我用的比较多的一个，因为经常在 markdown 中对齐表格。


### [vim-easymotion](https://github.com/easymotion/vim-easymotion)

easymotion 默认的前缀键为 `<Leader><Leader>`.

Key Binding          | Description
:---:                | :---:
`<Leader><Leader> w` | 单词 (word) 向前快速移动
`<Leader><Leader> b` | 单词向后 (backward) 快速移动
`<Leader><Leader> j` | 行间向下快速移动
`<Leader><Leader> k` | 行间向上快速移动
`<Leader><Leader> s` | 搜索字符 (search) 跳转，双向
`<Leader><Leader> f` | 向前 (forward) 查找字符

为了与 spacemacs 相一致，我还添加了这几个快捷键:

Key Binding    | Description
:---:          | :---:
`<Leader> j w` | 单词跳转 (jump to word)
`<Leader> j l` | 行间跳转 (jump to line)

### [fzf.vim](https://github.com/junegunn/fzf.vim)

fzf.vim 由 [fzf](https://github.com/junegunn/fzf) 进行支持，用于文件的模糊查找等，使用也非常方便，并且开发者非常活跃，很值得尝试。

![fzf](https://camo.githubusercontent.com/0b07def9e05309281212369b118fcf9b9fc7948e/68747470733a2f2f7261772e6769746875622e636f6d2f6a756e6567756e6e2f692f6d61737465722f667a662e676966)

### [unite.vim](https://github.com/Shougo/unite.vim)

unite.vim 可以为 vim 提供一个命令 UI，可以将一些不常用或不太好设置的快捷键放到里面.

unite.vim 的前缀键为 `localleader`， 这里设置为 `,`.

```vim
let maplocalleader="，"
```

⌘ 指该操作存在对应的快捷键

[menu] 指 unite.vim 的前缀键，这里也即 `,`.

Key Binding | Description
:----:      | :----:
[menu] m    | 查看所有可选菜单（menu）
[menu] x    | 文本 (text)
[menu] f    | 文件 (file) 与 折叠 (fold)
[menu] p    | 插件 (plugin)， 比如syntastic相关功能
[menu] t    | 功能开关(toggle)
[menu] v    | vim相关

unite.vim 的作者又出了一个 denite.vim, 号称比 unite.vim 更好，期待。

### [AsyncRun.vim](https://github.com/skywind3000/asyncrun.vim)

### [syntastic](https://github.com/scrooloose/syntastic)

在前部分介绍安装事项时，提到要安装一些额外使用的工具，有很多就是 syntastic 这个插件所需要的：

```vim
let g:jyntastic_python_checkers=['pyflakes']           " 使用pyflakes 比pylint快, 需要pip安装pyflakes，
let g:syntastic_javascript_checkers=['jsl', 'jshint']  " npm install jsl jshint
let g:syntastic_html_checkers=['tidy', 'jshint']       " brew install tidy-html5
```
有更多需要的话也可以自行查阅 syntastic 文档。

### [ale](https://github.com/w0rp/ale)

### [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)

YouCompleteMe 配置稍显复杂，其实也不复杂，而且使用 [vim-plug](https://github.com/junegunn/vim-plug) 作为插件管理器后更是非常方便，能够一键式安装。

ycm 关键在于需要安装一些必要的软件，比如 cmake, clang 等，在进行安装时可能需要花费一些等待时间， 更多安装内容可以查阅[其安装介绍](https://github.com/Valloric/YouCompleteMe#mac-os-x).

此外一点注意：必须在 `.vimrc.plug.conf` 中正确设置 Python 路径.如果不设置该选项 YCM 会经常 crashed. python 版本应当与编译 YCM 时的 Python 版本一致， 建议使用 Python3 和绝对路径避免不必要的问题.

```vim
let g:ycm_path_to_python_interpreter='/absolute/path/to/python'
```

## 个性化

vimrc Related      | Description
:---:              | :---:
`.vimrc`           | 必须的配置文件
`.vimrc.plug.list` | 安装的 vim 插件列表
`.vimrc.plug.conf` | 所安装 vim 各种插件的设置

如果想要修改配置，当然可以选择在我的配置文件上直接修改. 但是如果只是些微调，还是建议您采取以下方式:

- 将配置信息写入到 `~/.vimrc.local` ， 比如想要修改主题:

    ```sh
    echo "color solarized" >> ~/.vimrc.local
    ```

    然后， `<Leader> f R` 使得配置生效.

- 如果想要卸载 space-vim 默认安装的插件， 打开 `~/.vimrc.plug.list` 注释掉对应行, 执行 `:PlugClean` 即可.

    如果想要安装另外的插件，将插件信息写入到 `~/.vimrc.plug.local` , 比如添加多光标操作[vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)这个插件:

    ```sh
    Plugin 'terryma/vim-multiple-cursors'
    ```

    然后 `<Leader> f R` 使配置生效，并执行 `:PlugInstall` 进行安装.
