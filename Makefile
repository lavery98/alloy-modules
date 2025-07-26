.PHONY: all install clean reinstall lint lint-alloy lint-md lint-markdown format format-md format-markdown

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
lint: lint-alloy lint-markdown

lint-alloy:
	@./scripts/lint-alloy.sh || true

# Markdown linting
lint-md lint-markdown:
	@./scripts/lint-markdown.sh || true

##################
#   Formatting   #
##################
format: format-markdown

format-md format-markdown:
	@./scripts/format-markdown.sh || true
