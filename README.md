![space-vim](doc/img/space-vim.png)

[![space-vim-badge](https://cdn.rawgit.com/liuchengxu/space-vim/master/assets/space-vim-badge.svg)](https://github.com/liuchengxu/space-vim) [![license](https://cdn.rawgit.com/liuchengxu/space-vim/master/assets/license.svg)](https://raw.githubusercontent.com/liuchengxu/space-vim/master/LICENSE)
======================================


### Quick Install

- curl

    ```
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"
    ```

- wget

    ```
    sh -c "$(wget -qO- https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"
    ```

[Space-vim](https://github.com/liuchengxu/space-vim) is inspired by [spacemacs](https://github.com/syl20bnr/spacemacs), which is a community-driven emacs ditribution and has been the most famous emacs configuration.
As metioned in spacemacs, that the best editor is neither Emacs nor Vim, it's Emacs **and** Vim! So, both emacs and vim are worthy of trying.

In order to build a new vim distribution like spacemacs in emacs world, space-vim was born!

![screenshot](doc/img/screenshot.png)

:warning: Space-vim now is in the early stages, a ton of stuff are waiting to be covered. Vimers, feel free to make a contribution!

**Table of Contents**

<!-- vim-markdown-toc GFM -->
* [初衷](#初衷)
* [愿景](#愿景)
* [概览](#概览)
    * [个性化](#个性化)
* [展望](#展望)
* [致谢](#致谢)

<!-- vim-markdown-toc -->


## 初衷

[spacemacs](https://github.com/syl20bnr/spacemacs) 可能已经成为 emacs 社区中 “唯我独尊”的配置，在 github 上有近万的 star， contributor 众多。它的 “社区驱动” (community-driven) 真的是很 “耐力持久”，贡献的人很多，UI 很漂亮，功能也很强大。作为 emacs 长久以来的对家 vim, 如果也能有一个这样一个社区驱动的配置，相信也会给大家带来很多便利。

正如 spacemacs 所称，“The best editor is neither Emacs nor Vim, it's Emacs **and** Vim!”, 最好的编辑器既不是 Emacs 也不是 Vim, 而是 Emacs 和 Vim! 所以不管是从实用角度，还是从设计概念，操作哲学的角度，这两个都是非常值得学习的。此外，“编辑器”始终是编辑器，取代不了 IDE，因为吸引我们的更多是深入其中的过程。

就我自身的使用而言，GUI 环境下我会选择 spacemacs, 但是终端环境下 vim 依然是我的首选。我希望尽量保持这两个环境下操作的一致性。此外，vim 社区中，虽有 [spf13-vim](https://github.com/spf13/spf13-vim), [k-vim](https://github.com/wklken/k-vim) 等一些比较有名的 vim 配置，但始终整合的不够，散落着很多适用特定环境的很好的配置，比如针对 c-c++, python, ruby 等等不同语言环境。还有大多也不够漂亮（当然了，这个有点主观，但不管怎么说，年轻人就是要挑“好看”的-_-）。

随着 vim8 的升级，会有很多新的更好的插件诞生，比如我用来替代 [syntastic](https://github.com/vim-syntastic/syntastic) 的 [ale](https://github.com/w0rp/ale), ale 使用了异步特性，再也不用因为语法检查而拖慢速度了。还有[asyncrun.vim](https://github.com/skywind3000/asyncrun.vim) 等等，都会成为我们新的选择。 spf13-vim 等的更新似乎不太跟得上步伐，希望集体智慧能够给我们带来一个更好用的 vim 配置。

## 愿景

集百家之长，惠千家万家。

## 概览

space-vim 既然是从 spacemacs 启发而来，自然借鉴了非常多的东西，最重要的一个概念便是 “Layer”. [space-vim](https://github.com/liuchengxu/space-vim)目前实现了 Layer 的概念：

```
call LayersBegin()

Layer 'fzf'
Layer 'ycmd'
Layer 'html'
Layer 'unite'
Layer 'emoji'
Layer 'c-c++'
Layer 'colors'
Layer 'python'
Layer 'airline'
Layer 'markdown'
Layer 'text-align'
Layer 'programming'
Layer 'better-defaults'
Layer 'syntax-checking'

call LayersEnd()
```

在 space-vim 中，所谓的一个 Layer ，其实很简单，就是集成了一些相关的 vim 插件及其配置，比如 better-defaults, 目前包括的插件有：

```
Plug 'liuchengxu/vim-better-default' 
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' 
Plug 'Raimondi/delimitMate' 
Plug 'tpope/vim-surround' 
Plug 'easymotion/vim-easymotion' 
Plug 'Shougo/denite.nvim' 
Plug 'Shougo/unite.vim' 
Plug 'mhinz/vim-startify' 
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } 
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' } 
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
```

一个 Layer 下有两个重要的文件：

- config.vim : Layer 所涉及的相关插件配置
- packages.vim : Layer 所需插件

调整，增加 Layer 都非常方便, 这也为 “集百家之长” 提供了土壤。

LayerStatus 可以查看启用了哪些 Layer.

![LayerStatus](http://upload-images.jianshu.io/upload_images/127313-f1238570aba5514e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 个性化

个人配置文件为 `.spacevim`, 如果没有 '.spacevim', 那么 space-vim 仅会加载默认的 Layer. `.space-vim` 中定义了两个函数分别用于加载 Layer 与个人配置信息。

```
function! UserInit()

    Layer 'fzf'
    Layer 'ycmd'
    Layer 'syntax-checking'

    Layer 'emoji'
    Layer 'goyo'

    Layer 'html'
    Layer 'python'
    Layer 'markdown'
    Layer 'c-c++'

    " 加载 space-vim Layer中没有的插件
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/vim-github-dashboard'

endfunction

function! UserConfig()

    color gruvbox

endfunction
```


此外, private 可以看做是一个 Layer ，如果个人配置比较多，可以放在这里可以有 Layer 的两个 "标准" 文件：

- packages.vim
- config.vim

## 展望

目前还没有在 Windows 下测试，实现了仅 Layer 的按需加载，后续应当还支持一些选项的设置，比如同类插件选择哪一个，以及还有很多文档工作。**对于初学者而言，文档可能比什么都重要，装了一些插件不是什么难事，重要的是学会使用这些插件，发挥其功效**。

一个人的精力始终是有限的，非常欢迎大家分享自己的使用经验。三个臭皮匠还赛过诸葛亮呢，还不行? 那就四个:p。

当然啦，可能很多人觉得 vimscript 没有 lisp 那么有表现力，稍显蹩脚。Anyway, 都是工具，乐趣而已。初期阶段，可做的事情还很多，欢迎大家分享与贡献. ：[space-vim](https://github.com/liuchengxu/space-vim)

## 致谢

- [spacemacs](https://github.com/syl20bnr/spacemacs) 
