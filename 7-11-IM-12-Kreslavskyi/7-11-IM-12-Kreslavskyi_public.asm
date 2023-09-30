.386
.model flat, stdcall
option casemap :none

public calculateDenominator
extern arrayA:qword, arrayC:qword, one:qword

.code
calculateDenominator proc
  fld arrayC[ebp * 8]
  fadd arrayA[ebp * 8] 
  fsub one  
  ret
calculateDenominator endp
end