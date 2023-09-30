.386
.model flat, stdcall
option casemap :none

include 4-11-IM-12-Kreslavskyi.inc

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
