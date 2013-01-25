@ This is the second exercise -- {\tt Number Names}.

Spell out a number. For example

\smallskip 99 –> ninety nine
\smallskip 300 –> three hundred
\smallskip 310 –> three hundred and ten
\smallskip 1501 –> one thousand, five hundred and one
\smallskip 12609 –> twelve thousand, six hundred and nine
\smallskip 512607 –> five hundred and twelve thousand,
six hundred and seven
\smallskip 43112603 –> forty three million, one hundred and
twelve thousand,
six hundred and three

@c
@<includes@>@/
@<types@>@/
@<routines@>@/
@<tests@>@/

@ @<incl...@>+=
#include <stdio.h>


@ First Test case.
Given a number 9, spell 'nine'

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
    ASSERT_STREQ("9", spell_buf);
}

@ @<rout...@>+=
int spell_numbers(int n, char* out_buf, size_t out_buf_size)
{
    sprintf(out_buf, "%d", 9);
    return 0;
}

