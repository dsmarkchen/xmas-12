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


@ First Test case. Create a Integer range class, initialize an object with a
constructor.

@<tests...@>+=
TEST_F(ex_test, test_constructor_with_given_range)
{
    CIntRange* p = CIntRange(0, 10);
    ASSERT_NE(NULL, p);
}

@ 
@d SMAX 100
@<rout...@>+=


@ Index.
