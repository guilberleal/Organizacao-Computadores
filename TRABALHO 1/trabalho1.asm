extern printf
extern scanf
extern malloc
extern system
extern getchar



Section .data

	frase1 db 'Digite o numero de linhas da Matriz 1: ' ,0
	frase2 db 'Digite o numero de colunas da Matriz 1: ' ,0
	frase3 db 'Digite o numero de colunas para Matriz 2: ' ,0
	frase4 db 'O numero de linhas da Matriz 2 sera o numero de colunas da Matriz 1: N = %d' ,13,10,0
	frase5 db 'A terceira Matriz sera nxm[%d][%d]' ,13,10,0
	frase6 db 'Preenchendo a Matriz 1 nxp[%d][%d]' ,13,10,0
	frase7 db 'Preenchendo a Matriz 2 pxm[%d][%d]' ,13,10,0
	frase8 db 'A Matriz 1 eh' ,13,10,0
	frase9 db 'A Matriz 2 eh' ,13,10,0
	frase10 db 'O resultado do produto da Matriz 1 com a Matriz 2 eh' ,13,10,0
	formato1 db 'clear',0
	formato2 db '' ,13,10,0
	formato3 db '%d' ,0
	formato4 db '[%d]',0
	fmt2:    db "O elemento da linha %d e coluna %d eh:",13,10, 0 ; String de formato  "\n",'0'
	m dq 0
	p dq 0
	n dq 0
	i dq 0
	j dq 0
	a dq 0
	aux dq 0
	size dq 8
	;np equ 1

segment .bss ; reserva o ponteiro armazenando 16 numeros
	np resd 16 
	pm resd 16
	nm resd 16

Section .text
	global main
main:
	push rbp
	mov rbp,rsp

	mov rdi,formato1 ;dando clear na tela
	call system

	mov rdi,frase1 ;printa a primeira frase
	call printf

	mov rdi,formato3 ; scanf passando pra n
	mov rsi,n
	call scanf

	mov rdi,frase2 ;printa frase 2;
	call printf

	mov rdi,formato3 ;scanf passando pra p
	mov rsi,p
	call scanf

	mov rdi,frase3 ; printf frase3
	call printf

	mov rdi,formato3 ;scanf passando pra m
	mov rsi,m
	call scanf

	mov rdi,frase4 ;printa frase 4
	mov rsi,[p]
	call printf

	mov rdi,frase5 ;printa frase 5
	mov rsi,[n]
	mov rdx,[m]
	call printf

	call getchar 
	call getchar

	mov rdi,formato1 ;clear na tela
	call system

	
        mov  eax,[n]   ;aqui faz o malloc do i do np
        mov  ebx,[size]
        mul  ebx
        mov  [i],eax
	mov rdi,[i]
	call malloc

	mov [np],rax ;conteudo do malloc passa pro np 
	mov rax,0
	mov [i],rax ;zera o conteudo de i

	mov rdi,frase6 ;printa a frase 6
	mov rsi,[n]
	mov rdx,[p]
	call printf
	
	mov rax,0   ;zera i
	mov [i],rax

for_loop1: 		;primeiro loop
        mov   rax, [i]  
	mov rbx,[n]
        cmp   rax, rbx       ;compara rbx com rax
        jge   fim_for_loop1    ;se for mair ou igual vai para o fim do loop 

        mov     eax,4           ;multiplica ebx com eax e coloca o resultado em a
        mov     ebx, dword[i]
        mul     ebx      
	mov [a],eax

	mov  eax,[p]            ;malloc do j
        mov  ebx,[size]
        mul  ebx
	mov [j],eax
	mov rdi,[j]
        call malloc 

        mov rsi,np        ; segundo parametro para scanf (a eh um endereço)
	mov rbx,[a]
        add rsi,rbx      ; a + 4*i  = &a[i]
	
	mov [rsi],rax 
        
        mov     eax, dword[i]     ; i++
        inc     eax
        mov    dword[i], eax
        jmp    for_loop1

