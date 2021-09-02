extern printf
extern scanf

section .data
    n dd 0
 
    
	i dd 0
    flag dd 0
    str0: db "enter a positive integer: ",0
    str1: db "%d",0
    str2: db "%d is a prime number.",0
    str3: db "%d is not a prime number.",0

global main
    main:
        push rbp
        mov rbp,rsp
        
        mov rdi,str0
        mov rax,0
        call printf
        
        mov rdi,str1
        mov rsi,n
        mov rax,0
        call scanf
        
        mov edx,2
        mov [i],edx; i=2
        
        
        loop_for_1: 
					mov eax,[n]
                    shr eax,1       ;eax = n/2
                    mov edx,[i]
                    cmp edx,eax
                    ja fim_for_1
                    mov edx,0
                    mov edx,2
                    mov [i],edx
                    mov eax,[n]
                    mov ecx,[i]
                    div ecx
                    cmp edx,0
                    jne fim_if_1
                    mov eax,1
                    mov eax,1
                    mov [flag],eax  ;flag = 1
                    jmp fim_for_1
                fim_if_1:
                    jmp loop_for_1
                fim_for_1:
                    mov eax,[flag]
                    cmp eax,0
                    jnz parte_else_if_2
                    mov rdi,str2
                    mov rsi,[n]
                    mov rax,0
                    call printf
                    jmp fim_if_2
                parte_else_if_2:
                    mov rdi,str3
                    mov rax,0
                    call printf
                
                fim_if_2:
                    leave
                    mov rax,0
                    ret
                    
                    
                    

