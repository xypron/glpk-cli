EXTRA_DIST = *.i *.cs

# current:revision:age
# library implements all interface numbers
# in the range from number current - age to current
VERSION_INFO = 1:1:1

all:
	mkdir -p src/c
	mkdir -p src/csharp
	cp *.cs src/csharp
	$(SWIG) $(SWIGFLAGS) -csharp -dllimport libglpk-cli \
	  -namespace org.gnu.glpk \
	  -o src/c/glpk_wrap.c -outdir src/csharp glpk.i
	$(LIBTOOL) --mode=compile $(CC) $(CFLAGS) $(CPPFLAGS) -I. -c -fPIC \
	  src/c/glpk_wrap.c
	$(LIBTOOL) --mode=link $(CC) \
	  -version-info $(VERSION_INFO) -revision $(PACKAGE_VERSION) \
	  -g -O -o libglpk-cli.la -rpath ${prefix}/lib/cli glpk_wrap.lo \
	  $(LDFLAGS) -lglpk 
	$(MCS) -target:library \
	  src/csharp/*.cs -out:libglpk-cli.dll

clean-local:
	rm -f -r src/csharp src/c .libs
	rm -f *.o *.la *.lo *.dll
	rm -rf target 

documentation:

install:
	mkdir -p -m 755 $(DESTDIR)${libdir}/glpk-cli;true
	$(LIBTOOL) --mode=install install -c libglpk-cli.la \
          $(DESTDIR)${libdir}/glpk-cli/libglpk-cli.la
	$(LIBTOOL) --mode=install install -c libglpk-cli.dll \
          $(DESTDIR)${libdir}/glpk-cli/libglpk-cli.dll
	$(LIBTOOL) --mode=finish $(DESTDIR)${libdir}/glpk-cli

check:
	cd ../examples/csharp && mcs -r:libglpk-cli -lib:../../swig/ \
	version.cs
	export MONO_PATH="../../swig" && \
	cd ../examples/csharp && ./version.exe
	cd ../examples/csharp && mcs -r:libglpk-cli -lib:../../swig/ \
	lp.cs
	export MONO_PATH="../../swig" && \
	cd ../examples/csharp && ./lp.exe
	cd ../examples/csharp && mcs -r:libglpk-cli -lib:../../swig/ \
	errordemo.cs
	export MONO_PATH="../../swig" && \
	cd ../examples/csharp && ./errordemo.exe
	cd ../examples/csharp && mcs -r:libglpk-cli -lib:../../swig/ \
	gmpl.cs
	export MONO_PATH="../../swig" && \
	cd ../examples/csharp && ./gmpl.exe marbles.mod
	cd ../examples/csharp && mcs -r:libglpk-cli -lib:../../swig/ \
	linord.cs
	export MONO_PATH="../../swig" && \
	cd ../examples/csharp && ./linord.exe tiw56r72.mat mincost.lp
	cd ../examples/vb && vbnc -r:libglpk-cli.dll -libpath:../../swig/ \
	version.vb
	cd ../examples/vb && chmod 755 version.exe
	export MONO_PATH="../../swig" && \
	cd ../examples/vb && ./version.exe
	cd ../examples/vb && vbnc -r:libglpk-cli.dll -libpath:../../swig/ \
	lp.vb
	cd ../examples/vb && chmod 755 lp.exe
	export MONO_PATH="../../swig" && \
	cd ../examples/vb && ./lp.exe
	cd ../examples/vb && vbnc -r:libglpk-cli.dll -libpath:../../swig/ \
	errordemo.vb
	cd ../examples/vb && chmod 755 errordemo.exe
	export MONO_PATH="../../swig" && \
	cd ../examples/vb && ./errordemo.exe
	cd ../examples/vb && vbnc -r:libglpk-cli.dll -libpath:../../swig/ \
	gmpl.vb
	cd ../examples/vb && chmod 755 gmpl.exe
	export MONO_PATH="../../swig" && \
	cd ../examples/vb && ./gmpl.exe marbles.mod

dist-hook:
	rm -rf `find $(distdir) -name '*~'`
	rm -rf `find $(distdir) -name '*.orig'`
	rm -rf `find $(distdir) -name .svn`
	rm -rf `find $(distdir) -name '*.bak'`

