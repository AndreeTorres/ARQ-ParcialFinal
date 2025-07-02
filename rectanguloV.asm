ORG 100h
SECTION .text

setup:
    XOR AX,AX
    XOR BX,BX
    XOR CX,CX
    XOR DX,DX

    MOV SI, 90d
    MOV DI, 70D
    

main:

    CALL IniciarModoVideo
    CALL DibujarRectangulo
    CALL EsperarTecla
    INT 20h

IniciarModoVideo:
    MOV AH, 00h
    MOV AL, 12h
    INT 10H ; 640X480; 16 Colores
    RET

DibujarRectangulo:
    MOV AH, 0CH
    MOV AL, 4d
    MOV BH, 0
    MOV CX, SI ; Columnas
    MOV DX, DI
    INT 10H 
    ;Incrementar columna
    INC SI
    CMP SI, 120D
    JNE DibujarRectangulo

    INC DI ; Incremento fila
    MOV SI, 90d ;Reinicio columna
    CMP DI, 190d
    JNE DibujarRectangulo
    RET

EsperarTecla:
    MOV AH,00h
    INT 16h
    RET
    
