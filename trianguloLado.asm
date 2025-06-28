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
    CALL dibujarTrianguloLado

    INT 20h


dibujarTrianguloLado:
    CALL encenderPixel
    INC DX ; Incrementamos columnas
    CMP DX, 290d ; Condicion limite
    JNE dibujarTrianguloLado ; Seguimos dibujando cols

    ; Dibujamos en filas
    DEC CX ; Incrementamos fila
    INC BP ; Incrementamos el ajustador x col
    MOV DX, BP ; Ajustamos con nuestro BP
    CMP CX, 90d
    JNE dibujarTrianguloLado
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
