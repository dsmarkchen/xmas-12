% a little 16pt hskip for a line
\def\midline#1{\line{\hskip16pt\relax#1\hfil}}

@ This is the exercise --- {\tt ``template engine''}.


Write a ``template engine'' meaning a way to transform template strings, ``$
Hello\ \{\$name\} $'' into ``instanced'' strings. To do that a
|variable->value| mapping must be provided. For example, if $ name=``Cenk'' $
and the template string is ``$Hello\ \{\$name\} $'' the result would be
``Hello Cenk''.
\bigskip
- Should evaluate template single variable expression:

{\tt 
\midline{$mapOfVariables.put(``name'',``Cenk'');$}
\midline{$templateEngine.evaluate(``Hello \{\$name\}'', mapOfVariables)$}
\midline{$=>  should\ evaluate\ to ``Hello\ Cenk''$}
}

- Should evaluate template with multiple expressions:

{\tt 
\midline{$mapOfVariables.put("firstName","Cenk");$}
\midline{$mapOfVariables.put("lastName","Civici");$}
\midline{$templateEngine.evaluate("Hello \{\$firstName\} \{\$lastName\}", \
mapOfVariables);$}
\midline{$=>   should evaluate to "Hello Cenk Civici"$}
}

- Should give error if template variable does not exist in the map:

{\tt 
\midline{map empty}
\midline{$templateEngine.evaluate("Hello \{\$firstName\} ", mapOfVariables);$}
\midline{$=>   should throw missingvalueexception$}
}

- Should evaluate complex cases:

{\tt 
\midline{$mapOfVariables.put("name","Cenk");$}
\midline{$templateEngine.evaluate("Hello \$\{\{\$name\}\}", mapOfVariables);$}
\midline{$=>   should evaluate to "Hello \$\{Cenk\}"$}
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


@ First Test case. map single variable expressions.
@ @<incl...@>+=
#include <map>
#include <string>
using namespace std;
@ 
@<type...@>+=
typedef string var_name_t; @/
typedef string var_value_t; @/
typedef map<var_name_t,var_value_t> var_table_t;

@ @<tests...@>+=
TEST_F(ex_test, test_of_translate_a_variable_to_string)
{
    var_table_t vars;
    vars.clear();
    vars.insert(var_table_t::value_type("name", "Mark"));  
    string s_input = "Hello {$name}";
    string s_ref = "Hello Mark";
    string s_out;
    eval(s_input, s_out, vars);
    ASSERT_STREQ(s_ref.c_str(), s_out.c_str());
}

@ 
@d E_NOERR 0
@d E_EMPTY -1
@d E_COMP -2
@d E_PARSE -3
@<rout...@>+=
int eval_block(string& sinput, string& sout, const var_table_t& vars)
{
    var_table_t::const_iterator it;
    string ssaved = sinput; 
    char s[512];
    char* p;
    char* q;
    sprintf(s, sinput.c_str());
    p= strchr(s, '{');
    if(!p){
        sout+=s;
        sinput.clear();
        return E_NOERR;
    }
    *p++ = 0;
    sout= s;
    q= strchr(p,'}');
    if(!q) return E_PARSE;
    
    {
        *q++ = 0;
        if(strchr(p,'$')==p){
            const string ss = (p+1);
            it= vars.find(ss);
            if(it!=vars.end()){
                sout= sout.c_str()+it->second;
            }
        }
        else { // too complicated
            q -- ;
            *q = '}';
            sinput= p;
            sout+= "{";

            return E_NOERR;
        }
    }
    sinput = q;
    return E_NOERR;
} 

int eval(string& sinput, string& sout, const var_table_t& vars)
{
    var_table_t::const_iterator it;
    if(vars.size()==0)return E_EMPTY;
    string stemp;
    int r;
    sout.clear();
    for(;;) {
        stemp.clear();
        r = eval_block(sinput, stemp, vars);
        if(r !=E_NOERR) break;
        sout+=stemp;
        if(sinput.length() == 0) break;
    }    

    return r;
}

@ Multiple Expression @<tests...@>+=
TEST_F(ex_test, test_of_translate_of_multiple_expressions)
{
    var_table_t vars;
    vars.clear();
    vars.insert(var_table_t::value_type("first_name", "Mark"));  
    vars.insert(var_table_t::value_type("last_name", "Chen"));  
    string s_input = "Hello {$first_name} {$last_name}.";
    string s_ref = "Hello Mark Chen.";
    string s_out;
    int r = eval(s_input, s_out, vars);
    ASSERT_EQ(E_NOERR, r);
    ASSERT_STREQ(s_ref.c_str(), s_out.c_str());
}

@ give error if table is empty
@<tests...@>+=
TEST_F(ex_test, test_empty_table)
{
    var_table_t vars;
    vars.clear();
    string s_input = "Hello {$name}";
    string s_out;
    int r = eval(s_input, s_out, vars);
    ASSERT_EQ(E_EMPTY, r);
}
@ Test with complicated case
@<tests...@>+=
TEST_F(ex_test, test_of_complicated_case)
{
    var_table_t vars;
    vars.clear();
    vars.insert(var_table_t::value_type("name", "Mark"));  
    string s_input = "Hello ${{$name}}.";
    string s_ref = "Hello ${Mark}.";
    string s_out;
    int r =  eval(s_input, s_out, vars);
    ASSERT_EQ(E_NOERR, r);
    ASSERT_STREQ(s_ref.c_str(), s_out.c_str());
}

@ I feel I need to do some more test 
@<tests...@>+=
TEST_F(ex_test, test_when_right_brackets_is_missing_returns_parse_error)
{
    var_table_t vars;
    vars.clear();
    vars.insert(var_table_t::value_type("name", "Mark"));  
    string s_input = "Hello {$name";
    string s_out;
    int r =  eval(s_input, s_out, vars);
    ASSERT_EQ(E_PARSE, r);
}

TEST_F(ex_test, test_with_plain_text)
{
    var_table_t vars;
    vars.clear();
    vars.insert(var_table_t::value_type("name", "Mark"));  
    string s_input = "Hello World!";
    string s_ref = "Hello World!";
    string s_out;
    int r =  eval(s_input, s_out, vars);
    ASSERT_EQ(E_NOERR, r);
    ASSERT_STREQ(s_ref.c_str(), s_out.c_str());
}


@ Index.
