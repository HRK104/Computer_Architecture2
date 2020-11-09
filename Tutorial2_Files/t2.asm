includelib legacy_stdio_definitions.lib
extrn printf:near
extrn scanf:near




;; Data segment
.data
public inp_int; export variable g
inp_int QWORD 4; declare global variable g initialised to 4
	print_string BYTE "Sum of i: %I64d and j: %lld is: %I64d", 0Ah, 00h
	print_string2 BYTE "Sum of i: %I64d, j: %lld and bias: %lld is: %I64d", 0Ah, 00h

	stringqns db "Please entern an integer",0AH,00H
	print_string_for_scanf db "input number",00H
	sum_string BYTE "The sum of proc. and user inputs (%lld, %lld, %lld, %lld): %lld", 0Ah,00h
	bias QWORD 50
	sum2 QWORD 0


;; Code segment
.code


;; address of the array: RDX
;; size of the array: RCX
public array_proc

array_proc:
			;; RAX is the accumulator
			xor rax, rax

			;; the main loop
L1:			add rax, [rdx] ;; access and add contents
			add rdx, TYPE QWORD	;; TYPE operator returns the number of bytes used by the identified QWORD
			loop L1 ;; RCX as the loop counter

			;; returning from the function/procedure
			ret

;; i in RCX (arg1)
;; j in RDX (arg2)
;; print_proc: adds the two arguments and prints it through printf
public print_proc

print_proc:
			lea rax, [rcx+rdx]		;; a way to add two regs and place it in rax
			mov [rsp+24], rax		;; preserving rax in shadow space
			mov [rsp+16], rcx		;; preserving i
			mov [rsp+8], rdx		;; preserving j

			;; Calling our printf function
			sub rsp, 40				;; the shadow space
			mov r9, rax				;; 4th argument
			mov r8, rdx				;; 3rd argument: j
			mov rdx, rcx			;; 2nd argument: i
			lea rcx, print_string	;; 1st argument: string
			call printf				;; call the function

			;; 2nd call to printf
			;; RSP has changed, so the displacements have also changed
			mov rax, [rsp+64]		;; restoring the sum
			add rax, bias			;; adding the bias
			mov [rsp+72], rax			;; preserving rax
			mov [rsp+32], rax		;; the 5th argument on stack
			mov r9, bias			;; the 4th argument
			mov r8, [rsp+48]		;; restoring j, the 3rd arg
			mov rdx, [rsp+56]		;; restoring i, the 2nd arg
			lea rcx, print_string2 ;; 1st argument: string
			call printf				;; call the function
			
			add rsp, 40				;; deallocate the shadow space
			
			;; restore rax
			mov rax, [rsp+32]
			ret

;; X in RCX (arg1)
public fibX64
fibX64:
    ;; RAX is the accumulator
	xor rax, rax
	lea rax, [rcx+rdx]		;; a way to add two regs and place it in rax
	mov [rsp+16], rcx		;;  preserving rax in shadow space
	mov [rsp+8], rdx		;; preserving parameter

	mov r9, rcx ; get the first parameter: r9 = X

	mov rax, r9 ; rax = X
	cmp r9, 0 ; if X <= 0
	jle endFibX64 ; return 0

	mov rax, 1
	cmp r9, 1 ; if X==1
	je  endFibX64 ; return 1


	;call fib_x64
	dec r9 ; X--
	mov rcx, r9 ; rcx = X-1
	; before call
	;; Calling our printf function
	sub rsp, 32				;; the shadow space
	mov rcx, r9	;; 1st argument: X-1
	call fib_x64 ;  fibonaccirecursion(X-1)

	mov rdx, rax ; rdx = fibonaccirecursion(X-1)
	dec r9 ; X-2
	mov rcx, r9 ; rcx = X-2
	;before call
	;; RSP has changed, so the displacements have also changed
	mov rax, [rsp+40]		;; restoring the sum
	mov [rsp+16], r9		;; the argument for second fibonaccirecursion on stack
	mov rcx, r9 ;; 1st argument: string
	call fib_x64 ;  fibonaccirecursion(X-2)
	add rsp, 32				;; deallocate the shadow space
	add rax, rdx ; rax = fibonaccirecursion(X-2) + fibonaccirecursion(X-1)
	ret


