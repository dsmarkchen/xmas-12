% a little 16pt hskip for a line
\def\midline#1{\line{\hskip16pt\relax#1\hfil}}

@ This is the exercise --- {\tt ``Bowling''}.

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

@ test suite.
@<types@>+=
class ex_test : public testing::Test
{
};


@ First Test case.
@<tests...@>+=
TEST_F(ex_test, test_of_x_as_strike)
{
    int n;
    n = calc_bowling("X|X|X|X|X|X|X|X|X|X||XX");
    ASSERT_EQ(300, n);
}

@ 
@d EVT_STRIKE  1
@d EVT_SPARE   2 
@d EVT_MISS    3
@d EVT_BOUND   4
@<rout...@>+=
int calc_bowling(char* s)
{
    int score;
    int i; 
    int frame;
    score = 0;
    frame = 0;
    for(i=0;s[i]!=0;i++){
        if((s[i] == 'X') && (s[i+1] == '|')) {
            score += 10;
            i+=2;
            frame ++;
        }
        if(frame==10) break;
    }
    printf("sum %d\n", sum);
    for(;s[i]!=0;i++) {
        if(s[i++] == 'X') sum += 20;
    }
    return sum;
}
@ Index.
