dnl GLPK for C# and the Common Language Interface (CLI)

dnl Initialization
AC_INIT([GLPK for C#/CLI], [1.7.0], [xypron.glpk@gmx.de],
  [libglpk-cli], [https://github.com/xypron/glpk-cli])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE
LT_INIT

dnl Compiler check
AC_PROG_CC
AC_CHECK_PROG([have_cc],[$CC],[yes],[no])
if test [$have_cc] != [yes]; then
  AC_MSG_ERROR([$CC is missing])
fi

dnl Provide $(LN_S)
AC_PROG_LN_S

dnl Check for programs needed
AC_PATH_PROG([SWIG],[swig])
if test "x$SWIG" == "x"; then
  AC_MSG_ERROR([Swig is missing])
fi
AC_PATH_PROG([MCS],[mcs])
if test "x$MCS" == "x"; then
  AC_MSG_ERROR([mcs is missing])
fi

dnl SWIG
AC_ARG_VAR([SWIGFLAGS],[The list of flags that should be passed to SWIG.])
SWIGFLAGS="-I/usr/include -I/usr/local/include $SWIGFLAGS"

dnl Thread local storage
AC_MSG_CHECKING(for thread local storage (TLS) class)
tls_keywords="_Thread_local __thread __declspec(thread)"
cv_tls="none"
for tls_keyword in $tls_keywords; do
  AC_COMPILE_IFELSE([AC_LANG_SOURCE([
    #include <stdlib.h>
    static void foo(void) {
    static ] $tls_keyword [ int bar;
      exit(1);
    }])],
    [cv_tls=$tls_keyword ; break],
    []
   )
done
AC_MSG_RESULT($cv_tls)
if test "x$cv_tls" == "xnone"; then
  cv_tls="/**/"
fi
AC_DEFINE_UNQUOTED([TLS], $cv_tls, [Thread local storage])

dnl Check includes
AC_CHECK_HEADER([glpk.h],
  [],
  [AC_MSG_ERROR([glpk.h not found])]
  )

dnl Makefiles
AC_CONFIG_FILES([
  Makefile
  doc/Makefile
  swig-cli/Makefile
  ])

CPPFLAGS+=" -I.."
AC_MSG_NOTICE([CFLAGS = $CFLAGS])
AC_MSG_NOTICE([CPPFLAGS = $CPPFLAGS])
AC_MSG_NOTICE([SWIGFLAGS = $SWIGFLAGS])
AC_MSG_NOTICE([LDFLAGS = $LDFLAGS])

dnl Generate files
AC_OUTPUT

