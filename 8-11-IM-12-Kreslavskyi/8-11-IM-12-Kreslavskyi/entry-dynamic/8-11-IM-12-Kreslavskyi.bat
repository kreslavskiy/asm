\masm32\bin\ml /c /coff "8-11-IM-12-Kreslavskyi-dll.asm"
\masm32\bin\Link.exe /out:"8-11-IM-12-Kreslavskyi-dll.dll" /export:calculate /dll "8-11-IM-12-Kreslavskyi-dll.obj"
\masm32\bin\ml /c /coff "8-11-IM-12-Kreslavskyi.asm"
\masm32\bin\Link.exe /subsystem:windows "8-11-IM-12-Kreslavskyi.obj"	
8-11-IM-12-Kreslavskyi.exe