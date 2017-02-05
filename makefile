## Put this Makefile in your project directory---i.e., the directory
## containing the paper you are writing. Assuming you are using the
## rest of the toolchain here, you can use it to create .html, .tex,
## and .pdf output files (complete with bibliography, if present) from
## your markdown file. 
## -	Change the paths at the top of the file as needed.
## -	Using `make` without arguments will generate html, tex, and pdf 
## 	output files from all of the files with the designated markdown
##	extension. The default is `.md` but you can change this. 
## -	You can specify an output format with `make tex`, `make pdf` or 
## - 	`make html`. 
## -	Doing `make clean` will remove all the .tex, .html, and .pdf files 
## 	in your working directory. Make sure you do not have files in these
##	formats that you want to keep!

## Markdown extension (e.g. md, markdown, mdown).
MEXT = md

## All markdown files in the working directory
#SRC = $(wildcard *.$(MEXT))


SRC=$(wildcard *.md wildcard */*.md)


# ## Location of Pandoc support files.
# PREFIX = /Users/kjhealy/.pandoc

# ## Location of your working bibliography file
# BIB = /Users/kjhealy/Documents/bibs/socbib-pandoc.bib

# ## CSL stylesheet (located in the csl folder of the PREFIX directory).
# CSL = apsa

HTML=$(SRC:%.md=_site/%.html)
PDFS=$(SRC:%.md=_site/BUILD/pdf/%.pdf)
TEX=$(SRC:%.md=_site/BUILD/tex/%.tex)


all:	$(PDFS) $(HTML) $(TEX)

pdf:	clean $(PDFS)
html:	clean $(HTML)
tex:	clean $(TEX)


_site/%.html : %.md
	
	@mkdir -p $(@D)
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block -w html -S -o $@ $<
	cp -R static _site/.
	

_site/BUILD/tex/%.tex : %.md
	
	@mkdir -p $(@D)
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block -w latex -s -S -o $@ $<
	

_site/BUILD/pdf/%.pdf : %.md
	
	@mkdir -p $(@D)
	pandoc -r markdown+simple_tables+table_captions+yaml_metadata_block -s -S -o $@ $<
	

clean:
	rm -rf _site
