.186

STACK SEGMENT STACK 
		DB 100 DUP (0)
STACK ENDS

DATA SEGMENT
        prompt_n DB 13
		DB 10
		DB 'Input n: $'

        prompt_m DB 13
		DB 10
		DB 'Input m: $'

        prompt_matrix DB 13
		DB 10
		DB 'Input matrix:'
        DB 13
		DB 10
        DB '$'

        res_message DB 13
		DB 10
		DB 'Result:'
        DB 10
		DB 13
        DB '$'

        endl DB 10
		DB 13
        DB '$'

        arr DB 81 dup(0)
        n DB 0
        m DB 0
DATA ENDS

CODE SEGMENT
        ASSUME CS:CODE, DS:DATA

    input_str PROC
        xor cx,cx
        mov cl,[m]
        inp:
            mov ah,1
            int 21h
            sub al,48
            
            mov [bx],al
            inc bx

            loop inp
        ret
    input_str ENDP

    input_mtr PROC
        mov dx,offset prompt_n
		mov ah,9 
		int 21h
		mov ah,1
        int 21h
        sub al,48
        mov [n], al

        mov dx,offset prompt_m
		mov ah,9 
		int 21h
		mov ah,1
        int 21h
        sub al,48
        mov [m], al
        
        mov dx,offset prompt_matrix
		mov ah,9 
		int 21h

        mov bx,offset arr
        
        xor cx, cx
        mov cl,[n]
        input:
            push cx
            call input_str
            pop cx

            mov dx,offset endl
            mov ah,9 
            int 21h

            loop input
        ret
    input_mtr ENDP

    str_sum PROC
    xor ax,ax

    xor cx,cx
    mov cl,[m]
    count:
        add al,[bx]
        inc bx
        loop count

    ret
    str_sum ENDP

    replace PROC
        enter 8, 0
        min_i equ [bp - 2]
        min equ [bp - 4]
        max_i equ [bp - 6]
        max equ [bp - 8]

        mov bx,offset arr

        mov [min_i],bx
        mov [max_i],bx
        call str_sum
        mov[min],ax
        mov[max],ax

        xor cx,cx
        mov cl,[n]
        dec cl
        find_min_max:
            mov dx,bx

            push cx
            call str_sum
            pop cx

            cmp ax,[max]
            jbe no_new_max
            mov [max],ax
            mov [max_i],dx
        no_new_max:

            cmp ax,[min]
            jae no_new_min
            mov [min],ax
            mov [min_i],dx
        no_new_min:
            loop find_min_max

        mov si,[max_i]
        mov di,[min_i]
        cmp si,di
        je no_replace
        xor cx,cx
        mov cl,[m]
        rpl:
            mov al,[si]
            mov dl,[di]
            mov [si],dl
            mov [di],al
            inc si
            inc di
            loop rpl
        no_replace:

        leave
        ret
    replace ENDP

    print_str PROC
        xor cx, cx
        mov cl,[m]
        prt:
            mov dl,[bx]
            add dl,48
            mov ah,2
            int 21h

            inc bx

            loop prt
        ret
    print_str ENDP

    print_mtr PROC
        mov dx,offset res_message
		mov ah,9 
		int 21h

        mov bx,offset arr

        xor cx, cx
        mov cl,[n]
        prt_str:
            push cx
            call print_str
            pop cx

            mov dx,offset endl
            mov ah,9 
            int 21h
            loop prt_str
        ret
    print_mtr ENDP

    main:
        mov ax,DATA
        mov ds,ax

        call input_mtr
        call replace
        call print_mtr

        mov ah,4ch
        int 21h
        
CODE ENDS
END main