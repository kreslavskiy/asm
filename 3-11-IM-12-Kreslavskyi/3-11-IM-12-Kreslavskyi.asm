.386
.model flat, stdcall
option casemap :none

include D:\masm32\include\windows.inc
include D:\masm32\include\dialogs.inc
include D:\masm32\macros\macros.asm

include D:\masm32\include\user32.inc
include D:\masm32\include\kernel32.inc
include D:\masm32\include\masm32.inc
includelib D:\masm32\lib\user32.lib
includelib D:\masm32\lib\kernel32.lib
includelib D:\masm32\lib\masm32.lib

.data?
    passwordInputBuffer db 32 dup (?)

.data
    successPasswordMsg db "Information:", 13, 10, 
        "Name: Mykhailo Kreslavskyi", 13, 10, 
        "Birthday: 15.06.2004", 13, 10, 
        "Score book number: 1216", 0
	errorPasswordMsg db "Wrong password!", 10, 13, 0
	successPasswordTitle db "Success", 0
	errorPasswordTitle db "Error", 0
	password db "thirdlab", 0
	passwordLength dw 8

.code

displaySuccessMessage proc
    invoke MessageBox, 0, addr successPasswordMsg, addr successPasswordTitle, 0
    invoke ExitProcess, NULL
    ret
displaySuccessMessage endp

displayErrorMessage proc
    invoke MessageBox, 0, addr errorPasswordMsg, addr errorPasswordTitle, 0
    invoke ExitProcess, NULL
    ret
displayErrorMessage endp

passwordCheck proc												
    mov bx, lengthof password
    .if passwordInputBuffer[bx - 1] != 0h
       call displayErrorMessage
    .endif

    mov bx, 0
    cycle:
        .if bx == passwordLength
            call displaySuccessMessage
        .else
            mov al, passwordInputBuffer[bx]
            mov ah, password[bx]
            .if al == ah
                inc bx
                jmp cycle
            .else
                call displayErrorMessage
            .endif
        .endif
passwordCheck endp

dialogWindow proc hWindow: dword, message: dword, wParam: dword, lParam: dword	
    .if message == WM_COMMAND
      .if wParam == IDOK
	   	invoke GetDlgItemText, hWindow, 1000, addr passwordInputBuffer, 512
		call passwordCheck
      .endif	   
      .if wParam == IDCANCEL
		invoke ExitProcess, NULL
      .endif
    .elseif message == WM_CLOSE
       invoke ExitProcess, NULL
    .endif
    return 0 
dialogWindow endp

programThirdLab:
	Dialog "System programming 3 lab", "MS Arial", 12, \            							    
        WS_OVERLAPPED or WS_SYSMENU or DS_CENTER, 4, 7, 7, 150, 90, 1024                 							      
		DlgStatic "Enter password:", SS_CENTER, 44, 5, 60, 10, 100	
		DlgEdit WS_BORDER, 12, 20, 120, 10, 1000		
		DlgButton "Confirm", WS_TABSTOP, 21, 40, 30, 15, IDOK 				
		DlgButton "Cancel", WS_TABSTOP, 76, 40, 30, 15, IDCANCEL 	

	CallModalDialog 0, 0, dialogWindow, NULL
end programThirdLab