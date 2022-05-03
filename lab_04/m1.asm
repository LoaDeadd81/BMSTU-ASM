PUBLIC print

EXTRN arr: BYTE
EXTRN inp: FAR

DS2 SEGMENT
		res_message DB 13
		DB 10
		DB 'Result: $'
DS2 ENDS

CS1 SEGMENT
	ASSUME CS:CS1, DS:DS2
	
main:
		jmp inp
	
print:
		mov ax,DS2
		mov ds,ax
		
		mov al,arr[1]
		add al,arr[4]
		add al,48
		
		mov dx,offset res_message
		mov ah,9 
		int 21h
		mov dl,al
		mov ah,2
		int 21h
		
		mov ah,4ch
		int 21h
	
CS1 ENDS

END main