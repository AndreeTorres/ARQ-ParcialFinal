org 100h
section .text
    call modoVideo
    mov dx, 240d ;fila
    mov cx, 200d ;colunma
    rutina:
        call printPixel
        inc dx
        cmp cx, 330d
        je fin
        jl rutina
    fin:
        int 20h

    modoVideo:
        mov ah, 00h
        mov al, 12h      ; Modo de texto 80x25
        int 10h          ; Llama a la BIOS para cambiar el modo de video
        ret
    printPixel:
        mov ah, 0ch
        mov al, 07h
        mov bh, 00h

        int 10h          ; Llama a la BIOS para dibujar un pixel en la
        ret