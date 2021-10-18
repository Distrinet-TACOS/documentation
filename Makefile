# Defines BROWSER and DIR but is private
CONFIG ?= make.conf
include ${CONFIG}

PDF_TEMPLATE = templates/eisvogel.tex
HTML_TEMPLATE = templates/uikit.html

all: convert copy

test: convert-html open

convert: convert-pdf convert-html

convert-pdf: create-out
	. ./.venv/bin/activate; pandoc -N -s main.md setup.md design.md bib.md -f markdown -t latex -o out/main.pdf --template $(PDF_TEMPLATE) --listings --toc --filter pandoc-include --filter pandoc-latex-environment --top-level-division=part

convert-html: create-out
	. ./.venv/bin/activate; pandoc -N -s main.md setup.md design.md bib.md -f markdown -t html -o out/main.html --template $(HTML_TEMPLATE) --toc --filter pandoc-include --top-level-division=part

create-out:
	@mkdir -p out

copy:
	cp out/main.pdf "OP-TEE Shared Secure Peripherals.pdf"
	cp out/main.html "OP-TEE Shared Secure Peripherals.html"
	cp out/main.html docs/index.html

open:
ifdef BROWSER
ifdef DIR
	$(BROWSER) "file://$(DIR)/out/main.html" &
endif
endif
