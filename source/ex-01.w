@ This is the first exercise -- {\b Calc Stats}.

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
    int i;
    int min = a[0];
    
    for(i=1;i<nums;i++) {
        if (a[i] < min ) min = a[i];
    }
    return min;
}

@ The test case to find the maximum value.
@<tests...@>+=
TEST_F(calc_state_test, test_maximum)
{
    int a[6] = {6, 9, 15, -2, 92, 11};
    int max = calc_maximum_of_array(a, 6);
    ASSERT_EQ(92, max);
}

@ @<rout...@>+=
int calc_maximum_of_array(int a[], size_t nums)
{
    int i;
    int max = a[0];
    
    for(i=1;i<nums;i++) {
        if (a[i] > max ) max = a[i];
    }
    return max;
}


@ type of element.
@<types@>+=
typedef struct elem {
    int v;
    struct elem* next;
} int_elem_t;

@ @<tests...@>+=
TEST_F(calc_state_test, test_number_of_elements)
{
    int_elem_t a_0;
    int_elem_t a_1;
    int_elem_t a_2;
    int_elem_t a_3;
    int_elem_t a_4;
    int_elem_t a_5;
    a_0.v = 6; a_0.next = &a_1;
    a_1.v = 9; a_1.next = &a_2;
    a_2.v = 15; a_2.next = &a_3;
    a_3.v = -2; a_3.next = &a_4;
    a_4.v = 92; a_4.next = &a_5;
     a_5.v = 11; a_5.next = NULL;

    int nums = calc_number_of_elements(&a_0);
    ASSERT_EQ(6, nums);
}

@ @<rout...@>+=
int calc_number_of_elements(int_elem_t* node)
{
    int r;
    int_elem_t* p; 
    for(r=0, p=node;p!=NULL; p=p->next, r++);
    return r;
}

@ @<tests...@>+=
TEST_F(calc_state_test, test_number_of_elements_if_only_one)
{
    int_elem_t a_0;
    a_0.v = 6; a_0.next = NULL;
     
    int nums = calc_number_of_elements(&a_0);
    ASSERT_EQ(1, nums);
}

@ Test average.
@<tests...@>+=
TEST_F(calc_state_test, test_average_of_elements)
{
    int_elem_t a_0;
    int_elem_t a_1;
    int_elem_t a_2;
    int_elem_t a_3;
    int_elem_t a_4;
    int_elem_t a_5;
    a_0.v = 6; a_0.next = &a_1;
    a_1.v = 9; a_1.next = &a_2;
    a_2.v = 15; a_2.next = &a_3;
    a_3.v = -2; a_3.next = &a_4;
    a_4.v = 92; a_4.next = &a_5;
    a_5.v = 11; a_5.next = NULL;
    float ave = calc_average_of_elements(&a_0);
    ASSERT_FLOAT_EQ(21.833333, ave);    
}

@ @<rout...@>+=
float calc_average_of_elements(int_elem_t* node)
{
    
    float sum = 0;
    int r;
    int_elem_t* p; 
    for(r=0, p=node;p!=NULL; p=p->next, r++) {
        sum+=p->v;
    }
    return sum/r;
} 
