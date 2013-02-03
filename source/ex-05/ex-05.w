% a little 16pt hskip for a line
\def\midline#1{\line{\hskip16pt\relax#1\hfil}}

@ This is the exercise --- {\tt ``Recently-Used List''}.

Develop a recently-used-list class to hold strings uniquely in Last-In-First-Out order.

\midline{A recently-used-list is initially empty.}
\midline{The most recently added item is first, the leastrecently added item is last.}
\midline{Items can be looked up by index, which counts from zero.}
\midline{Items in the list are unique, so duplicate insertions are moved rather than added.}

Optional extras:

\midline{Null insertions (empty strings) are not allowed.}

{\noindent \hskip16pt\relax A bounded capacity can be specified, so there is an upper
limit to the number of items contained, with the least recently added items
dropped on overflow.}

\bigskip Here code starts:

@c
@<includes@>@/
@<types@>@/
@<routines@>@/
@<tests@>@/

@ @<incl...@>+=
#include <stdio.h>


@ I use google gtest for TDD.
@<incl...@>+=
#include <gtest/gtest.h>


@ First Test case.

@ type of the recent used class.
@d SMAX 512
@d CAPACITY 25 
@<types@>+=
typedef struct str_item_struct {
    char s[SMAX]; // string
    void* prev;
} str_item_t;

class CRecently_Used_List
{
    size_t m_capacity;
    str_item_t* m_item;
    size_t m_total; // current total items;
public:
    CRecently_Used_List();   

    int get(char* s, size_t ssize, size_t pos);

    int push(char* s);
    int pop(char* s, size_t ssize);
    int find(char*s, size_t ssize, size_t pos);

    int set_capacity(size_t cap){m_capacity = cap; return E_NOERR;};
};

@ test type 
@<types@>+=
class ex_test : public testing::Test
{
};


@ 
@<tests...@>+=
TEST_F(ex_test, test_initialize_as_empty)
{
    char s[SMAX];
    CRecently_Used_List obj;
    int r = obj.get(s, SMAX, 0);
    ASSERT_EQ(E_EMPTY, r);
}
@ 
@d E_NOERR             0
@d E_EMPTY            -1
@d E_OUT_OF_RANGE     -2
@d E_DUPLICATE        -3
@d E_EMPTY_STR        -4
@d E_OUT_OF_CAPACITY  -5
@<rout...@>+=
 
CRecently_Used_List::CRecently_Used_List() 
{
    m_capacity = CAPACITY;
    m_total = 0;
    m_item = NULL;   
}
  
int CRecently_Used_List::get(char* s, size_t ssize, size_t pos)
{
    if(m_item == NULL) return E_EMPTY;
}

@ Test last in first out.
@<tests...@>+=
TEST_F(ex_test, test_last_in_first_out)
{
    int r;
    char s[SMAX];
    char* s1 = "Adam";
    char* s2 = "Eve";
    char* s3 = "Serpent";
    CRecently_Used_List obj;
    obj.push(s1);
    obj.push(s2);
    obj.push(s3);
    obj.pop(s, SMAX);
    ASSERT_STREQ(s3, s);
    obj.pop(s, SMAX);
    r = obj.pop(s, SMAX);
    ASSERT_STREQ(s1, s);
    ASSERT_EQ(E_NOERR, r);
}

@ @<rout...@>+=

int CRecently_Used_List::push(char* s)
{
    str_item_t* p = (str_item_t*) m_item;
    @<process when empty string@>@;
    @<process when out of capacity@>@;
    @<process when duplicate item@>@;  
    str_item_t* ptr = (str_item_t*)malloc(sizeof(str_item_t));
    memset(ptr, 0, sizeof(str_item_t));
    sprintf(ptr->s, s);
    ptr->prev = NULL;
    if(m_item) 
        ptr->prev = m_item;
    m_item = ptr;
    m_total++;
    return 0;
}
int CRecently_Used_List::pop(char* s, size_t ssize)
{
    str_item_t* ptr;
    if(!m_item) return E_EMPTY;
    ptr = (str_item_t*) m_item->prev;
    sprintf(s, m_item->s);
    free(m_item);
    m_item= ptr;
    return 0;
}
@ Test of lookup.
@<tests...@>+=

TEST_F(ex_test, test_look_up)
{
    int r;
    char s[SMAX];
    char* s1 = "Adam";
    char* s2 = "Eve";
    char* s3 = "Serpent";
    CRecently_Used_List obj;
    obj.push(s1);
    obj.push(s2);
    obj.push(s3);
    obj.find(s, SMAX, 0);
    ASSERT_STREQ(s3, s);
    obj.find(s, SMAX, 2);
    ASSERT_STREQ(s1, s);
} 

@ @<rout...@>+=
int CRecently_Used_List::find(char*s, size_t ssize, size_t pos)
{
    
    str_item_t* p = (str_item_t*)m_item;
    if(!p) return E_EMPTY;
    for(int i=0; i<pos;i++){
         p = (str_item_t*)(p->prev);
         if(!p) return E_OUT_OF_RANGE;
    }
    sprintf(s, p->s);
    return E_NOERR;
}
@ Test of no duplicate.
@<tests...@>+=
TEST_F(ex_test, test_no_duplicate)
{
    int r;
    char* s1 = "Adam";
    char* s2 = "Adam";
    CRecently_Used_List obj;
    r = obj.push(s1);
    ASSERT_EQ(E_NOERR, r);
    r = obj.push(s2);
    ASSERT_EQ(E_DUPLICATE, r);
 } 
@ @<process when duplicate item@>=  
p = (str_item_t*) m_item;
for(int i=0;;i++) {
    if(p == NULL) break;
    if(strcmp(s, p->s) == 0) {
        return E_DUPLICATE;
    }
    p = (str_item_t*)(p->prev);
}

@ Test of empty string.
@<tests...@>+=
TEST_F(ex_test, test_empty_string)
{
    int r;
    char* s1 = "Adam";
    char* s2 = "";
    CRecently_Used_List obj;
    r = obj.push(s1);
    ASSERT_EQ(E_NOERR, r);
    r = obj.push(s2);
    ASSERT_EQ(E_EMPTY_STR, r);
 } 
@ @<process when empty string@>=
if(strlen(s) == 0) return E_EMPTY_STR;

@ Test of capacity.
@<tests...@>+=
TEST_F(ex_test, test_of_capacity)
{
    int r;
    char s[SMAX];
    char* s1 = "Adam";
    char* s2 = "Eve";
    CRecently_Used_List obj;
    obj.set_capacity(25);
    for(int i=0;i<25;i++) { 
        sprintf(s, "str %02d", i); 
        r = obj.push(s);
        ASSERT_EQ(E_NOERR, r);
    }
    r = obj.push(s1);
    ASSERT_EQ(E_NOERR, r);
    r = obj.push(s2);
    ASSERT_EQ(E_NOERR, r);
    r = obj.pop(s, SMAX);
    ASSERT_STREQ(s2, s);
    r = obj.pop(s, SMAX);
    ASSERT_STREQ(s1, s);
    r = obj.pop(s, SMAX);
    ASSERT_STREQ("str 24", s);
}
@ @<process when out of capacity@>=
if(m_total == m_capacity) {
    // drop of the first
    for(int i=0;;i++) {
        str_item_t* p0 = (str_item_t*) p->prev;
        if((str_item_t*)(p0->prev) == NULL) {
            p->prev = NULL;
            free(p0);
            break;
        }
        p = p0;
    }
}
 

@ Index.
