; function to calculate max(a, b, c)
;              a -> [ebp+8]
;              b -> [ebp+12]
;              c -> [ebp+16]
;
; returns result in eax

public    max		   					    ; make sure function name is exported

max:	    push  ebp			     		; push frame pointer
          mov   ebp, esp		  	; update ebp

          mov   eax, [ebp+8]		; v = a
			    mov		ecx, [ebp+12]		; ecx = b
          cmp   ecx, eax		  	; if (b > v)
          jle   max_1				    ;
			    mov		eax, ecx			  ;	v = b

max_1:		mov		ecx, [ebp+16]		; ecx = c
			    cmp		ecx, eax			  ; if (c > v)
          jle   max_2	  			  ;
			    mov		eax, ecx			  ;	v = c
max_2:		mov   esp, ebp			  ; restore esp
          pop   ebp					    ; restore ebp
          ret   0					      ; return

; function to calculate p(i, j, k, l)
;              i -> [ebp+8]
;              j -> [ebp+12]
;              k -> [ebp+16]
;              l -> [ebp+20]
;
; returns max( max(g, i, j), k, l)

public    p	  	   					    ; make sure function name is exported

p:	      push  ebp			     		; push frame pointer
          mov   ebp, esp		  	; update ebp

          push  [ebp+12]        ; push j for max(g, i, j)
          push  [ebp+8]         ; push i for max(g, i, j)
          push  g               ; push g for max(g, i, l)

          call max              ; eax = max(g, i, j)

          push [ebp+20]         ; push l for max(eax, k, l)
          push [ebp+16]         ; push k for max(eax, k, l)
          push eax              ; push eax for max(eax, k, l)

          call max              ; max( max(g, i, j), k, l)

          mov esp, ebp          ; restore stack pointer
          pop ebp               ; restore frame pointer
          ret 0                 ; return 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; function to calculate max(a, b, c)
;              a -> rcx
;              b -> rdx
;              c -> r8
;
; returns result in eax

public    max		   					    ; make sure function name is exported

min:	    mov   rax, rcx        ; v = a
          cmp   rdx, rax		  	; if (b > v)
          jle   max_1				    ;
			    mov		rax, rdx			  ;	v = b

max_1:		cmp		r8, rax			    ; if (c > v)
          jle   max_2	  			  ;
			    mov		rax, r8		   	  ;	v = c

max_2:		ret   0					      ; return


; function to calculate p(i, j, k, l)
;              i -> rcx
;              j -> rdx
;              k -> r8
;              l -> r9
;
; returns max( max(g, i, j), k, l)

public    p	  	   					    ; make sure function name is exported

p:	      push r8                ; preserve r8 (k)
          mov r8, rdx            ; r8 = j
          mov rdx, rcx           ; rdx = i
          mov rcx, g             ; rcx = g

          add esp, 32            ; allocate shadow space
          call max               ; rax = max (g, i, j)
          sub esp, 32            ; de-allocate shadow space

          mov r8, r9             ; r8 = l
          pop rdx                ; rdx = k
          mov rcx, rax           ; rcx = max(g,i,j)

          add esp, 32            ; allocate shadow space
          call max               ; rax = max(max(g, i, j), k, l)
          sub esp, 32            ; de-allocate shadow space

          ret 0                  ; return
