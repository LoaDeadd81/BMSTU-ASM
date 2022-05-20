@echo off

if not exist rsrc.rc goto over1
\masm32\bin\rc /v rsrc.rc
\masm32\bin\cvtres /machine:ix86 rsrc.res
 :over1
 
if exist "template.obj" del "lab_11.obj"
if exist "template.exe" del "lab_11.exe"

\masm32\bin\ml /c /coff "lab_11.asm"
if errorlevel 1 goto errasm

if not exist rsrc.obj goto nores

\masm32\bin\Link /SUBSYSTEM:WINDOWS "lab_11.obj" rsrc.res
 if errorlevel 1 goto errlink

dir "lab_11.*"
goto TheEnd

:nores
 \masm32\bin\Link /SUBSYSTEM:WINDOWS "lab_11.obj"
 if errorlevel 1 goto errlink
dir "lab_11.*"
goto TheEnd

:errlink
 echo _
echo Link error
goto TheEnd

:errasm
 echo _
echo Assembly Error
goto TheEnd

:TheEnd
 
pause
