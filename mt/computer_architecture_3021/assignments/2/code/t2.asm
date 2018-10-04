includelib legacy_stdio_definitions.lib
extrn printf:near
option casemap : none																	; case sensitive

.data
public g
g QWORD 4																																						;DD 64 bits 8 bytes
fxp1 db 'qns', 0AH, 00H																															; ASCII format string
fxp2 db 'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d', 0AH, 00H		; ASCII format string

.code

; function to calculate min(a, b, c)
;							a -> rcx
;							b -> rdx
;							c -> r8
;
; returns result in rax

public	min									; export function name

min:
		mov rax, rcx						; v = a (rcx)
		cmp rdx, rax						; if (b < v)
		jge min1								;
		mov rax, rdx						;	v = b
min1:
		cmp r8, rax							; if (c < v)
		jge min2								;
		mov rax, r8							;  v = c
min2:
		ret 0										;

; function to calculate p(i, j, k, l)
;							i -> rcx
;							j -> rdx
;							k -> r8
;							l -> r9
;
; returns min(min(g, i, j), k, l) in rax

public   p									; export function name

p:
		push r8									; preserve k (r8)
		mov r8, rdx							; pass j to min call in r8
		mov rdx, rcx						; pass i to min call in rdx
		mov rcx, g							; pass g to min call in rcx

		sub rsp, 32							; allocate shadow space
		call min								; min(g, i, j)
		add rsp, 32							; deallocate shadow shadowspace

		mov r8, r9							; pass l to min call in r8
		pop rdx									; pop k(r8) to min call in rdx
		mov rcx, rax						; pass min(g, i, j) to min call in rcx
		call min								; rax = min(min(g, i, j), k, l)
		ret 0

; function to calculate gcd(a, b)
;							a -> rcx
;							b -> rdx
;
; returns gcd(a, b) in eax

public	gcd									; export function name

gcd:
		cmp rdx, 0							; if(b==0)
		je gcd_retA							;	return a

		mov rax, rcx						; rax = a (dividend)
		mov rcx, rdx						; rcx = b (divisor)
		cqo											; sign extend rax into rdx
		idiv rcx								; rdx = a % b
		sub rsp, 32							; allocate shadow space

		call gcd								; rax = gcd(b, (a%b)) -> [b -> rcx, (a%b) -> rdx]

		add rsp, 32							; deallocate shadow space
		jmp gcd_done						;

gcd_retA:
		mov rax, rcx						; rax = a

gcd_done:
		ret 0										; return


; function q(a, b, c, d, e)
;							a -> rcx
;							b -> rdx
;							c -> r8
;							d -> r9
;							e -> rbp+48

;	_int64 sum = a + b + c + d + e;
;	printf("a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d\n", a, b, c, d, e, sum);
;	return sum;

public   q									; export function name

q:
		push rbp
		mov  rbp, rsp						; extract rsp
		push rbx								; push non-volatile register


		lea rax,[rcx+rdx]   		; rax = a+b
		add rax,r8							; rax += c
		add rax,r9         			; rax += d
		add rax,[rbp+48]				; rax += e
		push rax								; preserve sum (rax)

		push rax								; push sum to printf stack
		push [rbp+48]						; push e to printf stack
		push r9									; push d to printf stack
		mov  r9,  r8						; r9 -> c
		mov  r8,  rdx						; r8 -> b
		mov  rdx, rcx						; rdx -> a
		lea  rcx, fxp2 					; rcx -> ascii format string address
		sub  rsp, 32						; allocate shadowspace for printf

		call printf

		add  rsp, 32						; de-allocate shadowspace
		add  rsp, 24						; pop 3 (8 x 3) params off stack
		pop  rax								; pop preserved sum off stack
		pop  rbx								; restore rbx

		mov  rsp, rbp						; restore rsp
		pop  rbp								; restore rbp
		ret	0

; // Function performs q(a, b, c, d, e) without allocating shadow space
; function qns(a, b, c, d, e)
;							a -> rcx
;							b -> rdx
;							c -> r8
;							d -> r9
;							e -> rbp+48

;	_int64 sum = a + b + c + d + e;
;	printf("a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d\n", a, b, c, d, e, sum);
;	return sum;

public	qns

qns:
	push rbp									; preserve rbp
	mov  rbp, rsp							; extract rsp
	push rbx									; preserve ebx (non-volatile)

	lea  rcx, fxp1 						; string address

	sub rsp, 32								; allocate shadow space
	call printf
	add rsp, 32								; deallocate shadow space

	xor rax, rax							; rax = 0

	pop  rbx									; restore rbx (non-volatile)
	mov  rsp, rbp							; restore rsp
	pop  rbp									; restore rbp
	ret 											; return

end
