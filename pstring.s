.section .data

s: .string "%s, %s, %d, %d\n"

.text

.global pstrlen
.global replaceChar
.global pstrijcpy
.global swapCase
.global pstrijcmp
 


.type 	pstrlen, @function
pstrlen: 							# option 50
	xorq %rsi, %rsi				#init RSI
	movb %al, %sil				#take only LSB from al (RAX) to sil (RSI) 
	xorq %rax, %rax			#inition RAX
	movb %sil, %al				#take RSI to RAX to return value.
	ret
	
.type 	replaceChar, @function
replaceChar:				 		#option 51
											# RDI=pstr. RSI (SIL)=old char. RDX(DL)=new char. 
	movq $1, %r8				# inition R8 -> i=1
.loop:
	movb (%r8, %rdi), %cl	# take the next char from RDI[i] to CL
	cmpb $0, %cl					#check if our char is "\0" (=end of word)
	je .endReplacing			#if yes -> jump to end
	cmpb %cl, %sil				#else -> check if our char is the old char
	je .rep								#if yes -> jump to replace
	jmp .cont						#continiu without replacing
.rep:
	movb %dl, (%r8,%rdi)	#put New char.
.cont:
	addq $1,%r8					# i++
	jmp .loop						#do the loop again
.endReplacing:
	movq %rdi, %rax			#move the and to RAX
	ret

.type 	pstrijcpy, @function
pstrijcpy: 					#option 52
			#pstr1 in RDI, pstr2 in RSI, i in EDX, j in ECX
	addq $1, %rdi						#delete the len from pstr1
	addq $1, %rsi						#delete the len from pstr2
	
	xorq %r8, %r8						#inition r8
.loop2:
	movb (%rdx, %rsi), %r8b		#take the char from rsi[i]
	movb %r8b, (%rdx, %rdi)		#put tha char in rdi[i]
	incq  %rdx							#i++
	cmpl %edx, %ecx					#if i<j
	jge .loop2								#jump to loop
	
	#movq %rcx, %r8
	#movq %rdx, %rcx
	#movq %rsi, %rdx
	#movq %rdi, %rsi
	#movq $s, %rdi
	#xorq %rax, %rax
	#call printf	
	
	movq %rdi, %rax					#preper return
    ret	

swapCase: 							#option 53
	movq $0, %r8					#inition r8 to i=0
.loop3:
	incq %r8							#i++
	movb (%rdi,%r8), %cl		#take pstr[i] to cl (rcx). i=0 is the len.
	cmpb $0, %cl					#check if our char is "\0" (=end of word)
	je .endReplacing2				#if yes -> jump to end
	cmpb $65, %cl					#if 'A'<= our char
	jge .ifbig
	jmp .loop3
.ifbig:
	cmpb $90, %cl					#if 'Z'>our char
	jle .bigCase
	cmp $122, %cl					#if 'z'>out char
	jle .litCase
	jmp .loop3							#our char isnt from the ABC or abc
	
.bigCase:
	addb $32,%cl					#cl+=32 (big to little casting)
	movb %cl, (%rdi,%r8)		# rdi[i]= new cl
	jmp .loop3
	
.litCase:
	subb	$32, %cl 					#cl-=32 (little to big casting)
	movb %cl, (%rdi,%r8)			# rdi[i]= new cl
	jmp .loop3
	
.endReplacing2:
	movq %rdi, %rax				#move the anster to RAX
    ret	

pstrijcmp: 					#option 54
	
    ret	
