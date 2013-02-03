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


@ First Test case.

@ I use google gtest.
@<incl...@>+=
#include <gtest/gtest.h>


@ type of the recent used class.
@d SMAX 512
@<types@>+=
typedef struct str_item_struct {
    char s[SMAX]; // string
    void* prev;
} str_item_t;

class CRecently_Used_List
{
    size_t m_capacity;
    str_item_t* m_item;
public:
    CRecently_Used_List();   

    int get(char* s, size_t ssize, size_t pos);

    int push(char* s);
    int pop(char* s, size_t ssize);
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
@d E_NOERR  0
@d E_EMPTY -1
@<rout...@>+=
 
CRecently_Used_List::CRecently_Used_List() 
{
    m_capacity = 0;
    m_item = NULL;   
}
  
int CRecently_Used_List::get(char* s, size_t ssize, size_t pos)
{
    if(m_item == NULL) return E_EMPTY;
}

@ Test
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
    str_item_t* ptr = (str_item_t*)malloc(sizeof(str_item_t));
    memset(ptr, 0, sizeof(str_item_t));
    sprintf(ptr->s, s);
    ptr->prev = NULL;
    if(m_item) 
        ptr->prev = m_item;
    m_item = ptr;
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

@ Index.
