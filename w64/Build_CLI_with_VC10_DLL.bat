rem Build GLPK JNI DLL with Microsoft Visual Studio Express 2010
rem NOTE: Make sure that the following variables specify correct paths:
rem HOME, SWIG, JAVA_HOME, GLPK_HOME

rem Path to GLPK source (glpk.h will be in $(GLPK_HOME)/src)
set GLPK_HOME=".."
rem Path to Visual Studio Express
set HOME="C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC"
rem Path to SwigWin
set SWIG="C:\Program Files (x86)\swig\swigwin-3.0.5"
rem Path to Windows SDK
set SDK="C:\Program Files\Microsoft SDKs\Windows\v7.1"

set path_build_jni=%path%
cd ..\swig
mkdir target\classes
mkdir target\apidocs
mkdir src\main\java\org\gnu\glpk
mkdir src\c
copy *.java src\main\java\org\gnu\glpk
%SWIG%\swig.exe -csharp -dllimport libglpk-cli -namespace org.gnu.glpk -o src/c/glpk_wrap.c -outdir src/csharp glpk.i
cd "%~dp0"
set INCLUDE=
set LIB=
call %HOME%\vcvarsall.bat x64
call %SDK%\bin\rc.exe glpk_cli_dll.rc
%HOME%\bin\nmake.exe /f Makefile_CLI_VC_DLL
copy ..\swig\*.jar .
%HOME%\bin\nmake.exe /f Makefile_CLI_VC_DLL check
set INCLUDE=
set LIB=
pause
