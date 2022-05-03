.MODEL FLAT, C
.CODE
.STACK
.686

my_strcpy PROC C, dst:dword, src:dword, n:dword
    mov eax, dst
    mov edi,dst
    mov esi,src
    mov ecx, n

    cmp edi,esi
    je _end
    jb no_over

    mov ebx, esi
    add ebx, ecx
    cmp edi, ebx
    jae no_over
    
    std
    mov edx, ecx
    dec edx
    add esi, edx
    add edi, edx
    rep movsb
    cld
    ret

    no_over:
    rep movsb

    _end:
    ret
my_strcpy ENDP
END