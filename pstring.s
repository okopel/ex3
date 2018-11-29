.section .data

c1: .int 'a'
d1: .int 'b'

.text

.global pstrlen
.global replaceChar
.global pstrijcpy
.global swapCase
.global pstrijcmp
 


.type 	pstrlen, @function
pstrlen: 								# option 50
											
	xorq %rsi, %rsi				#init RSI
	movb %al, %sil				#take only LSB to RSI 
	xorq %rax, %rax				#inition RAX
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
	
    ret	

swapCase: 				#option 53
	
    ret	

pstrijcmp: 					#option 54
	
    ret	
