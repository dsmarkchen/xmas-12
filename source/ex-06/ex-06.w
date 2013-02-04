% a little 16pt hskip for a line
\def\midline#1{\line{\hskip16pt\relax#1\hfil}}

@ This is the exercise --- {\tt ``Fizz Buzz''}.

Write a program that prints the numbers from 1 to 100. But for multiples of
three print ``Fizz'' instead of the number and for the multiples of five print
``Buzz''. For numbers which are multiples of both three and five print
``FizzBuzz''.

Sample output:

{\tt
\midline{1}
\midline{2}
\midline{Fizz}
\midline{4}
\midline{Buzz}
\midline{Fizz}
\midline{7}
\midline{8}
\midline{Fizz}
\midline{Buzz}
\midline{11}
\midline{Fizz}
\midline{13}
\midline{14}
\midline{FizzBuzz}
\midline{16}
\midline{17}
\midline{Fizz}
\midline{19}
\midline{Buzz}
\midline{... etc up to 100} 
}

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
