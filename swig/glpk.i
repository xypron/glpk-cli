%module GLPK

%{
#include "glpk.h"
#include "glpk_cli.h"
%}

/* As there is no good transformation for va_list
 * we will just do nothing.
 * cf. http://swig.org/Doc1.3/SWIGDocumentation.html#Varargs_nn8
 * This typemap is necessary to compile on amd64
 * Linux. 
 */
%typemap(in) (va_list arg) {
}

%{
#include "glpk.h"
#include "glpk_cli.h"
#include <locale.h>
#include <setjmp.h>

/*
 * Function declarations
 */
int glp_cli_term_hook(void *info, const char *s);
void glp_cli_error_hook(void *in);

/*
 * Static variables to handle errors inside callbacks
 */
#define GLP_CLI_MAX_CALLBACK_LEVEL 4
int glp_cli_callback_level = 0;
int glp_cli_error_occured = 0;
jmp_buf *glp_cli_callback_env[GLP_CLI_MAX_CALLBACK_LEVEL];

/*
 * Message level.
 */
int glp_cli_msg_level = GLP_CLI_MSG_LVL_OFF;

/**
 * Abort with error message.
 */
void glp_cli_error(char *message) {
    glp_error("%s\n", message);
}

/**
 * Set message level.
 */
void glp_cli_set_msg_lvl(int msg_lvl) {
    glp_cli_msg_level = msg_lvl;
}

/**
 * Set locale for number formatting.
 */
void glp_cli_set_numeric_locale(const char *locale) {
    setlocale(LC_NUMERIC, locale);
    }

/**
 * This hook function will be processed if an error occured
 * calling the glpk library
 * @param in pointer to long jump environment
 */
void glp_cli_error_hook(void *in) {
    glp_cli_error_occured = 1;
    /* free GLPK memory */
    glp_free_env();
    /* safely return */
    longjmp(*((jmp_buf*)in), 1);
}

/**
 * Get arc data.
 *
 * @param arc arc
 * @return data
 */
glp_cli_arc_data *glp_cli_arc_get_data(const glp_arc *arc) {
   return (glp_cli_arc_data *) arc->data;
}

/**
 * Get vertex
 *
 * @param G graph
 * @param i index
 * @return vertex
 */
glp_vertex *glp_cli_vertex_get(
      const glp_graph *G, const int i) {
   if (i < 1 || i > G->nv) {
      glp_error( "Index %d is out of range.\n", i);
   }
   return G->v[i];
}

/**
 * Get vertex data.
 *
 * @param G graph
 * @param i index to vertex
 * @return data
 */
glp_cli_vertex_data *glp_cli_vertex_data_get(
      const glp_graph *G, const int i) {
   if (i < 1 || i > G->nv) {
      glp_error( "Index %d is out of range.\n", i);
   }
   return (glp_cli_vertex_data *) G->v[i]->data;
}

/**
 * Get vertex data.
 *
 * @param v vertex
 * @return data
 */
glp_cli_vertex_data *glp_cli_vertex_get_data(
      const glp_vertex *v) {
   return v->data;
}

%}

%include "carrays.i"
%array_functions(double, doubleArray);
%array_functions(int, intArray);

%include "glpk_cli.i"
%include "glpk.h"
