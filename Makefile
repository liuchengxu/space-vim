APP           := space-vim
INIT_VIM      := ~/.space-vim/init.vim
VIMRC         := ~/.vimrc
NVIMRC        := ~/.config/nvim/init.vim

INIT_SPACEVIM := ~/.space-vim/init.spacevim
DOT_SPACEVIM  := ~/.spacevim

.PHONY: help vim neovim update uninstall

help:
	@echo "usage: make [OPTIONS]"; \
	echo "    help        Show this message"; \
	echo "    vim         Install space-vim for Vim"; \
	echo "    neovim      Install space-vim for NeoVim"; \
	echo "    update      Update space-vim"; \
	echo "    uninstall   Uninstall space-vim"

vim:
	@echo "\033[1;34m==>\033[0m Trying to install space-vim for Vim"; \
	[ ! -f $(VIMRC) ]        && ln -sf $(INIT_VIM) $(VIMRC)         && echo "    - Created $(VIMRC) "; \
	[ ! -f $(DOT_SPACEVIM) ] && cp $(INIT_SPACEVIM) $(DOT_SPACEVIM) && echo "    - Created $(DOT_SPACEVIM) "; \
	vim  +'PlugInstall' +qall; \
	echo "\033[32m[✔]\033[0m Successfully installed $(APP) for Vim!"

neovim:
	@echo "\033[1;34m==>\033[0m Trying to install space-vim for NeoVim"; \
	mkdir -p ~/.config/nvim; \
	[ ! -f $(NVIMRC) ]       && ln -sf $(INIT_VIM) $(NVIMRC)        && echo "    - Created $(NVIMRC)"; \
	[ ! -f $(DOT_SPACEVIM) ] && cp $(INIT_SPACEVIM) $(DOT_SPACEVIM) && echo "    - Created $(DOT_SPACEVIM) "; \
	nvim +'PlugInstall' +qall; \
	echo "\033[32m[✔]\033[0m Successfully installed $(APP) for NeoVim!"

update:
	@echo "\033[1;34m==>\033[0m Trying to update space-vim"; \
	git pull origin master; \
	echo "\033[32m[✔]\033[0m Successfully updated $(APP)"

uninstall:
	@echo "\033[1;34m==>\033[0m Trying to uninstall space-vim"; \
	rm -f  ~/.vimrc     && echo "    - Removed ~/.vimrc"; \
	rm -rf ~/.space-vim && echo "    - Removed ~/.space-vim"; \
	echo "\033[32m[✔]\033[0m Successfully uninstalled $(APP)"