fib_x64:
    
	mov rax , rcx ; rax = n
    cmp rax , 1 ; if (n <=1)
    jle fib_x64_1 ; return n
    xor rdx , rdx ; fi = 0
    mov rax , 1 ; fj = 1

fib_x64_0: 
    cmp rcx , 1 ; while ( n > 1)
    jle fib_x64_1 ;
    mov r10 , rax ; t = fj
    add rax , rdx ; fj = fi + fj
    mov rdx , r10 ; fi = t
    dec rcx ; n --
    jmp fib_x64_0 ;

fib_x64_1:
    ret ; return

endFibX64:
	ret   

;; i in RCX (arg1)
;; j in RDX (arg2)
;; i in r8 (arg3)
;; j in r9 (arg4)
public use_scanf
use_scanf:
            lea rax, [rcx+rdx]		;; a way to add two regs and place it in rax
			mov [rsp+32], rax		;; preserving rax in shadow space
			mov [rsp+24], rcx		;; preserving a
			mov [rsp+16], rdx		;; preserving b
			mov [rsp+8], r8		;; preserving c

			mov r12, rcx ; r9=a
			add r12, rdx ; r9=a+b
			add r12, r8 ; r9=a+b+c
			
			
			;call printf
			sub rsp, 40				;; the shadow space
			mov r9, rax				;; 4th argument: c=r9
			mov r8, rdx				;; 3rd argument: b=r8
			mov rdx, rcx			;; 2nd argument: a=rdx
			lea rcx, stringqns	;; 1st argument: string
			call printf				;; call the function

			mov r10, rdx ; a=r10
			mov rax,0
			mov r11,0
			;; Calling our scanf function
			mov rdx, r11			;; 2nd argument: inp_int
			lea rcx, print_string_for_scanf	;; 1st argument: string
			call scanf				;; call the function

			;mov rax, r11
			;lea r11, [r11];rax
			mov inp_int, r11
			;mov rax, [rsp+64]		;; restoring the sum
			add r12, inp_int ;result = a+b+c+inp_int
			mov rax,r12
			;mov [rsp+40], rax ;; 5th argument: result
			;mov r9, [rsp+8]				;; 4th argument: c
			;mov r8, [rsp+16]				;; 3rd argument: b
			mov rdx, r10			;; 2nd argument: a
			lea rcx, sum_string	;; 1st argument: string
			call printf				;; call the function

			add rsp, 40				;; deallocate the shadow space
			ret


public max5
max5:

	lea rax, [rcx+rdx]		;; a way to add two regs and place it in rax
	mov [rsp+40], rax		;; preserving rax in shadow space
	mov [rsp+32], rcx		;; preserving l
	mov [rsp+24], rcx		;; preserving k
	mov [rsp+16], rcx		;; preserving j
	mov [rsp+8], rdx		;; preserving i

    mov r10, rcx		; r10 = first parameter(i)
	mov r11, rdx		; r11 = second parameter(j)
	mov r12, r8			; r12 = third parameter(k)
	mov r13, r9			; r13 = fourth parameter(l)

	;for max(intp_int,i,j)
	sub rsp, 48				;; the shadow space
	mov r8, r11				;; 3rd argument: j
	mov rdx, r13			;; 2nd argument: i
	mov rcx, inp_int	;; 1st argument: inp_int
	call max				;; call the function

	mov r11, rax ; r11 = max(intp_int.i,j)

	;for max(max(intp_int,i,j),k,l)
	mov r8, r9				;; 3rd argument: l
	mov rdx, r8			;; 2nd argument: k
	mov rcx, r11	;; 1st argument: inp_int
	call max

	add rsp, 48				;; the shadow space
	ret


max:
    mov r10, rcx		; r10 = first parameter(a)
	mov r11, rdx		; r11 = second parameter(b)
	mov r12, r8			; r12 = third parameter(c)

	mov rax, r10 ; rax = a

	cmp rax, r11 ; if b <= rax(a) 
	jge max_1 ; go to max_1
	mov rax, r11 ; rax = b

max_1:
    cmp rax, r12 ; if c <= rax(a) 
	jge end_max ; go to end_max
	mov rax, r12 ; rax = c
end_max:
    ret
	


end