# GLPK for C# and the Common Language Infrastructure (CLI)

GLPK for C#/CLI provides a common language interface binding for the GLPK linear
programming library. It allows you to use the Gnu Linear Programming Kit with all
.NET/Mono languages (C#, F#, Python, J#, Scala, Visual Basic, ...).

The project homepage is http://glpk-cli.sourceforge.net.

Makefiles for Windows and Linux are provided.

To report problems and suggestions concerning GLPK for C#/CLI, please, send an
email to the author at xypron.glpk@gmx.de.

The GNU Linear Programming Kit (GLPK) supplies a solver for large scale linear
programming (LP) and mixed integer programming (MIP). The GLPK project is hosted
at http://www.gnu.org/software/glpk.

It has two mailing lists:

* help-glpk@gnu.org and
* bug-glpk@gnu.org.

To subscribe to one of these lists, please, send an empty mail with a Subject:
header line of just "subscribe" to the list.

GLPK provides a library written in C and a standalone solver.

The source code provided at ftp://gnu.ftp.org/gnu/glpk/ contains the
documentation of the library in file doc/glpk.pdf. This should be your first
reference for the usage of the library.

## Obtaining the source

The latest release of "GLPK for C#/CLI" is available at
http://sourceforge.net/projects/glpk-cli/

You can download the latest development version from the git repository with

    git clone https://github.com/xypron/glpk-cli.git

or view it the repository at https://github.com/xypron/glpk-cli/.

## Building from source

### Linux

To build the package on Linux execute the following commands.

    ./autogen.sh
    ./configure
    make
    make check
    sudo make install

For building and running your own application you will need to the following
files

* /usr/local/lib/libglpk.so - the GLPK native library
* /usr/local/lib/glpk-cli/libglpk-cli.so - the GLPK for C#/CLI native library
* /usr/local/lib/glpk-cli/libglpk-cli.dll - the GLPK for C#/CLI assembly

You will probably want to add /usr/local/lib/glpk-cli to the MONO\_PATH and
the LD\_LIBRARY\_PATH environment variables.

The following example shows how to compile an application version.exe which
writes the GLPK version number to the console in C#.

    export MONO_PATH=/usr/local/lib/glpk-cli
    export LD_LIBRARY_PATH=/usr/local/lib/glpk-cli
    cat > version.cs << EOF
    using System;
    using org.gnu.glpk;
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("GLPK " + GLPK.glp_version());
        }
    }
    EOF
    mcs -r:libglpk-cli -lib:/usr/local/lib/glpk-cli/ version.cs
    ./version.exe

The following example shows how to compile an application version.exe which
writes the GLPK version number to the console in Visual Basic.

    export MONO_PATH=/usr/local/lib/glpk-cli
    export LD_LIBRARY_PATH=/usr/local/lib/glpk-cli
    cat > version.vb << EOF
    Imports System
    Imports org.gnu.glpk
    Public Module module1
        Sub Main()
            Console.WriteLine ("GLPK " + GLPK.glp_version())
        End Sub
    End Module
    EOF
    vbnc -r:libglpk-cli.dll -libpath:/usr/local/lib/glpk-cli/ version.vb
    chmod 755 version.exe
    ./version.exe

### Windows

To build the package on Windows:

* Copy file glpk.h to new directory src.
* Copy files glpk\_?\_??.\* to directory w64.
* Cd to directory w64.
* Verify the paths in Build\_CLI.bat.
* Execute Build\_CLI.bat

For building and running your own application you will need the following files
from the w64 directory:

* glpk\_?\_??.dll - the GLPK native library
* libglpk\_cli\_native.dll - the GLPK for C#/CLI native library
* libglpk\_cli.dll - the GLPK for C#/CLI assembly

## Open issues

* When a GMPL file is processed using Visual Basic the printf and display
  statements do not produce output.
  As a workaround on Linux you can output to /dev/stdout.

    printf 'foo' >> /dev/stdout;

## Revision history

1.9.0 - 2017-12-02

* Change Makefile for GLPK 4.64

1.8.0 - 2017-07-25

* Change Makefile for GLPK 4.63

1.7.0 - 2017-07-01

* Change Makefile for GLPK 4.62
* Use Swig 3.0.12

1.6.0 - 2017-01-21

* Change Makefiles for GLPK 4.61
* Use thread local memory for callbacks and error handling
* Use Swig 3.0.11

1.5.0 - 2016-03-27

* Change Makefiles for GLPK 4.60

1.4.0 - 2016-03-15

* Change Makefiles for GLPK 4.59.1

1.3.0 - 2016-03-13

* Change Makefiles for GLPK 4.59

1.2.0 - 2016-02-18

* Change Makefiles for GLPK 4.58
* Use Swig 3.0.8

1.1.0 - 2015-11-08

* Change Makefiles for GLPK 4.57
* Use Swig 3.0.7

1.0.2 - 2015-10-03

* Change Makefiles for GLPK 4.56
* Windows 32 bit makefiles
* Support for network optimization
* F# example

1.0.1 - 2015-09-27

* Visual Basic examples added

1.0.0 - 2015-09-26

* initial release