fim_for_loop1:            ;fim do loop 1

	xor  rax,rax         ; zera rax
	mov [i],rax       ; zera i
	mov [j],rax        ;zera j

	mov eax,[p]        ;malloc i do pm
        mov ebx,[size]
        mul ebx
        mov [i],eax
	mov rdi,[i]
	call malloc

	mov [pm],rax 
	mov rax,0
	mov [i],rax

	mov rax,0 
	mov [i],rax        ;zera o i
	mov [j],rax        ;zera o j

while: 
        mov rax, [i]
	mov rbx,[p]
        cmp rax, rbx       
        jge fim_while            ;salta se for maior ou igual

        mov eax,4
        mov ebx, dword[i]
        mul ebx              ;edx:eax <-- eax*ebx
	mov [a],eax

	mov eax,[m]             ;malloc do j pm
        mov ebx,[size]
        mul ebx
	mov [j],eax
	mov rdi,[j]
        call malloc 

        mov rsi,pm        ; segundo parametro para scanf (a eh um endereço)
        xor rbp,rbp   
	mov rbx,[a]
        add rsi,rbx            ; a + 4*i  = &a[i]
	mov [rsi],rax
        
        mov eax, dword[i]       ;i++
        inc eax
        mov dword[i], eax

        jmp while       ;pula pro while dnv

fim_while:

	mov rax,0           ;zera rax
	mov [i],rax            ;zera i
	mov [j],rax          ;zera j

for_loop_3:        
       mov ecx,  [i]
       cmp ecx, [n]           ; compara n com i 
       jae fim_for_loop_3        ;salta se for maior ou igual

       xor eax,eax        ;zera eax
       mov [j],eax       ;zera j

for_loop_4: 
       mov ecx, [j]
       cmp ecx, [p]         ;compara p com j 
       jae  fim_for_loop_4     ;salta se for maior ou igual
       
       xor rsi,rsi       ; zera o rsi
       xor rdx,rdx      ; zera o rdx
       
       mov rdi, fmt2      ;printa fmt2
       mov esi, [i]
       mov edx, [j]
       mov rax,0
       call printf
       
        xor rax,rax         ; calculo do endereço efetivo
        mov ecx, [j]
        mov edx, [i]
        mov eax, [p]
        mul edx         ;  eax <- eax * edx  eax <-i * COL
        add eax,ecx             ;  eax <- eax+ecx  eax <- i * COL + j
        mov ebx, np
        lea eax, [ebx + 4*eax]       ;  eax <- a + 4* (i*COL+j)
       
       
      
        mov rdi, formato3      ;scanf formato 3
        mov rsi, rax
        mov rax,0
        call scanf
  
        mov eax, [j]       ;i ++
        inc eax
        mov [j], eax

        jmp for_loop_4
        
fim_for_loop_4:   
       
        mov eax, [i]        ;i ++
        inc eax
        mov [i], eax
       
       jmp  for_loop_3
       
fim_for_loop_3: 

	mov rax,0           ;zera rax,i e j
	mov [i],rax
	mov [j],rax

	

for_loop_5:        
       mov ecx,  [i]
       cmp ecx, [n]           ; i < LIN ?
       jae fim_for_loop_5

       xor eax,eax
       mov [j],eax ;

for_loop_6: 
       mov ecx, [j] 
       cmp ecx, [p]   ;compara p com j 
       jae  fim_for_loop_6 ; salta se for maior ou igual
       
       xor  rsi,rsi       ; zera o rsi
       xor rdx,rdx       ; zera o rdx
       
       mov  rdi, fmt2    ;printa fmt2
       mov  esi, [i]
       mov  edx, [j]
       mov  rax,0
       call printf
       
        xor rax,rax         ; calculo do endereço efetivo
        mov ecx, [j]
        mov edx, [i]
        mov eax, [p]
        mul edx          ;    eax <- eax*edx  eax <-i*COL
        add eax,ecx             ;  eax <- eax+ecx  eax <- i*COL +j
        mov ebx, np
        lea eax, [ebx + 4*eax]      ;  eax <- a + 4*(i*COL+j)
       
       
      
        mov rdi,frase4   ;printa frase 4
        mov rsi,[rax]
        mov rax,0
        call printf
      
    
        
        
        mov eax, [j]     ; i++
        inc eax
        mov [j], eax


        jmp for_loop_6 
        
