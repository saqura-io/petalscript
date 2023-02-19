parser grammar PetalScript;
options { tokenVocab=PetalScriptLexer; }

program
    :   statement+
    ;

statement
    :   (let_statement | output_statement) SEMICOLON
    ;

let_statement
    :   DECLARATOR identifier EQUALS function_call
    ;

output_statement
    :   OUTPUT LPAREN AS COLON STRING COMMA identifier RPAREN
    ;

function_call
    :   filter_call 
    |   search_call 
    |   sort_call 
    |   count_call 
    |   sum_call 
    |   aggregate
    ;

filter_call
    :   FILTER LPAREN FROM COLON STRING COMMA BY COLON STRING COMMA EQUALSEXPR COLON STRING RPAREN
    ;

search_call
    :   SEARCH LPAREN IN COLON (STRING | identifier) COMMA FOR COLON STRING (COMMA CASE COLON BOOL)? (COMMA EXACT COLON BOOL)? RPAREN
    ;

sort_call
    :   SORT LPAREN FROM COLON (STRING | identifier) COMMA BY COLON STRING COMMA ORDER COLON STRING { $STRING.text == "ASC" || $STRING.text == "DESC" } RPAREN
    ;

count_call
    :   COUNT LPAREN FROM COLON (STRING | identifier) COMMA BY COLON STRING RPAREN
    ;

sum_call
    :   SUM LPAREN FROM COLON (STRING | identifier) COMMA BY COLON STRING RPAREN
    ;

aggregate
    : LBRACKET identifier (COMMA identifier)* RBRACKET
    ;

identifier
    :   ID
    ;