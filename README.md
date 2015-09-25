# GLPK for C# and the Common Language Infrastructure (CLI)

The GNU Linear Programming Kit (GLPK) package supplies a solver for large scale
linear programming (LP) and mixed integer programming (MIP).
The GLPK for C# and the Common Language Infrastructure (CLI) package provides a
language binding that can be used with C# and other CLI supported languages
like F#.

## Obtaining the source

The source repository is located at https://github.com/xypron/glpk-cli.
It can be downloaded with

    git clone https://github.com/xypron/glpk-cli.git


## Building from source

### Linux

To build the package on Linux execute the following commands.

    ./autogen.sh
    ./configure
    make
    make check
    sudo make install

### Windows

To build the package on Windows:

* Copy file glpk.h to new directory src.
* Copy files glpk_?_??.* to directory w64.
* Cd to directory w64.
* Verify the paths in Build_CLI_with_VC14_DLL.bat.
* Execute Build_CLI_with_VC14_DLL.bat

For building your own application you will need the following files from
the w64 directory:

* glpk_?_??.dll - the GLPK native library
* libglpk_cli_native.dll - the GLPK for C#/CLI native library
* libglpk_cli.dll - the GLPK for C#/CLI assembly
