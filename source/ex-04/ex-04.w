@ This is the exercise -- {\tt Monty Hall}.

Suppose you're on a game show, and you're given the choice of three doors:
Behind one door is a car; behind the others, goats. You pick a door, say No. 1,
and the host, who knows what's behind the doors, opens another door, say No. 3,
which has a goat. He then says to you, "Do you want to pick door No. 2?" Is it
to your advantage to switch your choice?

Simulate at least a thousand games using three doors for each strategy and show
the results in such a way as to make it easy to compare the effects of each
strategy.

@c
@<includes@>@/
@<types@>@/
@<datas@>@/
@<routines@>@/
@<tests@>@/

@ @<incl...@>+=
#include <stdio.h>
@ identify doors.
@<datas@>+=
char a,b,c;


@ identify goat and car.
@d GOAT '.'
@d CAR  '*'

@ First Test case.


@ I use google gtest.
@<incl...@>+=
#include <gtest/gtest.h>

@ srand set the start value of rand.
@<types@>+=
class monty_test : public testing::Test
{
    virtual void SetUp() {
         srand( (unsigned)time( NULL ) ); 
    }
};

@ @<rout...@>+=
bool is_it_car(char c)
{
    return (c==CAR);
}
bool  is_it_goat(char c)
{
    return (c==GOAT);
}
char get_from_door(int i) 
{
    if(i==0) return a;
    if(i==1) return b;
    return c;
}

@ Now we have the first test case.
@<tests...@>+=
TEST_F(monty_test, game_start_with_one_car_two_goats)
{
    int n_car;
    int n_goat;
    int r = monty_init();
    ASSERT_EQ(0, r);
    n_car = 0;
    n_goat = 0;
    if(is_it_car(a)) n_car++; 
    if(is_it_car(b)) n_car++; 
    if(is_it_car(c)) n_car++; 
    if(is_it_goat(a)) n_goat++; 
    if(is_it_goat(b)) n_goat++; 
    if(is_it_goat(c)) n_goat++; 
    ASSERT_EQ(1, n_car);
    ASSERT_EQ(2, n_goat);

}

@ @<rout...@>+=
int monty_init()
{
    int r = rand() % 3; // randam number of 0 1 2 
    switch(r) {
    case 0:
        a = CAR;
        b = c = GOAT;
        break;
    case 1:
        b = CAR;
        a = c= GOAT;
        break;
    case 2:
        c = CAR;
        a = b = GOAT;
        break;
    }
    return 0;
}


@ @<rout...@>+=
int client_select()
{
    int r = rand()%3;
    
    return r;
}

@ @<tests...@>+=
TEST_F(monty_test, game_of_client_select)
{
    int r = monty_init();
    ASSERT_EQ(0, r);
    int sel = client_select(); // sel should be 0, or 1, or 2
    ASSERT_GE(sel, 0);
    ASSERT_LE(sel, 2);
    
}

@ Monty the host pick up one
@<rout...@>+=
int monty_pickup(int client_sel)
{
    int mty;
montry_pick_entry:
    mty = rand()%3;
    if(mty != client_sel) {
        char x = get_from_door(mty); 
        if(is_it_goat(x)) return mty;
    }
    goto montry_pick_entry;
}


@ @<tests...@>+=
TEST_F(monty_test, game_of_monty_pickup)
{
    int r = monty_init();
    ASSERT_EQ(0, r);
    int sel = client_select(); 
    int monty = monty_pickup(sel);
    ASSERT_GE(monty, 0);
    ASSERT_LE(monty, 2);
    ASSERT_NE(sel, monty);
    char x = get_from_door(monty);
    ASSERT_EQ(GOAT, x); 

}
@ Strategy 1, the user does not switch his or her selection.
@<type...@>+=
typedef enum { STRATEGY_1 = 1, STRATEGY_2 = 2} strategy_t;

@
@d WIN 1
@d LOSE 0
@<rout...@>+=

int switches(int s1, int s2)
{
    if(s1 == 0 && s2 == 1) return 2;
    if(s1 == 0 && s2 == 2) return 1;
    if(s1 == 1 && s2 == 0) return 2;
    if(s1 == 1 && s2 == 2) return 0;
    if(s1 == 2 && s2 == 0) return 1;
    if(s1 == 2 && s2 == 1) return 0;
    return -1; // this never happens
}
int game_play(strategy_t s, int cl_sel,  int mty_sel)
{
    int r;
    switch (s) {
    case STRATEGY_1:
        r=cl_sel;
        break;
    case STRATEGY_2:
        r = switches(cl_sel, mty_sel);
        break;
    default:
        return LOSE;
    }
    int x = get_from_door(r);
    if(is_it_car(x)) return WIN;
    return LOSE;
}


@ @<tests...@>+=
TEST_F(monty_test, game_of_play_with_stragety_1)
{
    int r = monty_init();
    ASSERT_EQ(0, r);
    int sel = client_select(); 
    int monty = monty_pickup(sel);
    game_play(STRATEGY_1, sel, monty);
    
}
@ @<tests...@>+=
TEST_F(monty_test, game_of_play_for_thousand_times)
{
    int x;
    int s;
    int s1=0;
    int s2=0;
    int n1=0;
    int n2=0;
    for(int i=0;i<1000;i++) {
        monty_init();
        int sel = client_select();
        int mty = monty_pickup(sel);
        s = rand() %2;
        if(s == 0) {
            n1++;
            x = game_play(STRATEGY_1, sel, mty);
            if(x==WIN) s1++;
        }
        else {
            n2++;
            x = game_play(STRATEGY_2, sel, mty);
            if(x==WIN) s2++;
        }

    }
    printf("no switch: %d of %d wins \r\nswitched: %d of %d wins\r\n", n1, s1, n2,s2);
    ASSERT_GT(s2, s1);
}
@ I am using clock.
@<incl...@>+=
#include<time.h>
@ Index.
