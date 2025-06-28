org 100h

section .data
nombre db "Juan"
section .text
    mov bp, nombre
    mov si, 00h
    CALL establecerModoTexto
    mov dl, 35d ; Columna inicial
print:
    call posCursor
    mov al, [bp + si]  ; Cargar el carácter actual
    call escribir
    inc dl
    inc si             ; Avanzar al siguiente carácter
    cmp si, 4d ; Comprobar si es el final de la cadena
    jne print          ; Si no es el final, repetir

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