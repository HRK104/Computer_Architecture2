.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive


	.data

	public bias		;
	bias DWORD 4		;
.code

;
; fib32.asm
;

;
; example mixing C/C++ and IA32 assembly language
;
; use stack for local variables
;
; simple mechanical code generation which doesn't make good use of the registers

public      fib_IA32a               ; make sure function name is exported

fib_IA32a:  push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp
            sub     esp, 8          ; space for local variables fi [ebp-4] and fj [ebp-8]
            mov     eax, [ebp+8]    ; eax = n
            cmp     eax, 1          ; if (n <= 1) ...
            jle     fib_IA32a2      ; return n
            xor     ecx, ecx        ; ecx = 0   NB: mov [ebp-4], 0 NOT allowed
            mov     [ebp-4], ecx    ; fi = 0
            inc     ecx             ; ecx = 1   NB: mov [ebp-8], 1 NOT allowed
            mov     [ebp-8], ecx    ; fj = 1
fib_IA32a0: mov     eax, 1          ; eax = 1
            cmp     [ebp+8], eax    ; while (n > 1)
            jle     fib_IA32a1      ;
            mov     eax, [ebp-4]    ; eax = fi
            mov     ecx, [ebp-8]    ; ecx = fj
            add     eax, ecx        ; ebx = fi + fj
            mov     [ebp-4], ecx    ; fi = fj
            mov     [ebp-8], eax    ; fj = eax
            dec     DWORD PTR[ebp+8]; n--
            jmp     fib_IA32a0      ;
fib_IA32a1: mov     eax, [ebp-8]    ; eax = fj
fib_IA32a2: mov     esp, ebp        ; restore esp
            pop     ebp             ; restore ebp
            ret     0               ; return
    
;
; example mixing C/C++ and IA32 assembly language
;
; makes better use of registers and instruction set
;

public      fib_IA32b               ; make sure function name is exported

fib_IA32b:  push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp
            mov     eax, [ebp+8]    ; mov n into eax
            cmp     eax, 1          ; if (n <= 1)
            jle     fib_IA32b2      ; return n
            xor     ecx, ecx        ; fi = 0
            mov     edx, 1          ; fj = 1
fib_IA32b0: cmp     eax, 1          ; while (n > 1)
            jle     fib_IA32b1      ;
            add     ecx, edx        ; fi = fi + fj
            xchg    ecx, edx        ; swap fi and fj
            dec     eax             ; n--
            jmp     fib_IA32b0      ;
fib_IA32b1: mov     eax, edx        ; eax = fj
fib_IA32b2: mov     esp, ebp        ; restore esp
            pop     ebp             ; restore ebp
            ret     0               ; return
    

	public array_proc 		; makes the procedure/function visible to C++ file

array_proc:
	;; Prologue
	;;  pushing the base pointer onto the stack
	push ebp
	;; establishing the stack frame
	mov ebp, esp

	;; Main function body
	;; Callee preserved ESI register
	push esi

	;; EAX is the accumulator
	xor eax, eax 		; clearing EAX

	;; Retreiving the arguments
	mov ecx, [ebp+12]
	mov esi, [ebp+8]

	;; the main loop
L1:	add eax, [esi] 		; accessing the array
	add esi, 4		; incrementing the pointer
	loop L1			; looping back to L1

	;; Retrieving ESI pushed earlier
	pop esi

	;; Epilogue
	mov esp, ebp
	pop ebp
	ret

public poly
poly:
	;; Prologue
	;;  pushing the base pointer onto the stack
	push ebp
	;; establishing the stack frame
	mov ebp, esp

	;; Main function body
	;; Callee preserved ESI register
	push esi

	;; EAX is the accumulator
	xor eax, eax 		; clearing EAX

	;; Retreiving the arguments
	mov esi, [ebp+8] ; first parameter

	mov ebx, 2 ; arg(ebx) = 2
	call pow
	add eax, esi
	inc eax
	jmp poly_end

pow:
    mov eax, 1 ; result(eax) = 1
	mov ecx, 0 ; i(ecx) = 0
pow_for:
    cmp ecx, ebx ; if i >= arg0
	jge pow_for_end ; end for loop
	imul esi ; result(eax) = result(eax) * arg0(esi)
	inc ecx ; i++
	jmp pow_for
pow_for_end:
    ret

poly_end:
	;; Retrieving ESI pushed earlier
	pop esi

	;; Epilogue
	mov esp, ebp
	pop ebp
	ret


public factorial
factorial:
    ;; Prologue
	;;  pushing the base pointer onto the stack
	push ebp
	;; establishing the stack frame
	mov ebp, esp

	;; Main function body
	;; Callee preserved ESI register
	push esi

	;; EAX is the accumulator
	xor eax, eax 		; clearing EAX

	;; Retreiving the arguments
	mov ecx, [ebp+8] ; first parameter

    cmp ecx, 0 ; if ecx <= 0
	jle factorial1 ; return 1

	;otherwise
	mov edx, ecx ; edx = value of parameter
	dec ecx

	push edx ;save the originalvalue of parameter
	push ecx ;push next parameter
	call factorial
	pop ecx ; pop next parameter
	pop edx ; pop original paramter
	imul eax, edx ; result = currentResult * originalParameter
	jmp factorialEnd

factorial1:
    mov eax,1

factorialEnd:
	;; Retrieving ESI pushed earlier
	pop esi

	;; Epilogue
	mov esp, ebp
	pop ebp
	ret


public multiple_k_asm
multiple_k_asm:
	;; Prologue
	;;  pushing the base pointer onto the stack
	push ebp
	;; establishing the stack frame
	mov ebp, esp

	;; Main function body
	;; Callee preserved ESI register
	push esi

	;; EAX is the accumulator
	xor eax, eax 		; clearing EAX

	;; Retreiving the arguments
	mov edi, [ebp+16] ; third parameter : arrayN1
	mov eax, [ebp+12] ; second parameter: K
	cwd
	mov ebx, eax
	mov eax, [ebp+8] ; first parameter: N
	cwd

	xor ecx, ecx ; i=0

forLoop:	
    mov esi, eax ; keep eax in esi
    mov eax, ecx ; eax = i
	inc eax ; eax = i+1
	mov edx, 0 ; set reminder(edx) to 0
	idiv ebx ; eax / ebx
	cmp edx, 0 ; if reminder(edx) != 0
	jne set0 ; go to set0

	;remainder == 0, set1
	mov dx, 1
	mov [edi + 2 * ecx], dx ;array[i] = 1;

incrementI:
    mov eax, esi
	inc ecx ; ++i

	cmp ecx, eax ; if i < N
	jle forLoop ; go to forLoop
	jmp multiple_k_asm_end ; otherwise, multiple_k_asm_end

set0:
    mov dx, 0
    mov [edi + 2 * ecx], dx ;array[i] = 0;
	jmp incrementI

multiple_k_asm_end:
	;; Retrieving ESI pushed earlier
	pop esi

	;; Epilogue
	mov esp, ebp
	pop ebp
	ret

end
