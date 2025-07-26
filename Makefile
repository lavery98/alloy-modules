.PHONY: all install clean reinstall lint lint-md lint-markdown

default: all

all: install

####################
#   Installation   #
####################
install:
	pnpm install

clean:
	rm -rf node_modules

reinstall: clean install

###############
#   Linting   #
###############
lint: lint-markdown

# Markdown linting
lint-md lint-markdown:
	@./scripts/lint-markdown.sh || true
