org 100h

section .data
nombre db 'Juan$', 0 ; Cadena de caracteres con terminación nula
section .text
    CALL establecerModoTexto
    mov AH,09h
    mov DX,nombre

    int 21h            ; Mostrar la cadena en pantalla


    int 20h            ; Terminar el programa

establecerModoTexto:
    mov ah, 00h
    mov al, 03h
    int 10h
    ret

escribir: 
        mov ah, 09h
        mov bh, 00h
        mov bl, 72h
        mov cx, 01h
        int 10h 
        ret
        
posCursor:
        mov ah, 02h
        mov bh, 00h
        mov dh, 05h
        int 10h 
        ret