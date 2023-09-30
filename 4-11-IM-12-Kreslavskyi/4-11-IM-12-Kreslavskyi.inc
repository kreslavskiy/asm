displayMessage macro msg, title
  invoke MessageBox, 0, addr msg, addr title, 0 ; macros that displays message
  invoke EndDialog, NULL, 0 ;; hidden: ending dialog
endm

encryptInput macro
  cld
  mov bx, 0
  .while passwordInputBuffer[bx] != 0h ; start encrypting
    mov al, passwordInputBuffer[bx]
    xor al, key[bx] ;; hidden: xoring
    mov [passwordInputEncryptedBuffer + bx], al
    inc bx
  .endw  
endm

compare macro
  local checkLength, compareStrings, errorMessage, successMessage 
  cld

  checkLength:
    mov bx, LENGTHOF password
    .if passwordInputBuffer[bx-1] != 0h
      jmp errorMessage
    .endif

  compareStrings: ; comparing encrypted password with encrypted input
    mov bx, 0
    .if password[bx] != 0h
      mov al, passwordInputEncryptedBuffer[bx]
      mov ah, password[bx]
      cmp al, ah
      jne errorMessage
      inc bx 
      je compareStrings
    .endif
  
  successMessage: ;; hidden: displaying success message
    displayMessage successPasswordMsgName, successPasswordTitle
    displayMessage successPasswordMsgBirthday, successPasswordTitle
    displayMessage successPasswordMsgScoreBook, successPasswordTitle
    invoke ExitProcess, 0

  errorMessage: ;; hidden: displaying error message
    displayMessage errorPasswordMsg, errorPasswordTitle
    invoke ExitProcess, 0

endm