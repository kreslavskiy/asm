@echo off
ml /c /coff "7-11-IM-12-Kreslavskyi.asm"
ml /c /coff "7-11-IM-12-Kreslavskyi_public.asm"
link /subsystem:WINDOWS "7-11-IM-12-Kreslavskyi.obj" "7-11-IM-12-Kreslavskyi_public.obj"
7-11-IM-12-Kreslavskyi.exe