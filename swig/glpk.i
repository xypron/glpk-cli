%module GLPK

/* As there is no good transformation for va_list
 * we will just do nothing.
 * cf. http://swig.org/Doc3.0/SWIGDocumentation.html#Varargs_nn8
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

// Exception handling
%insert(runtime) %{
    // Code to handle throwing of C# CustomApplicationException from
    // C/C++ code. The equivalent delegate to the callback,
    // CSharpExceptionCallback_t, is CustomExceptionDelegate
    // and the equivalent customExceptionCallback instance is customDelegate.
    typedef void (SWIGSTDCALL* CSharpExceptionCallback_t)(const char *);
    CSharpExceptionCallback_t customExceptionCallback = NULL;

    extern SWIGEXPORT
    void SWIGSTDCALL CustomExceptionRegisterCallback(CSharpExceptionCallback_t customCallback) {
      customExceptionCallback = customCallback;
    }

    // Note that SWIG detects any method calls named starting with
    // SWIG_CSharpSetPendingException
    static void SWIG_CSharpSetPendingExceptionCustom(const char *msg) {
      customExceptionCallback(msg);
    }
%}

%pragma(csharp) imclasscode=%{
    class CustomExceptionHelper {
        // C# delegate for the C/C++ customExceptionCallback
        public delegate void CustomExceptionDelegate(string message);
        static CustomExceptionDelegate customDelegate =
                new CustomExceptionDelegate(SetPendingCustomException);

        [global::System.Runtime.InteropServices.DllImport(
                "$dllimport", EntryPoint="CustomExceptionRegisterCallback")]
        public static extern
                void CustomExceptionRegisterCallback(
                        CustomExceptionDelegate customCallback);

        static void SetPendingCustomException(string message) {
                SWIGPendingException.Set(new GlpkException(message));
        }

        static CustomExceptionHelper() {
                CustomExceptionRegisterCallback(customDelegate);
        }
    }
    static CustomExceptionHelper exceptionHelper = new CustomExceptionHelper();
    // This method is only introduced to avoid a warning.
    private static CustomExceptionHelper getExceptionHelper() {
        return exceptionHelper;
    }
%}


%exception {
    jmp_buf glp_cli_env;

    if (glp_cli_msg_level != GLP_CLI_MSG_LVL_OFF) {
        glp_printf("entering function $name.\n");
    }
    glp_cli_callback_env[glp_cli_callback_level] = &glp_cli_env;
    if (setjmp(glp_cli_env)) {
        SWIG_CSharpSetPendingExceptionCustom("function $name failed");
    } else {
        glp_error_hook(glp_cli_error_hook, &glp_cli_env);
        $action;
    }
    glp_cli_callback_env[glp_cli_callback_level] = NULL;
    glp_error_hook(NULL, NULL);
    if (glp_cli_msg_level != GLP_CLI_MSG_LVL_OFF) {
        glp_printf("leaving function $name.\n");
    }
}

%include "glpk_cli_arrays.i"
%glp_array_functions(double, doubleArray);
%glp_array_functions(int, intArray);

%include "glpk_cli.i"
%include "glpk_doc.i"
%include "glpk.h"
