.386
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\dialogs.inc
include \masm32\macros\macros.asm

include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data?
  passwordInputBuffer db 16 dup (?)
  passwordInputEncryptedBuffer db 16 dup (?)

.data
  successPasswordMsgName db "Name: Mykhailo Kreslavskyi", 0
  successPasswordMsgBirthday db "Birthday: 15.06.2004", 0
  successPasswordMsgScoreBook db "Score book number: 1216", 0
	successPasswordTitle db "Success", 0
	errorPasswordMsg db "Wrong password!", 10, 13, 0
	errorPasswordTitle db "Error", 0
	password db "1PQ45U7V", 0
  key db "E88FQ9V4", 0
	passwordLength dw 8

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

.code

dialogWindow proc hWindow: dword, message: dword, wParam: dword, lParam: dword	
    .if message == WM_COMMAND

      .if wParam == IDOK
	   	  invoke GetDlgItemText, hWindow, 1000, addr passwordInputBuffer, 512
		    encryptInput
        compare
      .endif	   

      .if wParam == IDCANCEL
		    invoke ExitProcess, NULL
      .endif
      
    .elseif message == WM_CLOSE
      invoke ExitProcess, NULL
    .endif
    return 0 
dialogWindow endp

start:
	Dialog "System programming 4 lab", "MS Arial", 12, \            							    
        WS_OVERLAPPED or WS_SYSMENU or DS_CENTER, 4, 7, 7, 150, 90, 1024                 							      
		DlgStatic "Enter password:", SS_CENTER, 44, 5, 60, 10, 100	
		DlgEdit WS_BORDER, 12, 20, 120, 10, 1000		
		DlgButton "Confirm", WS_TABSTOP, 21, 40, 30, 15, IDOK 				
		DlgButton "Cancel", WS_TABSTOP, 76, 40, 30, 15, IDCANCEL 	

	CallModalDialog 0, 0, dialogWindow, NULL
end start
