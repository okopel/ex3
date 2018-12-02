#ori kopel 205533151
.section .data
.text

.global pstrlen
.global replaceChar
.global pstrijcpy
.global swapCase
.global pstrijcmp
 
###################################################################
.type 	pstrlen, @function
pstrlen: 						# option 50
	xorq		 %rsi, %rsi	#init RSI
	movb	%al, %sil		#take only LSB from al (RAX) to sil (RSI) 
	xorq 		%rax, %rax	#inition RAX
	movb	%sil, %al		#take RSI to RAX to return value.
	ret
#################################################################
.type 	replaceChar, @function
replaceChar:				#option 51
								# RDI=pstr. RSI (SIL)=old char. RDX(DL)=new char. 
	movq 	$1, %r8	# inition R8 -> i=1
.loop:
	movb 	(%r8, %rdi), %cl	# take the next char from RDI[i] to CL
	cmpb 	$0, %cl					#check if our char is "\0" (=end of word)
	je 		.endReplacing		#if yes -> jump to end
	cmpb 	%cl, %sil				#else -> check if our char is the old char
	je 		.rep						#if yes -> jump to replace
	jmp 		.cont						#continiu without replacing
.rep:
	movb 	%dl, (%r8,%rdi)	#put New char.
.cont:
	addq 	$1,%r8					# i++
	jmp 		.loop						#do the loop again
.endReplacing:
	movq 	%rdi, %rax			#move the and to RAX
	ret
#####################################################################
.type 	pstrijcpy, @function
pstrijcpy: 					#option 52
								#pstr1 in RDI, pstr2 in RSI, i in EDX, j in ECX
	addq 	$1, %rdi	#delete the len from pstr1
	addq 	$1, %rsi	#delete the len from pstr2
	xorq 		%r8, %r8	#inition r8
.loop2:
	movb	 (%rdx, %rsi), %r8b		#take the char from rsi[i]
	movb	 %r8b, (%rdx, %rdi)		#put tha char in rdi[i]
	incq 		 %rdx							#i++
	cmpl 	%edx, %ecx					#if i<j
	jge 		.loop2							#jump to loop
	movq 	%rdi, %rax					#preper return
    ret	
######################################################################
.type 	swapCase, @function
swapCase: 					#option 53
									#pstr in RDI
	xorq 		%r8, %r8
	movq 	$0, %r8		#inition r8 to i=0
.loopb:	
	addq	 	$1,%r8					#i++
	movb 	(%r8,%rdi), %cl	#take pstr[i] to cl (rcx). i=0 is the len.
	cmpb 	$0, %cl					#check if our char is "\0" (=end of word)
	je 		.endReplacingb		#if yes -> jump to end
	cmpb 	$65, %cl				#if 'A'<= our char
	jge 		.ifbig
	jmp 		.loopb
.ifbig:
	cmpb 	$90, %cl			#if 'Z'>our char
	jle 		.bigCase
	cmp 	$122, %cl			#if 'z'>out char
	jle 		.litCase
	jmp 		.loopb				#our char isnt character in english
.bigCase:
	addq 	$32,	(%r8,%rdi)	#rdi[i]+=32 (big to little casting)
	jmp 		.loopb
.litCase:
	subq		$32, (%r8,%rdi)	#rdi[i]-=32 (little to big casting)
	jmp 		.loopb
.endReplacingb:
	xorq 		%rax, %rax
	movq 	%rdi, %rax			#move the anster to RAX
    ret	
###########################################################################
pstrijcmp: 					#option 54
	#pstr1 in RDI, pstr2 in RSI, i in EDX, j in ECX
	addq 	$1, %rdi		#delete the len from pstr1
	addq 	$1, %rsi		#delete the len from pstr2
	xorq		%rax, %rax	#init rax
	xorq		%rbx, %rbx	#init rbx
.loope:
	movb 	(%rdx,%rdi),%al	#take pstr1[i] to al (rax)
	movb 	(%rdx,%rsi),%bl	#take pstr2[i] to bl (rbx)
	addl 		$1, %edx				#i++
	cmpb	%al, %bl				#if al=bl
	je 		.equ
	cmpb 	%al, %bl				#if al<bl
	jg 		.pstr2big				#pstr2 bigger
	movq	 $1, %rax				#return 1
	jmp 		.ende
.pstr2big:
	movq 	$-1, %rax				#return -1
	jmp 		.ende
.equ:
	cmpl 	%edx, %ecx			#if i<j
	jg 		.loope
	movq 	$0, %rax				#return 0
.ende:
	ret
##############################################################################
