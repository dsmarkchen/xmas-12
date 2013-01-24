@ This is the first exercise -- {\b Calc Stats}.

Your task is to process a sequence of integer numbers
to determine the following statistics:

\smallskip minimum value
\smallskip maximum value
\smallskip number of elements in the sequence
\smallskip average value

@c
@<includes@>@/
@<routines@>@/
@<tests@>@/

@ @<incl...@>+=
#include <stdio.h>

@ First Test case.
Given a list of numbers 6, 9, 15, -2, 92, 11, minimum value is -2.

@ I use google gtest.
@<incl...@>+=
#include <gtest/gtest.h>
class calc_state_test : public testing::Test
{
};

@ @<tests...@>+=
TEST_F(calc_state_test, test_minimum)
{
    int a[6] = {6, 9, 15, -2, 92, 11};
    int min = calc_minimum_of_array(a, 6);
    ASSERT_EQ(-2, min);
}

@ @<rout...@>+=
int calc_minimum_of_array(int a[], size_t nums)
{
    return 0;
}
