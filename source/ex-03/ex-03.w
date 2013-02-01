% a little 16pt hskip for a line
\def\midline#1{\line{\hskip16pt\relax#1\hfil}}

@ This is the exercise -- {\tt mine fields}.


A field of N x M squares is represented by N lines of exactly M characters
each. The character ‘*’ represents a mine and the character ‘.’ represents
no-mine.

Example input (a 3 x 4 mine-field of 12 squares, 2 of
which are mines)

\smallskip{\tt \midline{3\ 4\ \ }
\midline{*\ .\ .\ .}
\midline{.\ .\ *\ .}
\midline{.\ .\ .\ .}
}

Your task is to write a program to accept this input and produce as output a
hint-field of identical dimensions where each square is a * for a mine or the
number of adjacent mine-squares if the square does not contain a mine.

Example output (for the above input)

\smallskip{\tt \midline{*\ 2\ 1\ 1}
\midline{1\ 2\ *\ 1}
\midline{0\ 1\ 1\ 1}
}

Here code starts:

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
    char** board; /* input data */
    char** output;/* interpreted output */
} mine_board_t;

int is_it_mine(char);
void mine_board_free(mine_board_t* env);

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
    if(!env) return MINE_ERROR_ALLOC_MEM;
    memset(env, 0, sizeof(mine_board_t));
    if(fgets(s, SMAX, fp)!=NULL) {
        r= sscanf(s, "%d %d", &env->n,&env->m);
        if(r <=0) {
            r = MINE_ERROR_INPUT_PARSE;
            goto exit_with_error;
        }
    }
    if(env->n <=0 || env->m <=0) {
        r = MINE_ERROR_INPUT_PARSE;
        goto exit_with_error;
    }
    env->board = (char**) malloc(env->n * sizeof(char*));
    if(!env->board) {
        r = MINE_ERROR_ALLOC_MEM;
        goto exit_with_error;
    }
    for(i=0;i<env->n;i++) {
        env->board[i] = (char*) malloc(env->m+1); // allocate 1 byte more because I use strcat
        if(!(env->board[i])) {
            r = MINE_ERROR_ALLOC_MEM;
            goto exit_with_error;
        }
        memset(env->board[i], 0, env->m+1);
    }
    env->output = (char**) malloc(env->n * sizeof(char*));
    for(i=0;i<env->n;i++) {
        env->output[i] = (char*) malloc(env->m);
        if(!(env->output[i])) {
            r = MINE_ERROR_ALLOC_MEM;
            goto exit_with_error;
        }
        memset(env->output[i], 0, env->m);
    }

    for(i=0; i<env->n;i++) {
        if((fgets(s, SMAX, fp)) != NULL) {
            @<stripe newline from a string |s|@>@;
            if(strlen(s) != env->m) {
                printf("eror read %d(%d) charactors of line %d: %s", 
                        env->m, strlen(s), env->n, s);
                r = MINE_ERROR_INPUT_PARSE;
                goto exit_with_error;
            }
            strcat(env->board[i], s);            
        }
        else {
            r = MINE_ERROR_INPUT_PARSE;
            goto exit_with_error;
        }
    }
    *ptr_env = env;
    return MINE_ERROR_NO_ERROR;
exit_with_error:
    mine_board_free(env);
    return r;
}
void mine_board_free(mine_board_t* env)
{   
    int i;
    if(env) {
        if(env->n){
            for(i=0;i<env->n;i++) {
                free(env->board[i]);
                free(env->output[i]);    
            }
            if(env->board) free(env->board);
            if(env->output) free(env->output);
        }
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

@ 
@d xDUMP
@<rout...@>+=
int mine_board_parse(mine_board_t* env)
{
    int n,m;    
    int mm;
    int nn;
    @<declare ref points@>@;
    n = env->n;
    m = env->m;
    @<clear nine refs@>@;
    
    for(nn=0;nn<n;nn++){
        for(mm=0;mm<m;mm++) {
            @<boundary refs@>@;
            @<fill all refs@>@;
            @<count refs@>@;
            @<clear nine refs@>@;
#ifdef DUmmP
            printf("%c ", env->output[nn][mm]);
#endif
        }
#ifdef DUMP
        printf("\r\n");
#endif
    }
    return 0;
}
@ @<declare ref points@>=
int a1, a2, a3;
int b1, b2, b3;
int c1, c2, c3;
 
@ @<clear nine refs@>+=
a1=a2=a3=b1=b3=c1=c2=c3=-1;
b2=0;

@ @<boundary refs@>=
if(mm==0) {
    a1=b1=c1=0;
}
if (mm== (m-1)){
    a3=b3=c3=0;
}
if(nn==0) {
    a1=a2=a3=0;

}
if (nn== (n-1)){
    c1=c2=c3=0;
}
 
@ @<fill all refs@>=
if(a1 !=0) {
    a1=is_it_mine(env->board[nn-1][mm-1]);
}
if(a2 !=0) {
    a2=is_it_mine(env->board[nn-1][mm]);
}
if(a3 !=0) {
    a3=is_it_mine(env->board[nn-1][mm+1]);
}

if(b1 !=0) {
    b1=is_it_mine(env->board[nn][mm-1]);
}
b2=is_it_mine(env->board[nn][mm]);
if(b3 !=0) {
    b3=is_it_mine(env->board[nn][mm+1]);
}
if(c1 !=0) {
    c1=is_it_mine(env->board[nn+1][mm-1]);
}
if(c2 !=0) {
    c2=is_it_mine(env->board[nn+1][mm]);
}
if(c3 !=0) {
    c3=is_it_mine(env->board[nn+1][mm+1]);
}
@ @<rout...@>+=
int is_it_mine(char c)
{
    if(c=='*') return 1;
    if(c=='.') return 0;
    return -1;
}

@ @<count refs@>=
if(b2) {
    env->output[nn][mm] = '*';
}
else
    env->output[nn][mm] = '0' + (char)(a1+a2+a3+b1+b3+c1+c2+c3);


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
    char* ref_board[3] = { 
        "*...",
        "..*.",
        "...."};
    for(int n=0;n<env->n;n++) {
        for(int m=0;m<env->m;m++) {
            ASSERT_EQ(ref_board[n][m], env->board[n][m]);
        }
    }

    fclose(fp_in);
    mine_board_free(env);
}
@ @<tests...@>+=
TEST_F(mine_field_test, test_parse_the_input)
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
    r = mine_board_parse(env);
    ASSERT_EQ(0, r);
    char* ref_output[3] ={
        "*211",
        "12*1",
        "0111"
    };
    for(int n=0;n<env->n;n++) {
        for(int m=0;m<env->m;m++) {
            ASSERT_EQ(ref_output[n][m], env->output[n][m]);
        }
    }
    fclose(fp_in);
    mine_board_free(env);
}


@ Index.