fim_for_loop_6:   
       
        mov eax, [i]       ;  i++
        inc eax
        mov [i], eax
       
       jmp for_loop_5
       
fim_for_loop_5:
	

	mov rdi,frase7   ;printa a frase 7
	mov rsi,[p]
	mov rdx,[m]
	call printf

	mov rax,0     ;zera rax,i e j
	mov [i],rax
	mov [j],rax

for_loop_7:        
       mov ecx,  [i]
       cmp ecx, [p]         ; compara p com i, se i for menor que linha  
       jae fim_for_loop_7   ; salta se for maior ou igual

       xor eax,eax
       mov [j],eax          ;zera eax e j

for_loop_8: 
       mov ecx, [j]
       cmp ecx, [m]
       jae fim_for_loop_8
       
       xor rsi,rsi         ; zera o rsi
       xor rdx,rdx         ; zera o rdx
       
       mov rdi, fmt2        ;printa fmt2
       mov esi, [i]
       mov edx, [j]
       mov rax,0
       call printf
       
        xor rax,rax         ; calculo do endereço efetivo
        mov ecx, [j]
        mov edx, [i]
        mov eax, [m]
        mul edx            ;eax <- eax*edx  eax <-i*COL
        add eax,ecx         ;eax <- eax+ecx  eax <- i*COL +j
        mov ebx, pm
        lea eax, [ebx + 4*eax]    ; eax <- a + 4*(i*COL+j)
       
       
      
        mov rdi, formato3     ;printa formato 3
        mov rsi, rax
        mov rax,0
        call scanf
      
    
        
        
        mov eax, [j]     ; i++
        inc eax
        mov [j], eax


        jmp for_loop_8
        
fim_for_loop_8:   
       
        mov eax, [i]      ;i++
        inc eax
        mov [i], eax
       
       jmp for_loop_7
       
fim_for_loop_7:  

	mov rax,0
	mov [i],rax
	mov [j],rax

	mov rdi,formato1
	call system

	mov rdi,formato2
	call printf
	mov rdi,frase8
	call printf

for_loop_9:        
       mov ecx,  [i]
       cmp ecx, [n] ; i < LIN ?
       jae fim_for_loop_9

       xor eax,eax
       mov [j],eax ;

for_loop_10: 
       mov ecx, [j]
       cmp ecx, [p]
       jae  fim_for_loop_10
       
       xor  rsi,rsi; zera o rsi
       xor rdx,rdx; zera o rdx
       
        xor rax,rax         ; calculo do endereço efetivo
        mov ecx, [j]
        mov edx, [i]
        mov eax, [p]
        mul edx ;    eax <- eax*edx  eax <-i*COL
        add eax,ecx  ;  eax <- eax+ecx  eax <- i*COL +j
        mov ebx, np
        lea eax, [ebx + 4*eax]  ;  eax <- a + 4*(i*COL+j)
       
       
      
        mov   rdi,formato4
        mov   rsi,[rax]
        mov rax,0
        call  printf
      
    
        
        
        mov eax, [j]
        inc eax
        mov [j], eax
        jmp for_loop_10
        
fim_for_loop_10:   
       
        mov eax, [i]
        inc eax
        mov [i], eax
       mov rdi,formato2
	call printf
       jmp  for_loop_9
       
fim_for_loop_9:

	mov rax,0
	mov [i],rax
	mov [j],rax
	
	mov rdi,formato2
	call printf
	mov rdi,frase9
	call printf

for_loop_11:        
       mov ecx,  [i]
       cmp ecx, [p] ; i < LIN ?
       jae fim_for_loop_11

       xor eax,eax
       mov [j],eax ;

