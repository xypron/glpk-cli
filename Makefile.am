ACLOCAL_AMFLAGS = -I m4
SUBDIRS = swig

EXTRA_DIST = doc examples w64 autogen.sh \
        doxyheader.html Doxyfile

clean:
	-for d in $(SUBDIRS); do (cd $$d && $(MAKE) clean ); done
	rm -rf doc/doxygen
	rm -f examples/csharp/*.exe
	rm -f  examples/vb/*.exe
	rm -f examples/csharp/mincost.lp examples/csharp/mincost.dimacs \
	  examples/csharp/tiw56r72.sol
	rm -f examples/vb/mincost.lp examples/vb/mincost.dimacs \
	  examples/vb/tiw56r72.sol

dist-hook:
	rm -rf $(distdir)/doc/doxygen
	rm -rf `find $(distdir) -name '*~'`
	rm -rf `find $(distdir) -name .svn`
	rm -rf `find $(distdir) -name '*.bak'`

install-data-local:
	mkdir -p $(DESTDIR)$(docdir)/examples/
	cp -rf $(srcdir)/doc/* $(DESTDIR)$(docdir)
	cp -rf $(srcdir)/examples/* $(DESTDIR)$(docdir)/examples/
