#include <stdio.h>
#include "pstring.h"

int main() {

	Pstring p1;
	Pstring p2;
	char len;
	int opt;



	// initialize second pstring
	//len='3';
	//scanf("%s", p2.str);
	char c2[]= "Aviel";
	*(p2.str)=c2[0];
	*(p2.str+1)=c2[1];
	*(p2.str+2)=c2[2];
	*(p2.str+3)=c2[3];
	*(p2.str+4)=c2[4];
	*(p2.str+5)=0;

	//*(p2.str)='A';
	//*(p2.str+1)='v';
	//*(p2.str+2)='i';
	//*(p2.str+3)=0;
	
	p2.len = 5;
	
	
	
	// initialize first pstring
	//len=5;
	//scanf("%s", p1.str);

	char c[]= "mosh";
	*(p1.str)=c[0];
	*(p1.str+1)=c[1];
	*(p1.str+2)=c[2];
	*(p1.str+3)=c[3];
	*(p1.str+4)=0;
	//*(p1.str+5)=0;

	p1.len = 4;



	// select which function to run
	opt=52;
	run_func(opt, &p1, &p2);

	return 0;
}
