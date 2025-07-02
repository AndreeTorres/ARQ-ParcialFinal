org 100h
section .text
    CALL modoVideo
    MOV DX, 240d ;fila
    MOV CX, 200d ;colunma

    rutina:
        CALL printPixel
        inc DX
        cmp CX, 330d
        JE fin
        JL rutina
    fin:
        INT 20h

    modoVideo:
        MOV AH, 00h
        MOV AL, 12h      ; Modo de texto 80x25
        INT 10h          ; Llama a la BIOS para cambiar el modo de video
        RET
    printPixel:
        MOV AH, 0ch
        MOV AL, 07h
        MOV BH, 00h

        INT 10h          ; Llama a la BIOS para dibujar un pixel en la
        RET