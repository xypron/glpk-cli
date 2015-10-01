ACLOCAL_AMFLAGS = -I m4
SUBDIRS = doc swig-cli

EXTRA_DIST = doc examples w64 autogen.sh \
        doxyheader.html Doxyfile

check-fsharp:
	-for d in $(SUBDIRS); do (cd $$d && $(MAKE) check-fsharp ); done

check-vb:
	-for d in $(SUBDIRS); do (cd $$d && $(MAKE) check-vb ); done

clean:
	-for d in $(SUBDIRS); do (cd $$d && $(MAKE) clean ); done
	rm -rf doc/cli/doxygen
	rm -f examples/csharp/*.exe
	rm -f examples/fsharp/*.exe
	rm -f  examples/vb/*.exe
	rm -f examples/csharp/mincost.lp examples/csharp/mincost.dimacs \
	  examples/csharp/tiw56r72.sol
	rm -f examples/vb/mincost.lp examples/vb/mincost.dimacs \
	  examples/vb/tiw56r72.sol

dist-hook:
	rm -rf $(distdir)/doc/cli/doxygen
	rm -rf `find $(distdir) -name '*~'`
	rm -rf `find $(distdir) -name .svn`
	rm -rf `find $(distdir) -name '*.bak'`

documentation:
	-for d in $(SUBDIRS); do (cd $$d && $(MAKE) documentation ); done

install-data-local:
	mkdir -p $(DESTDIR)$(docdir)/examples/
	cp -rf $(srcdir)/doc/cli/* $(DESTDIR)$(docdir)
	cp -rf $(srcdir)/examples/* $(DESTDIR)$(docdir)/examples/
