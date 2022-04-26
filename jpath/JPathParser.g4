/**
 * json path engine Parser
 *
 * Copyright (c) 2020-2021 Gael beard <gaelgael5@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

parser grammar JPathParser;

options { 
      // memoize=True;
      tokenVocab=JPathLexer;
    }

jsonpath
   : ROOT_VALUE jsonpath_subscript? EOF
   ;

jsonpath_
   : ( ROOT_VALUE | CURRENT_VALUE ) jsonpath_subscript?
   ;

jsonpath__
   : jsonpath_
   | value
   ;

jsonpath_subscript
   : RECURSIVE_DESCENT ( subscriptableBareword | subscriptables ) jsonpath_subscript?
   | SUBSCRIPT subscriptableBareword jsonpath_subscript?
   | subscriptables jsonpath_subscript?
   ;

subscriptables
   : BRACKET_LEFT subscriptable ( COMMA subscriptable )* BRACKET_RIGHT
   ;

subscriptableArguments
   : PAREN_LEFT ( jsonpath__ ( COMMA jsonpath__ )* )? PAREN_RIGHT
   ;

subscriptableBareword
   : jsonPath_identifier subscriptableArguments?
   | WILDCARD_SUBSCRIPT
   ;

jsonPath_identifier
   : ID
   | IN
   | NIN
   | SUBSETOF
   | CONTAINS
   | SIZE
   | EMPTY
   | TRUE
   | FALSE
   ;

subscriptable
   : STRING
   | sliceable
   | WILDCARD_SUBSCRIPT
   | QUESTION PAREN_LEFT expression PAREN_RIGHT
   | jsonpath_
   | IDQUOTED subscriptableArguments?
   ;

sliceable
   : NUMBER
   | sliceableLeft
   | sliceableRight
   | sliceableBinary
   ;

sliceableLeft
   : NUMBER COLON
   ;

sliceableRight
   : COLON NUMBER
   ;

sliceableBinary
   : NUMBER COLON NUMBER
   ;

expression
   : jsonpath__
   | NOT expression
   | PAREN_LEFT expression PAREN_RIGHT   
   | expression (binaryOperator expression)+
   ;

binaryOperator
   : AND 
   | OR 
   | EQ 
   | NE 
   | LT 
   | LE 
   | GT 
   | GE  
   | IN
   | NIN
   | SUBSETOF
   | CONTAINS
   | SIZE
   | EMPTY  
   ;



/* c.f., https://github.com/antlr/grammars-v4/blob/master/json/JSON.g4 */

json
   : value
   ;

obj
   : BRACE_LEFT (pair (COMMA pair)*)? BRACE_RIGHT   
   ;

pair
   : STRING COLON value
   ;

array
   : BRACKET_LEFT (value ( COMMA value )*)? BRACKET_RIGHT
   ;

value
   : STRING
   | IDQUOTED
   | NUMBER  
   | TRUE
   | FALSE
   | NULL
   | obj
   | array
   ;

