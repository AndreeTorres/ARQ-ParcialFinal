org 100h

main:

    CALL modoVideo
    CALL setup
    CALL dibujarTrianguloL
    CALL setup
    CALL dibujarTrianguloR

    int 20h

dibujarTrianguloL:
    CALL dibujarLineaL
    CALL siguienteLinea
    DEC SI
    CMP DX, 150
    JB dibujarTrianguloL
    RET

dibujarTrianguloR:
    CALL dibujarLineaR
    CALL siguienteLinea
    INC SI
    CMP DX, 150
    JB dibujarTrianguloR
    RET


dibujarLineaL:
    CALL encenderPixel
    DEC CX ;Maneja la coordenadas en X
    CMP CX, SI
    JAE dibujarLineaL
    RET

dibujarLineaR:
    CALL encenderPixel
    INC CX 
    CMP CX, SI
    JBE dibujarLineaR
    RET   

siguienteLinea:
    MOV CX, 100
    ADD DX, 1
    RET

setup:
    MOV CX, 100
    MOV DX, 100
    MOV SI, 100 
    RET

modoVideo:
    MOV AH, 00h
    MOV AL, 12h
    INT 10h
    RET

encenderPixel:
    MOV AH, 0Ch       
    MOV AL, 02h       
    MOV BH, 00h    
    INT 10h
    RET