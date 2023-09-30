.386
.model flat, stdcall
option casemap :none
include \masm32\include\masm32rt.inc

.data?
    windowContentFinal db 256 dup(?)
    uninitializedPositiveD db 128 dup(?)
    uninitializedPositiveE db 128 dup(?)
    uninitializedPositiveF db 128 dup(?)
    uninitializedNegativeD db 128 dup(?)
    uninitializedNegativeE db 128 dup(?)
    uninitializedNegativeF db 128 dup(?)
 
.data
    windowCaption db "System programming 1 lab", 0
    windowContent db "My birthday: 15.06.2004", 10, "Score book number: 1216", 10, "Numbers:",10, "A = %d, -A = %d", 10, "B = %d, -B = %d", 10, "C = %d, -C = %d",
	10, "D = %s, -D = %s", 10, "E = %s, -E = %s", 10, "F = %s, -F = %s", 0

    birthday db "15.06.2004", 0

    positiveA db 15
    positiveA1 dw 15
    positiveA2 dd 15
    positiveA3 dq 15

    negativeA db -15
    negativeA1 dw -15
    negativeA2 dd -15
    negativeA3 dq -15

    positiveB dw 1506
    positiveB1 dd 1506
    positiveB2 dq 1506

    negativeB dw -1506
    negativeB1 dd -1506
    negativeB2 dq -1506

    positiveC dd 15062004
    positiveC1 dq 15062004

    negativeC dd -15062004
    negativeC1 dq -15062004

    positiveD dq 0.012
    negativeD dq -0.012

    positiveD1 dd 0.012
    negativeD1 dd -0.012

    positiveE dq 1.238
    negativeE dq -1.238
    
    positiveF dq 12386.516
    negativeF dq -12386.516

    positiveF1 dt 12386.516
    negativeF1 dt -12386.516

.code
programFirstLab:
    invoke FloatToStr2, positiveD, addr uninitializedPositiveD
    invoke FloatToStr2, positiveE, addr uninitializedPositiveE
    invoke FloatToStr2, positiveF, addr uninitializedPositiveF
    invoke FloatToStr2, negativeD, addr uninitializedNegativeD
    invoke FloatToStr2, negativeE, addr uninitializedNegativeE
    invoke FloatToStr2, negativeF, addr uninitializedNegativeF

    invoke wsprintf, 
    addr windowContentFinal, 
    addr windowContent, 
    positiveA2, 
    negativeA2, 
    positiveB1, 
    negativeB1, 
    positiveC, 
    negativeC, 
	offset uninitializedPositiveD, 
    offset uninitializedNegativeD, 
	offset uninitializedPositiveE, 
    offset uninitializedNegativeE,
    offset uninitializedNegativeF, 
    offset uninitializedNegativeF

	invoke MessageBox, 0, addr windowContentFinal, addr windowCaption, 0
    invoke ExitProcess, 0
end programFirstLab