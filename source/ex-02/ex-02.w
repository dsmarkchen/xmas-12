@* The second exercise.  {\sl Number Names}. Spell out a number. For example

\smallskip 99 -–|>| ninety nine
\smallskip 300 -–|>| three hundred
\smallskip 310 –-|>| three hundred and ten
\smallskip 1501 –-|>| one thousand, five hundred and one
\smallskip 12609 –-|>| twelve thousand, six hundred and nine
\smallskip 512607 -–|>| five hundred and twelve thousand,
six hundred and seven
\smallskip 43112603 –-|>| forty three million, one hundred and
twelve thousand,
six hundred and three

@c
@<includes@>@/
@<types@>@/
@<routines@>@/
@<tests@>@/

@ @<incl...@>+=
#include <stdio.h>


@* First Test case.
Given a number 9, spell 'nine'.

@ I use google gtest.
@<incl...@>+=
#include <gtest/gtest.h>


@ @<types@>+=
class spell_test : public testing::Test
{
};


@ Now we have the first test case.
@<tests...@>+=
TEST_F(spell_test, test_to_spell_nine)
{
    const size_t spell_buf_size = 256;
    char spell_buf[spell_buf_size] = {0};
    
    int r = spell_numbers(9, spell_buf, spell_buf_size) ;
    ASSERT_EQ(0, r);
    ASSERT_STREQ("nine", spell_buf);
}

@* Implementation.
@<rout...@>+=
int spell_tenth(int n,  char* out_buf, size_t out_buf_size)
{
    int d_10 = n;
    char d_10_name[20];
    if(d_10 > 9) {
        for(int i=0; i<NUM_NODE_TEN_MAX;i++) {
            if(d_10 == NUM_TABLE_10[i].n) {
                sprintf(d_10_name, "%s", NUM_TABLE_10[i].name);
                n-=NUM_TABLE_10[i].n;
                break;
            }
            if((i+1) < NUM_NODE_TEN_MAX) {
                if(d_10 < NUM_TABLE_10[i+1].n) {
                    sprintf(d_10_name, "%s", NUM_TABLE_10[i].name);
                    n-=NUM_TABLE_10[i].n;
                    break;
                }
            }
            else { // we get to the last one
                 sprintf(d_10_name, "%s", NUM_TABLE_10[i].name);
                 n-=NUM_TABLE_10[i].n;
            }
        }
        sprintf(out_buf, "%s",  d_10_name);
    }
    return n; 
}
 
int spell_digit(int n,  char* out_buf, size_t out_buf_size)
{
    int d = n%10;
    char d_name[20];
    for(int i=0; i<NUM_NODE_MAX;i++) {
        if(d == NUM_TABLE[i].n) 
            sprintf(d_name, "%s", NUM_TABLE[i].name);
    }
    sprintf(out_buf, "%s",  d_name);
    return d;

}
int spell_under_thousand(int n, char* out_buf, size_t out_buf_size)
{
    int d_100 = n/100;
    char d_100_name[20];
    if(d_100 !=0) {
        spell_digit(d_100, d_100_name, 20);
        strcat(d_100_name, " hundred");
        n -= d_100*100;
    }
    
    int d_10 = 0; // = n/10;
    char d_10_name[20] = {0};
    n = spell_tenth(n, d_10_name, 20);
    if(strlen(d_10_name)) {
        d_10 = 1;
    } 
    int d =  n%10;
    char d_name[20];
    spell_digit(d, d_name, 20);
    if(d_100 !=0) {
        if(d_10 != 0)  {
            if(d!=0)
                sprintf(out_buf, "%s and %s %s", d_100_name, d_10_name, d_name);
            else
                sprintf(out_buf, "%s and %s", d_100_name, d_10_name);
        }
        else if (d!=0)
            sprintf(out_buf, "%s and %s", d_100_name,  d_name);
        else 
            sprintf(out_buf, "%s", d_100_name);
    }
    else {
        if(d_10 != 0 && d != 0) 
            sprintf(out_buf, "%s %s", d_10_name, d_name);
        else if(d_10 != 0 && d == 0) 
            sprintf(out_buf, "%s",  d_10_name);
        else
            sprintf(out_buf, "%s",  d_name);
    }
    return 0;
}


