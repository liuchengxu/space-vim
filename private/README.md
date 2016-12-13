:us: English

`private` can also be considered as a Layer. If you have a heavy customized configuration, it is nice to organize them here.

You could put extra configuration in `config.vim` and plugins space-vim have not offered in `packages.vim`, which will be loaded on startup.

:cn: 中文

`private` 也可视作一个 Layer, 如果您的个性化配置信息比较多，可以考虑放在这里，如果 `private` 不为空，其中的配置文件在启动时也会被加载。

依旧遵循 Layer 的 “结构” 可以有两个文件:

- packages.vim: 所要安装的插件列表，比如:

    ```vim
    " NeoVim front-end UI focused on IDE-like extensibility
    Plug 'extr0py/oni'
    ```

- config.vim: 个人配置信息, 比如:

    ```vim
    color molokai
    ```
