lexer grammar PetalScriptLexer;

DECLARATOR
    :   'let'
    ;

FROM
    :   'from'
    ;

EQUALSEXPR
    :   'equals'
    ;

BY
    :   'by'
    ;

AS
    :   'as'
    ;

IN
    :   'in'
    ;

FOR
    :   'for'
    ;

FILTER
    :   'filter'
    ;

SEARCH
    :   'search'
    ;

SORT
    :   'sort'
    ;

COUNT
    :   'count'
    ;

SUM
    :   'sum'
    ;

ORDER
    :   'order'
    ;

OUTPUT
    :   'output'
    ;

CASE
    :   'caseInsensitive'
    ;

EXACT
    :   'exactMatch'
    ;

EQUALS
    :   '='
    ;

LPAREN
    :   '('
    ;

RPAREN
    :   ')'
    ;

LBRACKET
    :   '['
    ;

RBRACKET
    :   ']'
    ;

SEMICOLON
    :   ';'
    ;

COLON
    :   ':'
    ;

COMMA
    :   ','
    ;

BOOL
    :   TRUE 
    |   FALSE
    ;

TRUE:   'true';
FALSE:  'false';

ID
    :   [a-zA-Z_][a-zA-Z0-9_]*
    ;

STRING
    :   '"' ~["\r\n]* '"'
    ;

WS
    :   [ \t\r\n]+ 
        -> skip
    ;

COMMENT
    :   '#' ~[\r\n]* 
        -> skip
    ;