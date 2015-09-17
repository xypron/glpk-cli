%module GLPK

%{
#include "glpk.h"
%}

/* As there is no good transformation for va_list
 * we will just do nothing.
 * cf. http://swig.org/Doc1.3/SWIGDocumentation.html#Varargs_nn8
 * This typemap is necessary to compile on amd64
 * Linux. 
 */
%typemap(in) (va_list arg) {
}

%include "carrays.i"
%array_functions(double, doubleArray);
%array_functions(int, intArray);

%include "glpk.h"
