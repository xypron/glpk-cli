/* File glpk_cli.h
 * 
 * This file contains definitions that are needed for compiling code explicitly
 * added to GLPK for CLI, and which shall be wrapped by Swig.
 */
#ifndef GLPK_CLI_H
#define GLPK_CLI_H

#define GLP_CLI_MSG_LVL_OFF 0
#define GLP_CLI_MSG_LVL_ALL 1
void glp_cli_error(char *message);
void glp_cli_set_msg_lvl(int msg_lvl);
void glp_cli_set_numeric_locale(const char *locale);

typedef struct _glp_cli_arc_data glp_cli_arc_data;

struct _glp_cli_arc_data {
   double cap;  // arc capacity
   double cost; // arc cost
   double low;  // lower bound
   double rc;   // reduced cost
   double x;    // arc flow
};

typedef struct _glp_cli_vertex_data glp_cli_vertex_data;

struct _glp_cli_vertex_data {
   int    cut; // 0: node is unlabeled, 1: node is labeled
   double pi;  // node potential
   double rhs; // supply/demand value
   int    set; // 0: vertex is in set R, 1: vertex is in set S
};

glp_cli_arc_data *glp_cli_arc_get_data(const glp_arc *arc);
glp_cli_vertex_data *glp_cli_vertex_data_get( const glp_graph *G, const int i);
glp_cli_vertex_data *glp_cli_vertex_get_data( const glp_vertex *v);
glp_vertex *glp_cli_vertex_get( const glp_graph *G, const int i );

struct glp_prob {
   double _opaque_prob[100];
};
struct glp_tran {
   double _opaque_tran[100];
};
struct glp_tree {
   double _opaque_tree[100];
};

#endif // GLPK_CLI_H
