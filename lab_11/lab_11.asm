
.486                      
.model flat, stdcall    
option casemap :none

include \masm32\include\dialogs.inc
include lab_11.inc

dlgproc PROTO :DWORD,:DWORD,:DWORD,:DWORD
GetNum PROTO :DWORD,:DWORD
ShowRes PROTO :DWORD,:DWORD

.code


start:

      mov hInstance, FUNC(GetModuleHandle,NULL)

      call main

      invoke ExitProcess,eax


main proc

    LOCAL icce:INITCOMMONCONTROLSEX
    
    mov icce.dwSize, SIZEOF INITCOMMONCONTROLSEX
    mov icce.dwICC, ICC_DATE_CLASSES or \
                    ICC_INTERNET_CLASSES or \
                    ICC_PAGESCROLLER_CLASS or \
                    ICC_COOL_CLASSES

    invoke InitCommonControlsEx,ADDR icce

    Dialog "lab_11","MS Sans Serif",14, \     ; caption,font,pointsize
            WS_OVERLAPPED or \              ; styles for
            WS_SYSMENU or DS_CENTER, \                   ; style
            3, \                                            ; control count
            50,50,66,64, \                                ; x y co-ordinates
            1024                                            ; memory buffer size

    DlgEdit WS_TABSTOP or WS_BORDER,2,2,60,12,100
    DlgEdit WS_TABSTOP or WS_BORDER,2,16,60,12,101
    DlgButton "Sum",WS_TABSTOP,2,30,60,12,IDOK

    CallModalDialog hInstance,0,dlgproc,NULL

    ret

main endp



dlgproc proc hWin:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
    LOCAL num1:DWORD
    LOCAL num2:DWORD

    .if uMsg == WM_INITDIALOG

    .elseif uMsg == WM_COMMAND
      .if wParam == IDOK
        jmp sum
      .endif

    .elseif uMsg == WM_CLOSE
      quit_dialog:
      invoke EndDialog,hWin,0
    .endif
    jmp no_action

    sum:
        invoke GetNum,hWin,100
        mov num1,eax
        invoke GetNum,hWin,101
        mov num2,eax
        mov eax,num1
        mov ebx,num2
        add eax,ebx
        invoke ShowRes,hWin,eax

    no_action:

    xor eax, eax
    ret

dlgproc endp

GetNum proc hWin:DWORD,id:DWORD
        LOCAL buffer:DWORD
        LOCAL tl:DWORD
        LOCAL hEdit :DWORD

        invoke GlobalAlloc,GMEM_FIXED or GMEM_ZEROINIT, 32
        mov buffer, eax
        invoke GetDlgItem,hWin,id
        mov hEdit, eax
        invoke GetWindowTextLength,hEdit
        mov tl, eax
        inc tl     
        mov ecx, buffer
        invoke SendMessage,hEdit,WM_GETTEXT,tl,ecx
        mov ecx, buffer
        invoke StrToIntA,ecx
        mov tl,eax
        ;invoke MessageBox,hWin,buffer,SADD("You typed ..."),MB_OK
        invoke GlobalFree,buffer
        mov eax,tl
    ret
GetNum endp

ShowRes proc hWin:DWORD,num:DWORD
        LOCAL buffer:DWORD
        LOCAL tl:DWORD
        LOCAL hEdit :DWORD

        invoke GlobalAlloc,GMEM_FIXED or GMEM_ZEROINIT, 32
        mov buffer, eax

        xor ecx,ecx
        mov eax,num
        count:
        mov ebx, 10d
        cdq 
        div ebx
        inc ecx
        cmp eax,0
        jg count

        mov edi,buffer
        add edi,ecx
        dec edi

        mov eax,num
        cast:
        mov ebx, 10d
        cdq 
        div ebx
        add edx, 48
        push eax
        mov eax, edx
        stosb 
        pop eax 
        sub edi,2
        cmp eax,0
        jg cast

        invoke MessageBox,hWin,buffer,SADD("Res"),MB_OK
        invoke GlobalFree,buffer
    ret
ShowRes endp

end start