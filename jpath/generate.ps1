# antlr-4.7-complete.jar must be preset 
# http://www.antlr.org/download/antlr-4.7-complete.jar

java.exe -jar antlr-4.7-complete.jar -Dlanguage=CSharp JPathLexer.g4 -visitor -no-listener -package Bb.JPath.Parsers
java.exe -jar antlr-4.7-complete.jar -Dlanguage=CSharp JPathParser.g4 -visitor -no-listener -package Bb.JPath.Parsers