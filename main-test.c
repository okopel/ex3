#include <stdio.h>
#include "pstring.h"

int main() {

	Pstring p1;
	Pstring p2;
	char len;
	int opt;

char c[]= "HELLO";
	*(p1.str)=c[0];
	*(p1.str+1)=c[1];
	*(p1.str+2)=c[2];
	*(p1.str+3)=c[3];
	*(p1.str+4)=c[4];
	*(p1.str+5)=0;
	p1.len = 5;


	
	char c2[]= "WORL";
	*(p2.str)=c2[0];
	*(p2.str+1)=c2[1];
	*(p2.str+2)=c2[2];
	*(p2.str+3)=c2[3];
	*(p2.str+4)=0;
		p2.len = 4;

	

	opt=53;
	run_func(opt, &p1, &p2);

	return 0;
}
