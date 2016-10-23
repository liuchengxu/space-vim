# space-vim

space-vim is a vim distribution inspired by [spacemacs](https://github.com/syl20bnr/spacemacs).

And it also learns much from other first-class vim configurations, such as [spf13-vim](https://github.com/spf13/spf13-vim).
Thanks for their outstanding works.

## Installation

You can install space-vim painlessly with curl or wget.

- curl

  ```
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/liuchengxu/space-vim/master/install.sh)"
  ```

- wget

  ```
  wget -qO- https://raw.github.com/liuchengxu/space-vim/master/install.sh | sh -x
  ```

## How to use

If you are just starting to use vim, refer to [中文指引](doc/tutorial_cn.md) for some tips.

If if you have been familiar with vim , refer to the `vimrc` related files directly.

## Updating to the latest version

You can manually perform the following steps, or completely reinstall space-vim, which is more easier and safer.

```
cd path/to/space-vim
git pull
vim +PluginInstall! +PluginClean +q
```
