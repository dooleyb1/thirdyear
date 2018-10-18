; Copyright (c) 2018 Brandon Dooley - dooleyb1@tcd.ie
;
; function to calculate min(a, b, c)
;							a -> r26
;							b -> r27
;							c -> r28
;
; returns result in r1
;
;---------------------------------------------------------------
;  NO OPTIMIZATION POSSIBLE
;---------------------------------------------------------------

      add r0, #4, r9                ; r9 -> g = 4

min:
      add r26, r0, r1 							; v = a (r26)
      sub r27, r1, r0 							; if (b < v)
      jge min1											;
      xor r0, r0, r0 							  ;	nop in delay slot
      add r27, r0, r1 							; v = b
min1:
      sub r28, r1, r0 							; if (c < v)
      jge min2
      xor r0, r0, r0 								; nop in delay slot
      add r28, r0, r1 							; v = c
min2:
      ret r25, 0 										; return(0)
      xor r0, r0, r0 								; delay slot

; function to calculate p(i, j, k, l)
;							i -> r26
;							j -> r27
;							k -> r28
;							l -> r29
;
; returns min(min(g, i, j), k, l) in r1
;
;---------------------------------------------------------------
;  UNOPTIMISED
;---------------------------------------------------------------

p:
      add r9, r0, r10 							;	r10 = g
      add r26, r0, r11 							; r11 = i
      add r27, r0, r12 							; r12 = j
      callr r25, min 								; min(g, i, j)
      xor r0, r0, r0 								; reset nop delay
      add r1, r0, r10 							; r10 = min(g, i, j)
      add r28, r0, r11 							; r11 = k
      add r29, r0, r12 							; r12 = l
      callr r25, min 								; min(min(g, i, j), k, l)
      xor r0, r0, r0 								; nop reset
      ret r25, 0 										; return(0)
      xor r0, r0, r0 								; nop reset

;---------------------------------------------------------------
;  OPTIMISED
;---------------------------------------------------------------

p:
      add r9, r0, r10 							;	r10 = g
      add r26, r0, r11 							; r11 = i
      callr r25, min 								; min(g, i, j)
      add r27, r0, r12 							; r12 = j
      add r1, r0, r10 							; r10 = min(g, i, j)
      add r28, r0, r11 							; r11 = k
      callr r25, min 								; min(min(g, i, j), k, l)
      add r29, r0, r12 							; r12 = l
      ret r25, 0 										; return(0)
      xor r0, r0, r0 								; nop reset

; function to calculate gcd(a, b)
;							a -> r26
;							b -> r27
;
; returns gcd(a, b) in eax
;
;---------------------------------------------------------------
;  UNOPTIMISED
;---------------------------------------------------------------

gcd:
      xor r1, r1, r1 								; r1 = 0
      sub r26, r1, r0 							; if(b==0)
			je gcd_retA

			add r26, r0, r10 							; r10 = a
			add r27, r0, r11 							; r11 = b
			callr r25, mod								; mod(a, b)
			xor r0, r0, r0 								; nop reset
			add r27, r0, r10							; r10 = b
			add r1, r0, r11 							; r11 = mod(a,b)
			callr r25, gcd								; gcd(b, (a%b))
			xor r0, r0, r0 								; nop result
			ret r25, 0 										; return(0)
			xor r0, r0, r0 								; nop reset

gcd_retA:
			add r26, r0, r25 							; r25 = a
			ret r25, 0										; return(0)
			xor r0, r0, r0								; nop reset

;---------------------------------------------------------------
;  OPTIMISED
;---------------------------------------------------------------

gcd:
      xor r1, r1, r1 								; r1 = 0
      sub r26, r1, r0 							; if(b==0)
			je gcd_retA

			add r26, r0, r10 							; r10 = a
			callr r25, mod								; mod(a, b)
			add r27, r0, r11 							; r11 = b

			add r27, r0, r10							; r10 = b
			add r1, r0, r11 							; r11 = mod(a,b)
			callr r25, gcd								; gcd(b, (a%b))
      add r1, r0, r11 							; r11 = mod(a,b)

			ret r25, 0 										; return(0)
			xor r0, r0, r0 								; nop reset

gcd_retA:
			add r26, r0, r25 							; r25 = a
			ret r25, 0										; return(0)
			xor r0, r0, r0								; nop reset
