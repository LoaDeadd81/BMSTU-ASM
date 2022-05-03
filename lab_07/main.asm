.186
.MODEL TINY
CODE SEGMENT
    ASSUME CS:CODE
    org 100h
main:
    jmp install
    old_int dd ?
    ex_flag dw 1978   
    speed db 1Fh
    uninstall_msg db 'Uninstalled!$'
    install_msg   db 'Installed!$'
my_int PROC
    pusha
    push ds
    push es

    jmp CS:old_int

    mov ah, 2
    int 1ah           
    cmp dh, speed
	mov speed, dh
	je end_int

    mov al, 0f3h
	out 60h, al
	mov al, speed
	out 60h, al
    
    dec speed
	cmp speed, 0h
	je reset_speed
	jmp end_int     

    reset_speed:
    mov speed, 01fh
    end_int:
    pop ds
    pop es
    popa
    iret
my_int ENDP

uninstall:
    cli
    mov dx, word ptr ES:old_int
	mov ds, word ptr ES:old_int + 2
	mov ax, 2508h
	int 21h
    
    mov al, 0F3h
	out 60h, al
	mov al, 0
	out 60h, al
    
    mov ah, 49h
	int 21h

    mov dx, offset uninstall_msg
    mov ah, 9h
    int 21h
    
    mov ah, 4ch
    int 21h

install:
    cli
    mov ax, 3508h
    int 21h                       
    cmp es:ex_flag, 1978
    je uninstall   
  
    mov word ptr old_int, bx
	mov word ptr old_int + 2, es
    
    mov ax, 2508h
    mov dx, cs
	mov ds, dx         
    mov dx, offset my_int
    int 21h

    mov dx, offset install_msg
    mov ah, 9
    int 21h
    
    mov dx, offset uninstall
	int 27h
CODE ENDS    
END main