# Defines BROWSER and DIR but is private
CONFIG ?= make.conf
include ${CONFIG}

PDF_TEMPLATE = templates/eisvogel.tex
HTML_TEMPLATE = templates/uikit.html

all: convert

test: convert-html open

convert: convert-pdf convert-html

convert-pdf: create-out
	. ./.venv/bin/activate; pandoc -N main.md -f markdown -t latex -o out/main.pdf --template $(PDF_TEMPLATE) --listings --toc --filter pandoc-include

convert-html: create-out
	. ./.venv/bin/activate; pandoc -N main.md -f markdown -t html -o out/main.html --template $(HTML_TEMPLATE) --toc --filter pandoc-include

create-out:
	@mkdir -p out

open:
ifdef BROWSER
ifdef DIR
	$(BROWSER) "file://$(DIR)/out/main.html" &
endif
endif
