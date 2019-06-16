APP           := cSpaceVim
INIT_VIM      := ~/.cSpaceVim/init.vim
VIMRC         := ~/.vimrc
NVIMRC        := ~/.config/nvim/init.vim

INIT_SPACEVIM := ~/.cSpaceVim/init.spacevim
DOT_SPACEVIM  := ~/.spacevim

help:
	@echo "usage: make [OPTIONS]"
	@echo "    help        Show this message"
	@echo "    vim         Install cSpaceVim for Vim"
	@echo "    neovim      Install cSpaceVim for NeoVim"
	@echo "    update      Update cSpaceVim"
	@echo "    uninstall   Uninstall cSpaceVim"

vim:
	@echo "\033[1;34m==>\033[0m Trying to install cSpaceVim for Vim"; \
	[ ! -f $(VIMRC) ]        && ln -sf $(INIT_VIM) $(VIMRC)         && echo "    - Created $(VIMRC) "; \
	[ ! -f $(DOT_SPACEVIM) ] && cp $(INIT_SPACEVIM) $(DOT_SPACEVIM) && echo "    - Created $(DOT_SPACEVIM) "; \
	vim  +'PlugInstall' +qall; \
	echo "\033[32m[✔]\033[0m Successfully installed $(APP) for Vim!"

neovim:
	@echo "\033[1;34m==>\033[0m Trying to install cSpaceVim for NeoVim"; \
	mkdir -p ~/.config/nvim; \
	[ ! -f $(NVIMRC) ]       && ln -sf $(INIT_VIM) $(NVIMRC)        && echo "    - Created $(NVIMRC)"; \
	[ ! -f $(DOT_SPACEVIM) ] && cp $(INIT_SPACEVIM) $(DOT_SPACEVIM) && echo "    - Created $(DOT_SPACEVIM) "; \
	nvim +'PlugInstall' +qall; \
	echo "\033[32m[✔]\033[0m Successfully installed $(APP) for NeoVim!"

update:
	@echo "\033[1;34m==>\033[0m Trying to update cSpaceVim"; \
	git pull origin master; \
	echo "\033[32m[✔]\033[0m Successfully updated $(APP)"

uninstall:
	@echo "\033[1;34m==>\033[0m Trying to uninstall cSpaceVim"; \
	rm -f  $(VIMRC)            && echo "    - Removed $(VIMRC)"; \
	rm -f  $(NVIMRC)           && echo "    - Removed $(NVIMRC)"; \
	rm -f  $(DOT_SPACEVIM)     && echo "    - Removed $(DOT_SPACEVIM)"; \
	rm -rf ~/.$(APP)           && echo "    - Removed ~/.$(APP)"; \
	echo "\033[32m[✔]\033[0m Successfully uninstalled $(APP)"

.PHONY: help vim neovim update uninstall
