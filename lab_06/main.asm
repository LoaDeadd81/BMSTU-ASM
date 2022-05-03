EXTRN menu: FAR
DATA SEGMENT
        func DD menu
DATA ENDS

MAIN_CODE SEGMENT
        ASSUME CS:MAIN_CODE, DS:DATA
    main:
    mov ax,DATA
    mov ds,ax

    call menu

MAIN_CODE ENDS
END main