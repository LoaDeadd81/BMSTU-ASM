PUBLIC arr
PUBLIC inp

EXTRN print: FAR

DS2 SEGMENT
		arr DB 5 dup(0)
		message DB 13
		DB 10
		DB 'Input numbers: $'
DS2 ENDS

CS2 SEGMENT
		assume CS:CS2, DS:DS2
		
inp:
		mov ax,DS2
		mov ds,ax
		
		mov dx,offset message
		mov ah,9 
		int 21h
		
		mov bx,offset arr
		mov ah,1
		mov cx,5
		inp_arr:
			int 21h
			sub al,48
			mov [bx], al
			inc bx
			loop inp_arr
		
		jmp print
CS2 ENDS

END