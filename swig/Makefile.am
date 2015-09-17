EXTRA_DIST = *.i

# current:revision:age
# library implements all interface numbers
# in the range from number current - age to current
VERSION_INFO = 1:0:1

all:
	mkdir -p src/c
	mkdir -p src/csharp
	$(SWIG) $(SWIGFLAGS) -csharp -dllimport libglpk-cil \
	  -namespace org.gnu.glpk \
	  -o src/c/glpk_wrap.c -outdir src/csharp glpk.i
	$(LIBTOOL) --mode=compile $(CC) $(CFLAGS) $(CPPFLAGS) -I. -c -fPIC \
	  src/c/glpk_wrap.c
	$(LIBTOOL) --mode=link $(CC) \
	  -version-info $(VERSION_INFO) -revision $(PACKAGE_VERSION) \
	  -g -O -o libglpk-cil.la -rpath ${prefix}/lib/cil glpk_wrap.lo \
	  $(LDFLAGS) -lglpk 
	$(MCS) -target:library \
	  src/csharp/*.cs -out:libglpk-cil.dll

clean-local:
	rm -f -r src/csharp src/c .libs
	rm -f *.o *.la *.lo
	rm -rf target 

documentation:

install:
	mkdir -p -m 755 $(DESTDIR)${libdir}/glpk-cil;true
	$(LIBTOOL) --mode=install install -c libglpk-cil.la \
          $(DESTDIR)${libdir}/glpk-cil/libglpk-cil.la
	$(LIBTOOL) --mode=install install -c libglpk-cil.dll \
          $(DESTDIR)${libdir}/glpk-cil/libglpk-cil.dll
	$(LIBTOOL) --mode=finish $(DESTDIR)${libdir}/glpk-cil

check:
	cd ../examples/csharp && mcs -r:libglpk-cil -lib:$(abs_top_srcdir)/swig/ \
	version.cs
	cd ../examples/csharp && ./version.exe

dist-hook:
	rm -rf `find $(distdir) -name '*~'`
	rm -rf `find $(distdir) -name .svn`
	rm -rf `find $(distdir) -name '*.bak'`

