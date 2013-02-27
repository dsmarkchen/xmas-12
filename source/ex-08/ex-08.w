% a little 16pt hskip for a line
@s int CRange
@s int CIntRange
\def\midline#1{\line{\hskip16pt\relax#1\hfil}}

@ This is the exercise --- {\tt ``range''}.

In mathematics we denote a range using open-closed bracket notation: $[0,10)$
means all real numbers equal to or greater than zero, but less than ten. So 0
lies in this range, while 10 does not.

\smallskip\noindent 1. Develop an integer range class, that has the following
operations:

\midline{Construction.}

For example: ``r = new Range(0,10) // modify to fit your language's syntax''

\midline{Checking whether an integer lies in the range.}

What name do you think is appropriate?

\midline{Intersection of two ranges}

For example, the intersection of range $[0..3] (numbers 0, 1, 2, 3)$ and
range $[2..4]$ is the range $[2..3]$

Develop another class to represent floating point ranges, with the same
operations.

While developing the floating point range class, think about how it differs
from the integer range.  Is it possible to modify the behaviour of one of them
to become more consistent with the behaviour of the other? The more uniform
their behaviour, the easier the classes will be to use.  If you modify one of
the classes – do you feel confident you do not break anything? If you don't
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
    CIntRange obj1(0, 10);
    CIntRange obj2(0, 10);
    ASSERT_EQ(obj1, obj2);
}
@
@d X_TRUE 1
@d X_FALSE 0
@<type...@>+=
typedef unsigned char X_BOOL;

class CIntRange{
    int m_a;
    int m_b;
    X_BOOL m_incl_a;
    X_BOOL m_incl_b;

public:
    CIntRange(int a, int b, X_BOOL incl_a = X_TRUE, X_BOOL incl_b=X_TRUE)
        : m_a(a), m_b(b) 
    { 
        m_incl_a = incl_a;
        m_incl_b = incl_b;
    }
    X_BOOL operator==(const CIntRange & other) const;

    CIntRange intersect(CIntRange obj2);
};
@ 
@<rout...@>+=
X_BOOL CIntRange::operator==(const CIntRange & other) const
{
    if((m_a == other.m_a)&&
            (m_b == other.m_b) &&
            (m_incl_a == other.m_incl_a) &&
            (m_incl_b == other.m_incl_b))
        return X_TRUE;
    return X_FALSE;
}

@ Test assignment @<test...@>+=
TEST_F(ex_test, test_assignment)
{
    CIntRange a(0,10);
    CIntRange b(0,1);
    CIntRange c(0,10);
    b = a;
    ASSERT_EQ(c, b);

}
@ Test intersection
@<test...@>+=
TEST_F(ex_test, test_intersection)
{
    CIntRange a(0,3);
    CIntRange b(2,4);
    CIntRange c(2,3);
    CIntRange d = a.intersect(b);
    ASSERT_EQ(c, d);

}
@ @<rout...@>+=
CIntRange CIntRange::intersect(CIntRange obj2)
{
    int min, max;
    min = this->m_a;
    if (min < obj2.m_a )  min = obj2.m_a;
    max = this->m_b;
    if(max > obj2.m_b) max = obj2.m_b;
    printf("result: %d %d\r\n", min, max);
    return CIntRange(min, max);
    
}

@ Test with float. Can I do it with template?
@<test...@>+=
TEST_F(ex_test, test_assignment_with_template) @/
{
    CRange<int> a(0,10);
    CRange<int> b(0,1);
    CRange<int> c(0,10);
    b = a;
    ASSERT_EQ(c, b);

}

@ @<types...@>+=
template <class T> class CRange {
public: 
    CRange<T> (T a, T b ) {m_min=a; m_max=b;}   
    X_BOOL operator==(const CRange<T> & other) const;
    CRange<T> intersect(CRange<T> obj2);
    T m_min; 
    T m_max;
};

@
@<rout...@>+=
template <class T>
X_BOOL CRange<T>::operator==(const CRange<T> & other) const
{
    if((m_min == other.m_min)&&
            (m_max == other.m_max))
        return X_TRUE;
    return X_FALSE;
}

@ Test for intersact with template
@<test...@>+=
TEST_F(ex_test, test_intersection_with_template)
{
    CRange<int> a(0,3);
    CRange<int> b(2,4);
    CRange<int> c(2,3);
    CRange<int> d = a.intersect(b);
    ASSERT_EQ(c, d);

}

@ @<rout...@>+=
template <class T>
CRange<T> CRange<T>::intersect(CRange<T> obj2)
{
    T min, max;
    min = this->m_min;
    if (min < obj2.m_min )  min = obj2.m_min;
    max = this->m_max;
    if(max > obj2.m_max) max = obj2.m_max;
    return CRange<T>(min, max);
 
}
@ Test float intersact
@<test...@>+=
TEST_F(ex_test, test_intersection_with_template_on_float)
{
    CRange<float> a(0.5,3.5);
    CRange<float> b(2.5,4.5);
    CRange<float> c(2.5,3.5);
    CRange<float> d = a.intersect(b);
    ASSERT_EQ(c, d);

}

@ Index.
