grammar Minijava;
prog	:	MainClass { ClassDeclaration } EOF;
MainClass	:	'class' Identifier '{' 'public' 'static' 'void' 'main' '(' 'String' '[' ']' Identifier ')' '{' Statement '}' '}';
ClassDeclaration	:	'class' Identifier [ 'extends' Identifier ] '{' { VarDeclaration } { MethodDeclaration } '}';
VarDeclaration	:	Type Identifier ';';
MethodDeclaration	:	'public' Type Identifier '(' [ Type Identifier { ',' Type Identifier } ] ')' '{' { VarDeclaration } { Statement } 'return' Expression ';' '}';
Type	:	'int' '[' ']'
|	'boolean'
|	'int'
|	Identifier
;	
Statement	:	'{' { Statement } '}'
|	'if' '(' Expression ')' Statement 'else' Statement
|	'while' '(' Expression ')' Statement
|	'System.out.println' '('  Expression ')' ';'
|	Identifier '=' Expression ';'
|	Identifier '[' Expression ']' '=' Expression ';'
;	
Expression	:	Expression  ( '&&' | '<' | '+' | '-' | '*' )  Expression
|	Expression '[' Expression ']'
|	Expression '.' 'length'
|	Expression '.' Identifier '(' [ Expression { ',' Expression } ] ')'
|	IntegerLiteral
|	'true'
|	'false'
|	Identifier
|	'this'
|	'new' 'int' '[' Expression ']'
|	'new' Identifier '(' ')'
|	'!' Expression
|	'(' Expression ')'
;	
//ExpressionPrime	:	( '&&' | '<' | '+' | '-' | '*' )  Expression
//|'[' Expression ']'
//|'.' 'length'                                                
//|'.' Identifier '(' [ Expression { ',' Expression } ] ')'
//;

//Goal	:	MainClass ( ClassDeclaration )* EOF;
//MainClass	:	'class' Identifier '{' 'public' 'static' 'void' 'main' '(' 'String' '[' ']' Identifier ')' '{' Statement '}' '}';
//ClassDeclaration	:	'class' Identifier ( 'extends' Identifier )? '{' ( VarDeclaration )* ( MethodDeclaration )* '}';
//VarDeclaration	:	Type Identifier ';';
//MethodDeclaration	:	'public' Type Identifier '(' ( Type Identifier ( ',' Type Identifier )* )? ')' '{' ( VarDeclaration )* ( Statement )* 'return' Expression ';' '}';
//Type	:	'int' '[' ']'
//|	'boolean'
//|	'int'
//|	Identifier;
//Statement	:	'{' ( Statement )* '}'
//|	'if' '(' Expression ')' Statement 'else' Statement
//|	'while' '(' Expression ')' Statement
//|	'System.out.println' '(' Expression ')' ';'
//|	Identifier '=' Expression ';'
//|	Identifier '[' Expression ']' '=' Expression ';';
//Expression	:	Expression ( '&&' | '<' | '+' | '-' | '*' ) Expression
//|	Expression '[' Expression ']'
//|	Expression '.' 'length'
//|	Expression '.' Identifier '(' ( Expression ( ',' Expression )* )? ')'
//|	IntegerLiteral
//|	'true'
//|	'false'
//|	Identifier
//|	'this'
//|	'new' 'int' '[' Expression ']'
//|	'new' Identifier '(' ')'
//|	'!' Expression
//|	'(' Expression ')';
Identifier
:	JavaLetter JavaLetterOrDigit*
;

fragment
JavaLetter
:	[a-zA-Z$_] // these are the 'java letters' below 0xFF
//|	// covers all characters above 0xFF which are not a surrogate
//~[\u0000-\u00FF\uD800-\uDBFF]
//{Character.isJavaIdentifierStart(_input.LA(-1))}?
//|	// covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
//[\uD800-\uDBFF] [\uDC00-\uDFFF]
//{Character.isJavaIdentifierStart(Character.toCodePoint((char)_input.LA(-2) (char)_input.LA(-1)))}?
;
//
fragment
JavaLetterOrDigit
:	[a-zA-Z0-9$_] // these are the 'java letters or digits' below 0xFF
//|	// covers all characters above 0xFF which are not a surrogate
//~[\u0000-\u00FF\uD800-\uDBFF]
//{Character.isJavaIdentifierPart(_input.LA(-1))}?
//|	// covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
//[\uD800-\uDBFF] [\uDC00-\uDFFF]
//{Character.isJavaIdentifierPart(Character.toCodePoint((char)_input.LA(-2) (char)_input.LA(-1)))}?
;
IntegerLiteral
:	DecimalIntegerLiteral
//|	HexIntegerLiteral
//|	OctalIntegerLiteral
//|	BinaryIntegerLiteral
;
//
fragment
DecimalIntegerLiteral
:	DecimalNumeral IntegerTypeSuffix?
;
//
//fragment
//HexIntegerLiteral
//:	HexNumeral IntegerTypeSuffix?
//;
//
//fragment
//OctalIntegerLiteral
//:	OctalNumeral IntegerTypeSuffix?
//;
//
//fragment
//BinaryIntegerLiteral
//:	BinaryNumeral IntegerTypeSuffix?
//;
//
fragment
IntegerTypeSuffix
:	[lL]
;

fragment
DecimalNumeral
	:	'0'
	|	NonZeroDigit (Digits? | Underscores Digits)
	;

	fragment
	Digits
	:	Digit (DigitsAndUnderscores? Digit)?
	;

	fragment
	Digit
	:	'0'
	|	NonZeroDigit
	;

	fragment
	NonZeroDigit
	:	[1-9]
	;

	fragment
	DigitsAndUnderscores
	:	DigitOrUnderscore+
	;

	fragment
	DigitOrUnderscore
	:	Digit
	|	'_'
	;

	fragment
	Underscores
	:	'_'+
	;

//	fragment
//	HexNumeral
//	:	'0' [xX] HexDigits
//	;
//
//	fragment
//	HexDigits
//	:	HexDigit (HexDigitsAndUnderscores? HexDigit)?
//	;
//
//	fragment
//	HexDigit
//	:	[0-9a-fA-F]
//	;
//
//	fragment
//	HexDigitsAndUnderscores
//	:	HexDigitOrUnderscore+
//	;
//
//	fragment
//	HexDigitOrUnderscore
//	:	HexDigit
//	|	'_'
//	;
//
//	fragment
//	OctalNumeral
//	:	'0' Underscores? OctalDigits
//	;
//
//	fragment
//	OctalDigits
//	:	OctalDigit (OctalDigitsAndUnderscores? OctalDigit)?
//	;
//
//	fragment
//	OctalDigit
//	:	[0-7]
//	;
//
//	fragment
//	OctalDigitsAndUnderscores
//	:	OctalDigitOrUnderscore+
//	;
//
//	fragment
//	OctalDigitOrUnderscore
//	:	OctalDigit
//	|	'_'
//	;
//
//	fragment
//	BinaryNumeral
//	:	'0' [bB] BinaryDigits
//	;
//
//	fragment
//	BinaryDigits
//	:	BinaryDigit (BinaryDigitsAndUnderscores? BinaryDigit)?
//	;
//
//	fragment
//	BinaryDigit
//	:	[01]
//	;
//
//	fragment
//	BinaryDigitsAndUnderscores
//	:	BinaryDigitOrUnderscore+
//	;
//
//	fragment
//	BinaryDigitOrUnderscore
//	:	BinaryDigit
//	|	'_'
//	;