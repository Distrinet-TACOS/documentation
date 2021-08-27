# Defines BROWSER and DIR but is private
CONFIG ?= make.conf
include ${CONFIG}

all: convert

test: convert-html open

convert: convert-pdf convert-html

convert-pdf: create-out
	pandoc main.md -f markdown -t latex -o out/main.pdf --template eisvogel.tex --listings --toc

convert-html: create-out
	pandoc main.md -f markdown -t html -o out/main.html --template uikit --toc

create-out:
	@mkdir -p out

open:
ifdef BROWSER
ifdef DIR
	$(BROWSER) "file://$(DIR)/out/main.html" &
endif
endif
