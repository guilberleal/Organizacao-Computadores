extern printf

section .data
	a dd 5
	b dd 5
	sa dd 0
	sb dd 0
	um dd 1
	cinco dd 5
	
	msg1 db "%d",13,10,0
	msg2 db "%d",13,10,0
	msg3 db "%d",13,10,0
	msg4 db "%d",13,10,0
section .text
	global main
main:
	push rbp
	mov rbp,rsp

	fld dword [um]
	fld dword [a]
	fadd
	fld dword [cinco]
	fadd
	fstp dword [sa]
	
	mov rdi,msg1
	mov rsi,sa
	mov rax,0
	call printf
	
	fld dword [um]
	fld dword [a]
	fadd
	fstp dword [a]

	mov rdi,msg2
	mov rsi,a
	mov rax,0
	call printf
	
	fld dword [b]
	fld dword [cinco]
	fadd 
	fstp dword [sb]

	mov rdi,msg3
	mov rsi,sb
	mov rax,0
	call printf
	
	fld dword [b]
	fld dword [um]
	fadd
	fstp dword [b]

	mov rdi,msg4
	mov rsi,b
	mov rax,0
	call printf

	leave
	mov rax,0
	ret
