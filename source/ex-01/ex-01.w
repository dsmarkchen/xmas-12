@ This is the first exercise -- {\tt Calc Stats}.

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


@ type of element.
@<types@>+=
typedef struct elem {
    int v;
    struct elem* next;
} int_elem_t;


@ @<types@>+=
class calc_state_test : public testing::Test
{
public:
    void SetUp();

    int_elem_t a_0;
    int_elem_t a_1;
    int_elem_t a_2;
    int_elem_t a_3;
    int_elem_t a_4;
    int_elem_t a_5;
};
@ Build the test example data.
@<rout...@>+=
void calc_state_test::SetUp() 
{
    a_0.v = 6; a_0.next = &a_1;
    a_1.v = 9; a_1.next = &a_2;
    a_2.v = 15; a_2.next = &a_3;
    a_3.v = -2; a_3.next = &a_4;
    a_4.v = 92; a_4.next = &a_5;
    a_5.v = 11; a_5.next = NULL;
}
 

@ Now we have the first test case.
@<tests...@>+=
TEST_F(calc_state_test, test_minimum)
{
    int min = calc_minimum_of_elements(&a_0);
    ASSERT_EQ(-2, min);
}

@ @<rout...@>+=
int calc_minimum_of_elements(int_elem_t* node)
{
    int min;
    int r;
    int_elem_t* p; 
    if(node == NULL) return 0;

    min=node->v;
    p=node->next;

    for(;p!=NULL; p=p->next, r++) {
        if(p->v < min) min = p->v;
    }
    return min;
}

@ The test case to find the maximum value.
@<tests...@>+=
TEST_F(calc_state_test, test_maximum)
{
    int max = calc_maximum_of_elements(&a_0);
    ASSERT_EQ(92, max);
}

@ @<rout...@>+=
int calc_maximum_of_elements(int_elem_t* node)
{
    int max;
    int r;
    int_elem_t* p; 
    if(node == NULL) return 0;

    max=node->v;
    p=node->next;

    for(;p!=NULL; p=p->next, r++) {
        if(p->v > max) max = p->v;
    }
    return max;
}



@ @<tests...@>+=
TEST_F(calc_state_test, test_number_of_elements)
{
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
    a_0.next = NULL;
     
    int nums = calc_number_of_elements(&a_0);
    ASSERT_EQ(1, nums);
}

@ Test average.
@<tests...@>+=
TEST_F(calc_state_test, test_average_of_elements)
{
    float ave = calc_average_of_elements(&a_0);
    ASSERT_FLOAT_EQ(21.833333, ave);    
}

@ @<rout...@>+=
float calc_average_of_elements(int_elem_t* node)
{
    
    float sum = 0;
    int r;
    int_elem_t* p; 
    if(node == NULL) return 0;
    for(r=0, p=node;p!=NULL; p=p->next, r++) {
        sum+=p->v;
    }
    return sum/r;
} 

@ More boundary check. It will return 0 if the sequence has no element.
@<tests...@>+=

TEST_F(calc_state_test, boundary_check_with_input_null)
{
    int nums = calc_number_of_elements(NULL);
    ASSERT_EQ(0, nums);
    int min = calc_minimum_of_elements(NULL);
    ASSERT_EQ(0, min);    
    int max = calc_maximum_of_elements(NULL);
    ASSERT_EQ(0, max);    
    float ave = calc_average_of_elements(NULL);
    ASSERT_FLOAT_EQ(0, ave);   
}


