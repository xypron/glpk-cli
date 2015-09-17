GLPK for the Common Language Infrastructure (CLI)
=================================================

The GNU Linear Programming Kit (GLPK) package supplies a solver for large scale
linear programming (LP) and mixed integer programming (MIP).
The GLPK for the Common Language Infrastructure (CLI) package provides a language
binding that can be used with CLI supported languages like C#.

Obtaining the source
--------------------

The source repository is located at https://github.com/xypron.
It can be downloaded with

    git clone https://github.com/xypron/glpk-cli.git


Building from source
--------------------

To build the package on Linux execute the following commands.

    ./autogen.sh
    ./configure
    make
    make check
    sudo make install
