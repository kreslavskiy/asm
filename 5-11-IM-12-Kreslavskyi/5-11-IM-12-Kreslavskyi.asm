.386
.model flat, stdcall
option casemap: none

include \masm32\include\masm32rt.inc

displayMessage macro windowMessage, windowTitle 
  invoke MessageBox, 0, offset windowMessage, offset windowTitle, 0
endm

.data 
  labTitle db "System programming 5 lab", 0
  labMessageFormat db "Variant: 11", 10,
                "Formula: (2*c + d/4 + 23)/(a*a - 1)", 10, 10,
                "(2*%i + %i/4 + 23)/(%i*%i - 1) = %i", 10,
                "Modified result = %i", 10,
                "where: a = %i, c = %i, d = %i", 10, 10, 0
  errorFormat db "Variant: 11", 10,
                "Formula: (2*c + d/4 + 23)/(a*a - 1)", 10, 10,
                "(2*%i + %i/4 + 23)/(%i*%i - 1) = UNDEFINED", 10,
                "Modified result = UNDEFINED", 10,
                "where: a = %i, c = %i, d = %i", 10, 10, 
                "DIVISION BY 0 IS NOT ALLOWED", 10,
                "RESULT IS UNDEFINED", 10, 10, 0
  arrayA dd 5, -2, -3, 2, 1, 4
  arrayC dd 63, -12, 24, -13, 5, -23
  arrayD dd -20, 40, -92, -96, 8, 32

.data?
  result dd 5 dup(?)
  numerator dd 1 dup(?)
  denominator dd 1 dup(?)
  labMessage db 512 dup(?)

.code
programFifthLab:
  mov esi, 0
  .while esi < 6

    ;; denominator
    mov edx, arrayA[esi * 4]
    mov ecx, arrayA[esi * 4]
    imul edx, ecx ;; a*a
    sub edx, 1 ;; a*a - 1

    mov denominator, edx

    .if denominator == 0
      invoke wsprintf, addr labMessage, addr errorFormat, 
        arrayC[esi * 4], arrayD[esi * 4], arrayA[esi * 4], arrayA[esi * 4],
        arrayA[esi * 4], arrayC[esi * 4], arrayD[esi * 4]

      displayMessage labMessage, labTitle
    .else 
      ;; numerator
      mov ebx, arrayC[esi * 4]
      mov ecx, 2
      imul ebx, ecx ;; 2*c

      mov eax, arrayD[esi * 4]
      mov ecx, 4
      cdq
      idiv ecx ;; d/4

      add eax, ebx ;; 2*c + d/4 
      add eax, 23 ;; 2*c + d/4 + 23

      mov numerator, eax

      ;; final calculation
      mov eax, numerator
      mov ecx, denominator
      cdq
      idiv ecx ;; (2*c + d/4 + 23)/(a*a - 1)

      mov result, eax

      ;; check if result is odd or even
      test eax, 1
      jnz oddNumber
      jz evenNumber

      oddNumber:
        imul eax, 5 ;; result * 5
        jmp message

      evenNumber:
        mov ecx, 2
        cdq
        idiv ecx ;; result / 2
        jmp message

      message: 
        invoke wsprintf, addr labMessage, addr labMessageFormat, 
          arrayC[esi * 4], arrayD[esi * 4], arrayA[esi * 4], arrayA[esi * 4],
          result, eax,
          arrayA[esi * 4], arrayC[esi * 4], arrayD[esi * 4]

        displayMessage labMessage, labTitle
    .endif

    mov labMessage, 0h
    inc esi
  .endw

end programFifthLab
