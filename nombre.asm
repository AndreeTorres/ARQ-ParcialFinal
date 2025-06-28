org 100h

section .text


start:
    call establecerModoTexto
    mov dl, 15d       ; Columna inicial
    call posCursor
    mov al, 4Ah   ;      
    call escribir
    call posCursor
    inc dl
    call posCursor
    mov al, 43h
    call escribir

int 20h




establecerModoTexto:
    mov ah, 00h
    mov al, 03h
    int 10h
    ret


escribir:
    mov ah, 09h
    mov bh, 00h
    mov bl, 72h       ; Atributo de color
    mov cx, 01h
    int 10h
    ret


posCursor:
    mov ah, 02h
    mov bh, 00h
    mov dh, 05h       ; Fila 5
    int 10h
    ret