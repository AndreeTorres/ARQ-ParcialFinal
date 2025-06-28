ORG 100H

SECTION .text
    ; LIMPIAR LOS REGISTROS
    XOR AX, AX
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX
    CALL iniciarModoVideo
    MOV DX, 240d
    MOV CX, 320d
    CALL imprimirCuadro

imprimirCuadro:
    CALL imprimirLinea
    INC DX
    CMP DX, 340d
    JL imprimirCuadro
    RET
imprimirLinea:
    CALL encenderPixel
    INC CX
    CMP CX, 420d
    JL imprimirLinea
    MOV CX, 320d
    RET


iniciarModoVideo:
    MOV AH, 00h
    MOV AL, 12h
    INT 10h
    RET

;@param
; DX FILA
; CX COLUMNA
encenderPixel:
    MOV AH, 0Ch
    MOV AL, 07h
    MOV BH, 00h
    INT 10h
    RET