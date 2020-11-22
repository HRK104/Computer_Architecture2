


;;Q1

;unoptimised
max5:
	add inp_int, r0, r10 ; set up 1st parameter (inp_int)
	add r26, r0, r11 ; set up 2nd parameter (i)
	add r27, r0, r12 ; set up 2nd parameter (j)
	callr r25, max ; call min (save return address in r25)
	xor r0, r0, r0 ; nop in delay slot
	add r1, r0, r10 ; set up 1st parameter (result returned from min in r1)
	add r28, r0, r11 ; set up 2nd parameter (k)
	add r29, r0. r12 ; set up 3rd parameter (l)
	callr r25, max ; call min (save return address in r25)
	xor r0, r0, r0 ; nop in delay slot
	ret r25, 0 ; return result in r1
	xor r0, r0, r0 ; nop in delay slot
;r26: first parameter(a)
;r27: second parameter(b)
;r28: third parameter(c)
max: 
	add r26, r0, r1 ; use r1 for local v (function result returned in r1)
	sub r27, r1, r0 {C} ; b > v
	jle min0 ;
	xor r0, r0, r0 ; nop in delay slot
	add r27, r0, r1 ; v = b
max0: 
	sub r28, r1, r0 {C} ; c > v
	jle min1 ;
	xor r0, r0, r0 ; nop in delay slot
	add r28, r0, r1 ; v = b
max1:
	ret r25, 0 ; return
	xor r0, r0, r0 ; nop in delay slot



;optimised
max5: 
	add inp_int, r0, r10 ; set up 1st parameter (inp_int)
	add r26, r0, r11 ; set up 2nd parameter (i)
	callr r25, max ; call min (save return address in r25)
	add r27, r0, r12 ; set up 3rd parameter (j) in delay slot
	add r1, r0, r10 ; set up 1st parameter (result returned from min in r1)
	add r28, r0, r11 ; set up 2nd parameter (k)
	callr r25, max ; call min (save return address in r25)
	add r29, r0. r12 ; set up 3rd parameter (l) in delay slot
	ret r25, 0 ; return result in r1
	xor r0, r0, r0 ; nop in delay slot
;r26: first parameter(a)
;r27: second parameter(b)
;r28: third parameter(c)
max: 
	add r26, r0, r1 ; use r1 for local v (function result returned in r1)
	sub r27, r1, r0 {C} ; b > v
	jle min0 ;
	add r27, r0, r1 ; v = b
max0: 
	sub r28, r1, r0 {C} ; c > v
	jle min1 ;
	add r28, r0, r1 ; v = b
max1:
	ret r25, 0 ; return
	xor r0, r0, r0 ; nop in delay slot












;;Q2

	
;r26: first parameter(a)
;r27: second parameter(b)

;unoptimised
fun: 
	sub r27, r0, r0 {c} ; b == 0
	jne fun0 ; jump not equal
	xor r0, r0, r0 ; nop in delay slot
	add r0, r0, r1 ; set result (0)
	ret r25, 0 ; return
	xor r0, r0, r0 ; nop in delay slot
fun0: 
	add r26, r0, r10 ; set up 1st parameter (a)
	add r27, r0, r11 ; set up 2nd parameter (b)
	callr r25, mod ; call an external function mod to evaluate a % b
	xor r0, r0, r0 ; nop in delay slot
	sub r1, r0, r0 {c} ; (a % b) == 0
	jne fun1 ; jump not equal
	xor r0, r0, r0 ; nop in delay slot
	add r26, r0, r12 ; r12 = a
	add r10, r12 ,r10; r10 = r10(a) + r12(a) = a+a -> set up first parameter (a+a)
	add r1, r0, r11 ; set up 2nd parameter (a % b)
	callr r25, fun ; recursively call fun(a+a, a % b)
	ret r25, 0 ; return
	xor r0, r0, r0 ; nop in delay slot
fun1:
	add r26, r0, r10 ; set up 1st parameter (a)
	add r27, r0, r11 ; set up 2nd parameter (b)
	callr r25, mod ; call an external function mod to evaluate a % b
	xor r0, r0, r0 ; nop in delay slot
	sub r1, r0, r0 {c} ; (a % b) == 0
	jne fun1 ; jump not equal
	xor r0, r0, r0 ; nop in delay slot
	add r26, r0, r12 ; r12 = a
	add r10, r12,r10; r10 = r10(a) + r12(a) = a+a -> set up first parameter (a+a)
	add r1, r0, r11 ; set up 2nd parameter (a % b)
	callr r25, fun ; recursively call fun(a+a, a % b)
	add r10, r0, r1 ; r10 = result (fun(a+a, a % b))
	add r10, r26, r10; r10 = fun(a+a, a % b) + a
	add r10, r0, r1 ; set result (fun(a+a, a % b))
	ret r25, 0 ; return
	xor r0, r0, r0 ; nop in delay slot
	

;optimised
fun: 
	sub r27, r0, r0 {c} ; b == 0
	jne fun0 ; jump not equal
	;xor r0, r0, r0 ; nop in delay slot
	add r0, r0, r1 ; set result (0)
	ret r25, 0 ; return
	;xor r0, r0, r0 ; nop in delay slot
fun0: 
	add r26, r0, r10 ; set up 1st parameter (a)
	add r27, r0, r11 ; set up 2nd parameter (b)
	callr r25, mod ; call an external function mod to evaluate a % b
	;xor r0, r0, r0 ; nop in delay slot
	sub r1, r0, r0 {c} ; (a % b) == 0
	jne fun1 ; jump not equal
	;xor r0, r0, r0 ; nop in delay slot
	add r26, r0, r12 ; r12 = a
	add r10, r12,r10; r10 = r10(a) + r12(a) = a+a -> set up first parameter (a+a)
	add r1, r0, r11 ; set up 2nd parameter (a % b)
	callr r25, fun ; recursively call fun(a+a, a % b)
	ret r25, 0 ; return
	;xor r0, r0, r0 ; nop in delay slot
fun1:
	add r26, r0, r10 ; set up 1st parameter (a)
	add r27, r0, r11 ; set up 2nd parameter (b)
	callr r25, mod ; call an external function mod to evaluate a % b
	;xor r0, r0, r0 ; nop in delay slot
	sub r1, r0, r0 {c} ; (a % b) == 0
	jne fun1 ; jump not equal
	;xor r0, r0, r0 ; nop in delay slot
	add r26, r0, r12 ; r12 = a
	add r10, r12,r10; r10 = r10(a) + r12(a) = a+a -> set up first parameter (a+a)
	add r1, r0, r11 ; set up 2nd parameter (a % b)
	callr r25, fun ; recursively call fun(a+a, a % b)
	add r10, r0, r1 ; r10 = result (fun(a+a, a % b))
	add r10, r26, r10; r10 = fun(a+a, a % b) + a
	add r10, r0, r1 ; set result (fun(a+a, a % b))
	ret r25, 0 ; return
	;xor r0, r0, r0 ; nop in delay slot    

	end