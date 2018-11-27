.section .data



.text

.global pstrlen
.global replaceChar
.global pstrijcpy
.global swapCase
.global pstrijcmp

   



pstrlen: 						# option 50
	
	xorq %rsi, %rsi		#init RSI
	movb %al, %sil		#take only LSB to RSI 
	xorq %rax,%rax		#inition RAX
	movb %sil, %al		#take RSI to RAX to return value.
	ret
	
replaceChar:				 #option 51
	

	ret
pstrijcpy: 					#option 52
	
    ret	

swapCase: 				#option 53
	
    ret	

pstrijcmp: 					#option 54
	
    ret	
