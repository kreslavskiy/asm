.386
.model flat, stdcall
option casemap :none

.code

entryPoint proc hInstDLL: dword, reason:dword 
    mov eax, 1
    ret
entryPoint endp

calculate proc arrayA: ptr qword, arrayB: ptr qword, arrayC: ptr qword, arrayD: ptr qword,
one: ptr qword, fourtyTwo: ptr qword, two: ptr qword, numerator: ptr tbyte, denominator: ptr tbyte, result: ptr qword
    finit
    mov ecx, arrayC
    fld qword ptr [ecx] ;; c
    mov ecx, arrayA
    fld qword ptr [ecx] ;; a
    fadd st(0), st(1) ;; c + a
    mov ecx, one
    fld qword ptr [ecx] ;; 1
    fxch st(1) 
    fsub st(0), st(1) ;; c + a - 1   
    mov ecx, denominator
    fstp tbyte ptr [ecx] ;; save denominator
    mov ecx, fourtyTwo
    fld qword ptr [ecx] ;; 42
    mov ecx, arrayB
    fdiv qword ptr [ecx] ;; 42/b
    fsqrt ;; sqrt(42/b)
    mov ecx, arrayD
    fmul qword ptr [ecx] ;; d*sqrt(42/b)
    mov ecx, arrayC
    fld qword ptr [ecx] ;; c
    mov ecx, two
    fmul qword ptr [ecx] ;; 2*c
    fsub st(0), st(1) ;; 2*c - d*sqrt(42/b)
    mov ecx, numerator
    fstp tbyte ptr [ecx] ;; save numerator
    mov ecx, numerator
    fld tbyte ptr [ecx] ; st(1)
    mov ecx, denominator
    fld tbyte ptr [ecx] ; st(0)
    fdivp st(1), st(0)
    mov ecx, result
    fstp qword ptr [ecx]
  ret
calculate endp
end entryPoint