TITLE = main
TOPDIR = ./app
SRCDIR = ${TOPDIR}/src
BUILDDIR = ${TOPDIR}/build
F = ${BUILDDIR}/${TITLE}
PDFVIEWER = evince

all:
	@docker-compose up --build -d
	docker-compose ps
	make open
	make lint

up:
	@docker-compose up --build -d texlive
	docker-compose ps

build:
	docker-compose build

open: $F.pdf
	@$(PDFVIEWER) $< &

down:
	docker-compose down -v

lint:
	docker-compose build textlint
	docker-compose run --rm textlint npm run --silent textlint-check

clean: down
	@rm -rf $(shell find ${BUILDDIR} -type f | grep -v -E '.gitkeep')
	@if [ -d "${SRCDIR}/auto" ]; then\
    	rm -rf ${SRCDIR}/auto; \
	fi

all-clean: clean
	@docker system prune -af