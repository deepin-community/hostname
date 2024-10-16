CFLAGS+=-O2 -Wall -D_GNU_SOURCE

INSTALL = install
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644

prefix = /usr
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
datarootdir = $(prefix)/share
mandir = $(datarootdir)/man

OBJS=hostname.o

hostname: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(LDFLAGS)
	ln -fs hostname dnsdomainname
	ln -fs hostname domainname
	ln -fs hostname ypdomainname
	ln -fs hostname nisdomainname

install: hostname
	$(INSTALL) -d $(DESTDIR)$(mandir)/man1
	$(INSTALL_DATA) hostname.1 $(DESTDIR)$(mandir)/man1
	ln -fs hostname.1 $(DESTDIR)$(mandir)/man1/dnsdomainname.1
	ln -fs hostname.1 $(DESTDIR)$(mandir)/man1/domainname.1
	ln -fs hostname.1 $(DESTDIR)$(mandir)/man1/ypdomainname.1
	ln -fs hostname.1 $(DESTDIR)$(mandir)/man1/nisdomainname.1

	$(INSTALL) -d $(DESTDIR)$(bindir)
	$(INSTALL_PROGRAM) hostname $(DESTDIR)$(bindir)
	ln -fs hostname $(DESTDIR)$(bindir)/dnsdomainname
	ln -fs hostname $(DESTDIR)$(bindir)/domainname
	ln -fs hostname $(DESTDIR)$(bindir)/nisdomainname
	ln -fs hostname $(DESTDIR)$(bindir)/ypdomainname

clean:
	-rm -f $(OBJS) hostname dnsdomainname domainname nisdomainname ypdomainname

.PHONY: clean install
