ACLOCAL_AMFLAGS = -I m4
SUBDIRS = swig

EXTRA_DIST = doc examples w32 w64 autogen.sh

check-swing:
	-for d in $(SUBDIRS); do (cd $$d && $(MAKE) check-swing ); done

clean:
	-for d in $(SUBDIRS); do (cd $$d && $(MAKE) clean ); done

dist-hook:
	rm -rf `find $(distdir) -name .svn`

documentation:
	-for d in $(SUBDIRS); do (cd $$d && $(MAKE) documentation ); done