for_loop_12: 
       mov ecx, [j]
       cmp ecx, [m]
       jae  fim_for_loop_12
       
       xor  rsi,rsi; zera o rsi
       xor rdx,rdx; zera o rdx
       
        xor rax,rax         ; calculo do endereço efetivo
        mov ecx, [j]
        mov edx, [i]
        mov eax, [m]
        mul edx ;    eax <- eax*edx  eax <-i*COL
        add eax,ecx  ;  eax <- eax+ecx  eax <- i*COL +j
        mov ebx, pm
        lea eax, [ebx + 4*eax]  ;  eax <- a + 4*(i*COL+j)
       
       
      
        mov   rdi,formato4
        mov   rsi,[rax]
        mov rax,0
        call  printf
      
    
        
        
        mov eax, [j]
        inc eax
        mov [j], eax
        jmp for_loop_12
        
fim_for_loop_12:   
       
        mov eax, [i]
        inc eax
        mov [i], eax
	mov rdi,formato2
	call printf
       
       jmp  for_loop_11
       
fim_for_loop_11:

	call getchar
	call getchar

	mov  eax,[n]
        mov  ebx,[size]
        mul  ebx
        mov  [i],eax
	mov rdi,[i]
	call malloc

	mov [nm],rax
	mov rax,0
	mov [i],rax
	
	mov rax,0
	mov [i],rax

for_loop13: 
        mov   rax, [i]
	mov rbx,[n]
        cmp   rax, rbx       
        jge   fim_for_loop13

        mov     eax,4
        mov     ebx, dword[i]
        mul     ebx      ;edx:eax <-- eax*ebx
	mov [a],eax

	mov  eax,[m]
        mov  ebx,[size]
        mul  ebx
	mov [j],eax
	mov rdi,[j]
        call malloc 

        mov rsi,nm       ; segundo parametro para scanf (a eh um endereço)
        ;xor rbp,rbp
	mov rbx,[a]
        add rsi,rbx      ; a + 4*i  = &a[i]
	
	mov [rsi],rax
        
        mov     eax, dword[i]
        inc     eax
        mov    dword[i], eax
        jmp    for_loop13

fim_for_loop13:

	mov rax,0
	mov [i],rax
	mov [j],rax
	mov [aux],rax

while1:
	mov   rax, [i]
	mov rbx,[n]
        cmp   rax, rbx       
        jge   fim_while1
	
while2:
	mov   rax, [j]
	mov rbx,[m]
        cmp   rax, rbx       
        jge   fim_while2

	xor  rsi,rsi; zera o rsi
       	xor rdx,rdx; zera o rdx
       
        xor rax,rax         ; calculo do endereço efetivo
        mov ecx, [j]
        mov edx, [i]
        mov eax, [m]
        mul edx ;    eax <- eax*edx  eax <-i*COL
        add eax,ecx  ;  eax <- eax+ecx  eax <- i*COL +j
        mov ebx, nm
        lea eax, [ebx + 4*eax]  ;  eax <- a + 4*(i*COL+j) 
      
        mov   rdi,0
        mov   [rax], rdi

