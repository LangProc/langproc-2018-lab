CPPFLAGS += -W -Wall -g 

# This avoids error: ‘fileno’ was not declared in this scope
CPPFLAGS += -std=c++0x

# Avoid warnings about yyunput not used
CPPFLAGS += -Wno-unused-function

all : histogram

histogram_lexer.yy.cpp : histogram_lexer.flex
	flex -o histogram_lexer.yy.cpp  histogram_lexer.flex

histogram : histogram_lexer.yy.o histogram_main.o
	g++ $(CPPFLAGS) -o histogram  histogram_lexer.yy.o histogram_main.o

clean :
	-rm histogram histogram.exe
	-rm *.yy.cpp
	-rm test/out/*