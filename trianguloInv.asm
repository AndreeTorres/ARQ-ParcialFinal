ORG 100h

SECTION .text 
    XOR AX,AX
    XOR BX,BX
    XOR CX,CX
    XOR DX,DX

    MOV DX, 190d ; Columnas
    MOV CX, 190d ; Filas
    MOV BP, 190d ; ajustador

main:
    CALL iniciarModoVideo
    CALL dibujarTrianguloInv

    INT 20h


dibujarTrianguloInv:
    ; Dibujar columnas
    CALL encenderPixel
    DEC DX                ; Decrementamos columnas para formar el lado invertido
    CMP DX, 90d           ; Condición límite para las columnas
    JNE dibujarTrianguloInv ; Seguimos dibujando columnas

    ; Dibujar filas
    INC CX                ; Incrementamos fila para avanzar hacia abajo
    DEC BP                ; Ajustamos el contador para las columnas
    MOV DX, BP            ; Ajustamos columna con BP
    CMP CX, 290d          ; Condición límite para las filas
    JNE dibujarTrianguloInv ; Seguimos dibujando filas
    RET




iniciarModoVideo:
    MOV AH, 00h
    MOV AL, 12h ; 640x480, 16 colores
    INT 10h
    RET

encenderPixel:
   MOV AH, 0Ch           ; Función del BIOS para poner un píxel
   MOV AL, 01h           ; Color del píxel (azul)
   MOV BH, 0             ; Página de video 0
   INT 10h               ; Enciende el píxel
   RET
