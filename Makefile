TITLE = main
TOPDIR = ./app/
SRCDIR = ${TOPDIR}src/
BUILDDIR = ${TOPDIR}src/
F = ${BUILDDIR}${TITLE}
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
	@if [ -f "$F.pdf" ]; then\
    	rm -rf $(shell ls $F.* | grep -v -E '$F.(tex|pdf)'); \
	fi
	@if [ -d "${SRCDIR}auto" ]; then\
    	rm -rf ${SRCDIR}auto; \
	fi

all-clean: clean
	@docker system prune -af