while3:
	mov rax, [aux]
	mov rbx,[p]
        cmp rax, rbx       
        jge fim_while3	

	xor  rsi,rsi; zera o rsi
       	xor rdx,rdx; zera o rdx
       
        xor rax,rax         ; calculo do endereço efetivo
        mov ecx, [aux]
        mov edx, [i]
        mov eax, [p]
        mul edx ;    eax <- eax*edx  eax <-i*COL
        add eax,ecx  ;  eax <- eax+ecx  eax <- i*COL +j
        mov ebx, np
        lea eax, [ebx + 4*eax]  ;  eax <- a + 4*(i*COL+j)

	mov rax,[rax]
	mov [a],rax

	;---
	;mov rdi,frase4
	;mov rsi,[a]
	;call printf
	

	xor  rsi,rsi; zera o rsi
       	xor rdx,rdx; zera o rdx
       
        xor rax,rax         ; calculo do endereço efetivo
        mov ecx, [j]
        mov edx, [aux]
        mov eax, [m]
        mul edx ;    eax <- eax*edx  eax <-i*COL
        add eax,ecx  ;  eax <- eax+ecx  eax <- i*COL +j
        mov ebx, pm
        lea eax, [ebx + 4*eax]  ;  eax <- a + 4*(i*COL+j)

	;mov eax,[rcx]
	;mov rdi,rdx
	;mov [a],rcx
	mov rax,[rax]
	mov [size],rax
	mov edx,[size]
	mov eax,[a]
	mul edx
	
	mov [a],eax
	
	;-----
	;mov rdi,frase4
	;mov rsi,[a]
	;call printf

	;mov rcx,rax
	;mov rax,[rax]
	;mov [a],rax

	xor  rsi,rsi; zera o rsi
       	xor rdx,rdx; zera o rdx
       
        xor rax,rax         ; calculo do endereço efetivo
        mov ecx, [j]
        mov edx, [i]
        mov eax, [m]
        mul edx ;    eax <- eax*edx  eax <-i*COL
        add eax,ecx  ;  eax <- eax+ecx  eax <- i*COL +j
        mov ebx, nm
        lea eax, [ebx + 4*eax]  ;  eax <- a + 4*(i*COL+j)

	;mov [rax],rcx
	;mov eax,[a]
	mov rax,[rax]
	mov [size],rax
	;mov ecx,[size]
	;add eax,ecx
	;mov [a],eax
	;--mov rax,[a]
	fld qword [a]
	fld qword [size]
	fadd
	fstp qword [a]
	;--mov rdi,frase4
	;--mov rsi,[a]
	;--call printf
	;mov rdx,[a]
	;mov [rax],rdx

	xor  rsi,rsi; zera o rsi
       	xor rdx,rdx; zera o rdx
       
        xor rax,rax         ; calculo do endereço efetivo
        mov ecx, [j]
        mov edx, [i]
        mov eax, [m]
        mul edx ;    eax <- eax*edx  eax <-i*COL
        add eax,ecx  ;  eax <- eax+ecx  eax <- i*COL +j
        mov ebx, nm
        lea eax, [ebx + 4*eax]  ;  eax <- a + 4*(i*COL+j)
	;mov rax,[rax]
	mov rdx,[a]
	;xor rdx,rdx
	mov [rax],rdx


	mov     eax, dword[aux]
        inc     eax
        mov    dword[aux], eax
        jmp    while3

fim_while3:
	mov rax,0
	mov [aux],rax
	
	mov     eax, dword[j]
        inc     eax
        mov    dword[j], eax
        jmp    while2
	
fim_while2:
	mov rax,0
	mov [j],rax
	
	mov     eax, dword[i]
        inc     eax
        mov    dword[i], eax
        jmp    while1

fim_while1:

	mov rax,0
	mov [i],rax
	mov [j],rax

	mov rdi,frase10
	call printf

for_loop_14:        
       mov ecx,  [i]
       cmp ecx, [n] ; i < LIN ?
       jae fim_for_loop_14

       xor eax,eax
       mov [j],eax ;

for_loop_15: 
       mov ecx, [j]
       cmp ecx, [m]
       jae  fim_for_loop_15
       
       xor  rsi,rsi; zera o rsi
       xor rdx,rdx; zera o rdx
       
       ;mov  rdi, fmt2
       ;mov  esi, [i]
       ;mov  edx, [j]
       ;mov  rax,0
       ;call printf
       
        xor rax,rax         ; calculo do endereço efetivo
        mov ecx, [j]
        mov edx, [i]
        mov eax, [m]
        mul edx ;    eax <- eax*edx  eax <-i*COL
        add eax,ecx  ;  eax <- eax+ecx  eax <- i*COL +j
        mov ebx, nm
        lea eax, [ebx + 4*eax]  ;  eax <- a + 4*(i*COL+j)
       
       
      
        mov   rdi,formato4
        mov   rsi,[rax]
        mov rax,0
        call  printf
      
    
        
        
        mov eax, [j]
        inc eax
        mov [j], eax
        jmp for_loop_15
        
fim_for_loop_15:   
       
        mov eax, [i]
        inc eax
        mov [i], eax
       mov rdi,formato2
	call printf
       jmp  for_loop_14
       
fim_for_loop_14:


	pop	rbp
	
	mov rax,0
	ret
