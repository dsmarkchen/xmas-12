% a little 16pt hskip for a line
\def\midline#1{\line{\hskip16pt\relax#1\hfil}}

@ This is the exercise --- {\tt ``range''}.

In mathematics we denote a range using open-closed bracket notation: $[0,10)$
means all real numbers equal to or greater than zero, but less than ten. So 0
lies in this range, while 10 does not.

\smallskip\noindent 1. Develop an integer range class, that has the following
operations:

\midline{Construction.}

$For example: r = new Range(0,10) // modify to fit your language's syntax$

\midline{Checking whether an integer lies in the range.}

What name do you think is appropriate?

\midline{Intersection of two ranges}

For example, the intersection of range $[0..3] (numbers 0, 1, 2 \& 3)$ and
range $[2..4]$ is the range $[2..3]$

 Develop another class to represent floating point ranges, with the same
operations.

    While developing the floating point range class, think about how it differs
from the integer range.  Is it possible to modify the behaviour of one of them
to become more consistent with the behaviour of the other? The more uniform
their behaviour, the easier the classes will be to use.  If you modify one of
the classes – do you feel confident you do not break anything? If you don’t
feel confident, what can you do about that?

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
TEST_F(ex_test, test_of_print_a_number_3)
{
    int n;
    char s[SMAX];
    char* ref_s = "Fizz";
    n = 3;
    Fizz_Buzz(3, s, SMAX);
    ASSERT_STREQ(ref_s, s);
}

@ 
@d SMAX 100
@<rout...@>+=
void Fizz_Buzz(int n, char* s, size_t ssize)
{
    int update_5 = 0;
    int update_3 = 0;
    if(n % 5 == 0) {
        sprintf(s, "Buzz");
        update_5 = 1;
    }
    if(n % 3 == 0) {
        sprintf(s, "Fizz");
        update_3 = 1;
    }
    if(update_5 && update_3)  {
        sprintf(s, "FizzBuzz");
    }
    if(!update_3 && !update_5) 
        sprintf(s, "%d", n);
}

@ @<tests...@>+=
TEST_F(ex_test, test_of_1_to_3)
{
    int n;
    char s[SMAX];
    char* ref_s = "Fizz";
    Fizz_Buzz(1, s, SMAX);
    ASSERT_STREQ("1", s);
    Fizz_Buzz(2, s, SMAX);
    ASSERT_STREQ("2", s);
    Fizz_Buzz(3, s, SMAX);
    ASSERT_STREQ(ref_s, s);
}

@ @<tests...@>+=
TEST_F(ex_test, test_of_5)
{
    int n;
    char s[SMAX];
    char* ref_s = "Buzz";
    Fizz_Buzz(5, s, SMAX);
    ASSERT_STREQ(ref_s, s);
}

@ @<tests...@>+=
TEST_F(ex_test, test_of_6)
{
    int n;
    char s[SMAX];
    char* ref_s = "Fizz";
    Fizz_Buzz(6, s, SMAX);
    ASSERT_STREQ(ref_s, s);
}
@ @<tests...@>+=
TEST_F(ex_test, test_of_15)
{
    int n;
    char s[SMAX];
    char* ref_s = "FizzBuzz";
    Fizz_Buzz(15, s, SMAX);
    ASSERT_STREQ(ref_s, s);
}
@ Test of print 100 numbers
@<tests...@>+=
TEST_F(ex_test, test_of_print_100_numbers)
{
    char s[SMAX];
    for(int n=1; n<=100;n++) {
        Fizz_Buzz(n, s, SMAX);
        printf("%s\r\n", s);
    }
}

@ Index.
