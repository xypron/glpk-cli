dnl GLPK for C# and the Common Language Interface (CLI)

dnl Initialization
AC_INIT([GLPK for C#/CLI], [1.5.0], [xypron.glpk@gmx.de],
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

dnl Generate files
AC_OUTPUT

