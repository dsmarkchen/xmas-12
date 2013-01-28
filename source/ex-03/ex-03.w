@ This is the exercise -- {\tt mine fields}.


A field of N x M squares is represented by N lines of exactly M characters each. The character ‘*’ represents a mine and the character ‘.’ represents no-mine.

Example input (a 3 x 4 mine-field of 12 squares, 2 of
which are mines)

\smallskip 3 4
\smallskip *...
\smallskip ..*.
\smallskip ....

Your task is to write a program to accept this input and produce as output a hint-field of identical dimensions where each square is a * for a mine or the number of adjacent mine-squares if the square does not contain a mine.

Example output (for the above input)

\smallskip *211
\smallskip 12*1
\smallskip 0111


Your task is to process a sequence of integer numbers
to determine the following statistics:

\smallskip minimum value
\smallskip maximum value
\smallskip number of elements in the sequence
\smallskip average value

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


@ type of element.
@<types@>+=

@ @<types@>+=
class mine_field_test : public testing::Test
{
};


@ Now we have the first test case.
@<tests...@>+=
TEST_F(mine_field_test, test_minimum)
{
    int min = 0;
    ASSERT_EQ(-2, min);
}

@ @<rout...@>+=


@ Index.
