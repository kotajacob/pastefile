.POSIX:
PREFIX ?= /usr/local
MANPREFIX ?= $(PREFIX)/share/man
GO ?= go
GOFLAGS ?=
VERSION = v0.1.0

all: pastefile

pastefile:
	$(GO) build $(GOFLAGS) -o build/pastefile
	scdoc < doc/pastefile.1.scd | sed "s/VERSION/$(VERSION)/g" > build/pastefile.1

clean:
	rm -rf build

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	install -m755 build/pastefile \
		$(DESTDIR)$(PREFIX)/bin/pastefile
	install -m644 build/pastefile.1 \
		$(DESTDIR)$(MANPREFIX)/man1/pastefile.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/pastefile
	rm -f $(DESTDIR)$(MANPREFIX)/man1/pastefile.1

.DEFAULT_GOAL := all

.PHONY: all pastefile clean install uninstall
