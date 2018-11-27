#include <stdio.h>
#include "pstring.h"

int main() {

	Pstring p1;
	Pstring p2;
	int len;
	int opt;

	// initialize first pstring
	//printf("%s","enter len1");
	//scanf("%d", &len);
	len=5;
	//printf("%s","enter num1");
	scanf("%s", p1.str);
	//char* s1="kopel";
	//p1.str=s1;
	

	p1.len = len;

	// initialize second pstring
	//printf("%s","enter len2");
	//scanf("%d", &len);
	//printf("%s","enter num2");
	//scanf("%s", p2.str);
	len=3;
	//char* s2="ori";
	//p2.str=s2;
	scanf("%s\n", p2.str);
	p2.len = len;

	// select which function to run
	//printf("%s","select oper");
	//scanf("%d", &opt);
	opt=53;
	printf("len 1:%d, s1:%s, \t len2: %d, s2: %s,\t opt: %d\n",p1.len, p1.str,p2.len,p2.str,opt);
	run_func(opt, &p1, &p2);
	printf("run has done\n");
	return 0;
}
