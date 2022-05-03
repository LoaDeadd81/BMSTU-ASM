PUBLIC menu
MENU_DATA SEGMENT
        menu_str DB 13
        DB 10
        DB '1. Binary unsigned n/s'
		DB 13
        DB 10
        DB '2. Hexadecimal signed n/s'
        DB 13
        DB 10
        DB '0. Exit'
        DB 13
        DB 10
        DB 'Choice: $'
MENU_DATA ENDS

MENU_CODE SEGMENT
        ASSUME CS:MENU_CODE, DS:MENU_DATA
    menu PROC
        mov ax,MENU_DATA
        mov ds,ax

        xor ax,ax
        mov dx,offset menu_str
		mov ah,9 
		int 21h
		mov ah,1
        int 21h
        sub al,48
    menu ENDP        
MENU_CODE ENDS
END