
default_target: all
.PHONY : default_target

.NOTPARALLEL:

$(VERBOSE).SILENT:

LATEX_OUTPUT_DIR=build-latex
LATEX_SOURCE=demistyfikacja-steganografii-publikacja.tex

all: build-latex

.PHONY : all

build-latex:
	mkdir -p "$(LATEX_OUTPUT_DIR)"
	pdflatex -interaction=nonstopmode -output-directory="$(LATEX_OUTPUT_DIR)" "$(LATEX_SOURCE)"
	pdflatex -interaction=nonstopmode -output-directory="$(LATEX_OUTPUT_DIR)" "$(LATEX_SOURCE)"
.PHONY : build-latex

clean:
	rm -rf "$(LATEX_OUTPUT_DIR)"
.PHONY : clean

