PWD           := $(shell pwd)
APP           := space-vim
INIT_VIM      := $(PWD)/init.vim
VIMRC         := ~/.vimrc
NVIMRC        := ~/.config/nvim/init.vim

INIT_SPACEVIM := $(PWD)/init.spacevim
DOT_SPACEVIM  := ~/.spacevim

help:
	@echo "usage: make [OPTIONS]"
	@echo "    help        Show this message"
	@echo "    vim         Install space-vim for Vim"
	@echo "    neovim      Install space-vim for NeoVim"
	@echo "    update      Update space-vim"
	@echo "    uninstall   Uninstall space-vim"

vim:
	@echo -e "\033[1;34m==>\033[0m Trying to install space-vim for Vim"; \
	[ ! -f $(VIMRC) ]        && ln -sf $(INIT_VIM) $(VIMRC)         && echo "    - Created $(VIMRC) "; \
	[ ! -f $(DOT_SPACEVIM) ] && cp $(INIT_SPACEVIM) $(DOT_SPACEVIM) && echo "    - Created $(DOT_SPACEVIM) "; \
	vim  +'PlugInstall' +qall; \
	echo -e "\033[32m[✔]\033[0m Successfully installed $(APP) for Vim!"

neovim:
	@echo -e "\033[1;34m==>\033[0m Trying to install space-vim for NeoVim"; \
	mkdir -p ~/.config/nvim; \
	[ ! -f $(NVIMRC) ]       && ln -sf $(INIT_VIM) $(NVIMRC)        && echo "    - Created $(NVIMRC)"; \
	[ ! -f $(DOT_SPACEVIM) ] && cp $(INIT_SPACEVIM) $(DOT_SPACEVIM) && echo "    - Created $(DOT_SPACEVIM) "; \
	nvim +'PlugInstall' +qall; \
	echo -e "\033[32m[✔]\033[0m Successfully installed $(APP) for NeoVim!"

update:
	@echo -e "\033[1;34m==>\033[0m Trying to update space-vim"; \
	git pull origin master; \
	echo -e "\033[32m[✔]\033[0m Successfully updated $(APP)"

uninstall:
	@echo -e "\033[1;34m==>\033[0m Trying to uninstall space-vim"; \
	rm -f  $(VIMRC)            && echo "    - Removed $(VIMRC)"; \
	rm -f  $(NVIMRC)           && echo "    - Removed $(NVIMRC)"; \
	rm -f  $(DOT_SPACEVIM)     && echo "    - Removed $(DOT_SPACEVIM)"; \
	echo -e "\033[32m[✔]\033[0m Successfully uninstalled $(APP)"

.PHONY: help vim neovim update uninstall
