@ This is the exercise -- {\tt mine fields}.


A field of N x M squares is represented by N lines of exactly M characters
each. The character ‘*’ represents a mine and the character ‘.’ represents
no-mine.

Example input (a 3 x 4 mine-field of 12 squares, 2 of
which are mines)

\smallskip 3 4
\smallskip *...
\smallskip ..*.
\smallskip ....

Your task is to write a program to accept this input and produce as output a
hint-field of identical dimensions where each square is a * for a mine or the
number of adjacent mine-squares if the square does not contain a mine.

Example output (for the above input)

\smallskip *211
\smallskip 12*1
\smallskip 0111


@c
@<includes@>@/
@<types@>@/
@<routines@>@/
@<tests@>@/

@ @<incl...@>+=
#include <stdio.h>


@ First Test case.

@ I use google gtest.
@<incl...@>+=
#include <gtest/gtest.h>


@ type of the board.
@<types@>+=
typedef struct mine_board_struct {
    int n;        /* rows */
    int m;        /* columns */
    char* board; /* data */
    char* output;
} mine_board_t;

@ @<types@>+=
class mine_field_test : public testing::Test
{
};


@ Read the first line of input, make sure we have both numbers
{\tt n} and {\tt m} to be populated.

@<tests...@>+=
TEST_F(mine_field_test, test_input_first_line)
{
    int r= 0;
    FILE* fp_in = NULL;
    mine_board_t* env = NULL;
    fp_in = fopen("mine_input_01.txt", "r");
    if(!fp_in) {
        ASSERT_EQ(1, r);
    }
    r = mine_board_init(&env, fp_in);
    ASSERT_EQ(0, r);
    ASSERT_EQ(3, env->n);
    ASSERT_EQ(4, env->m);
    fclose(fp_in);
    mine_board_free(env);
}
@ 
@d SMAX 512
@d MINE_ERROR_NO_ERROR     0
@d MINE_ERROR_ALLOC_MEM    -1
@d MINE_ERROR_INPUT_PARSE  -5
@<rout...@>+=
int mine_board_init(mine_board_t** ptr_env, FILE* fp)
{
    int i;
    int r = -1;
    mine_board_t* env;
    char s[SMAX];
    env = (mine_board_t*) malloc(sizeof(mine_board_t));
    if(!env) return -1;
    if(fgets(s, SMAX, fp)!=NULL) {
        r= sscanf(s, "%d %d", &env->n,&env->m);
        if(r <=0) {
            free(env);
            return -1;
        }
    }
    if(env->n <=0 || env->m <=0) {
        free(env);
        return -5;
    }
    env->board = (char*) malloc(env->n*env->m + 1);
    env->output = (char*) malloc(env->n*env->m + 1);
    if(!env->board || !env->output) {
        if(env->board) free(env->board);
        free(env);
        return -5;
    }


    for(i=0; i<env->n;i++) {
        if((fgets(s, SMAX, fp)) != NULL) {
            @<stripe newline from a string |s|@>@;
            if(strlen(s) != env->m) {
                printf("eror read %d(%d) charactors of line %d: %s", 
                        env->m, strlen(s), env->n, s);
                return -1;
            }
            strcat(env->board, s);            
        }
        else return -2;
    }
    *ptr_env = env;
    return MINE_ERROR_NO_ERROR;
}
void mine_board_free(mine_board_t* env)
{   
    if(env) {
        if(env->board) free(env->board);
        if(env->output) free(env->output);
        free(env);
        env = NULL;
    }
}


@ @<stripe newline from a string |s|@>=
{
    int j;
    for(j=0;j<strlen(s);j++) {
        if((s[j]=='\r') || (s[j]=='\n')) {
            s[j] = 0;
            break;
        }
    }
} 
@ @<tests...@>+=
TEST_F(mine_field_test, test_input_the_rest_line)
{
    int r= 0;
    FILE* fp_in = NULL;
    mine_board_t* env = NULL;
    fp_in = fopen("mine_input_01.txt", "r");
    if(!fp_in) {
        ASSERT_EQ(1, r);
    }
    r = mine_board_init(&env, fp_in);
    ASSERT_EQ(0, r);
    if(env->board == 0) {
        ASSERT_EQ(1, r);
    }
    char* ref_board ="*.....*.....";
    ASSERT_STREQ(ref_board, env->board);

    fclose(fp_in);
    mine_board_free(env);
}
@ Index.