int spell_under_million(int n, char* out_buf, size_t out_buf_size)
{
    int d_1k = n/1000;
    char d_1k_name[256];
    if(d_1k !=0) {

        spell_under_thousand(d_1k,d_1k_name,256);
        strcat(d_1k_name," thousand");
        n-= d_1k*1000;
    }
    char d_out_buf[256];
    n = spell_under_thousand(n, d_out_buf, 256);
    if(d_1k != 0) {
        sprintf(out_buf, "%s, %s", d_1k_name, d_out_buf);
    }
    else
        sprintf(out_buf, "%s", d_out_buf);
    return n;
}
int spell_numbers(int n, char* out_buf, size_t out_buf_size)
{
    int d_1m = n/1000000;
    char d_1m_name[256];
     if(d_1m !=0) {
        spell_under_million(d_1m,d_1m_name,256);
        strcat(d_1m_name," million");
        n-= d_1m*1000000;
    }
    char d_out_buf[256];
    n = spell_under_million(n, d_out_buf, 256);
    if(d_1m != 0) {
        sprintf(out_buf, "%s, %s", d_1m_name, d_out_buf);
    }
    else
        sprintf(out_buf, "%s", d_out_buf);
    return n;
}


@ 
@d NUM_NODE_MAX 10
@d NUM_NODE_TEN_MAX 18
@<types@>+=
typedef struct num_node
{
    int n;
    char* name;
} num_node_t;
const num_node_t NUM_TABLE[NUM_NODE_MAX]=
{
    {0, "zero"},
    {1, "one"},
    {2, "two"},
    {3, "three"},
    {4, "four"},
    {5, "five"},
    {6, "six"},
    {7, "seven"},
    {8, "eight"},
    {9, "nine"}
};

const num_node_t NUM_TABLE_10[NUM_NODE_TEN_MAX]=
{
    {10, "ten"},
    {11, "eleven"},
    {12, "twelve"},
    {13, "thirteen"},
    {14, "fourteen"},
    {15, "fifteen"},
    {16, "sixteen"},
    {17, "seventeen"},
    {18, "eighteen"},
    {19, "nineteen"},
    {20, "twenty"},
    {30, "thirty"},
    {40, "forty"},
    {50, "fifty"},
    {60, "sixty"},
    {70, "seventy"},
    {80, "eighty"},
    {90, "ninety"}
};
@* Rest test cases.
@<tests...@>+=
TEST_F(spell_test, test_to_spell_ninety_nine)
{
    const size_t spell_buf_size = 256;
    char spell_buf[spell_buf_size] = {0};
    
    int r = spell_numbers(99, spell_buf, spell_buf_size) ;
    ASSERT_EQ(0, r);
    ASSERT_STREQ("ninety nine", spell_buf);
}


@ @<tests...@>+=
TEST_F(spell_test, test_to_spell_three_hundred)
{
    const size_t spell_buf_size = 256;
    char spell_buf[spell_buf_size] = {0};
    
    int r = spell_numbers(300, spell_buf, spell_buf_size) ;
    ASSERT_EQ(0, r);
    ASSERT_STREQ("three hundred", spell_buf);
}

@ @<tests...@>+=
TEST_F(spell_test, test_to_spell_three_hundred_and_ten)
{
    const size_t spell_buf_size = 256;
    char spell_buf[spell_buf_size] = {0};
    
    int r = spell_numbers(310, spell_buf, spell_buf_size) ;
    ASSERT_EQ(0, r);
    ASSERT_STREQ("three hundred and ten", spell_buf);
}

@ @<tests...@>+=
TEST_F(spell_test, test_to_spell_thousands)
{
    const size_t spell_buf_size = 256;
    char spell_buf[spell_buf_size] = {0};
    
    int r = spell_numbers(1501, spell_buf, spell_buf_size) ;
    ASSERT_EQ(0, r);
    ASSERT_STREQ("one thousand, five hundred and one", spell_buf);
}

@ @<tests...@>+=
TEST_F(spell_test, test_to_spell_twelve_thousands)
{
    const size_t spell_buf_size = 256;
    char spell_buf[spell_buf_size] = {0};
    
    int r = spell_numbers(12609, spell_buf, spell_buf_size) ;
    ASSERT_EQ(0, r);
    ASSERT_STREQ("twelve thousand, six hundred and nine", spell_buf);
}
@ @<tests...@>+=
TEST_F(spell_test, test_to_spell_hundred_thousands)
{
    const size_t spell_buf_size = 256;
    char spell_buf[spell_buf_size] = {0};
    char* ref_str = "five hundred and twelve thousand, six hundred and seven";
   
    int r = spell_numbers(512607, spell_buf, spell_buf_size) ;
    ASSERT_EQ(0, r);
    ASSERT_STREQ(ref_str, spell_buf);
}
@ @<tests...@>+=
TEST_F(spell_test, test_to_spell_millions)
{
    const size_t spell_buf_size = 256;
    char spell_buf[spell_buf_size] = {0};
    char* ref_str = "forty three million, \
one hundred and twelve thousand, six hundred and three";
   
    int r = spell_numbers(43112603, spell_buf, spell_buf_size) ;
    ASSERT_EQ(0, r);
    ASSERT_STREQ(ref_str, spell_buf);
}

@* Index.
