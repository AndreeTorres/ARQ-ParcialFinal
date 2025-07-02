main:
    CALL modoVideo
    CALL setupCuadrado
    CALL dibujarCuadrado

    CALL setupTriangulo1
    CALL dibujarTrianguloL1
    CALL setupTriangulo1
    CALL dibujarTrianguloR1

    CALL setupTriangulo2
    CALL dibujarTrianguloL2
    CALL setupTriangulo2
    CALL dibujarTrianguloR2

    CALL setupTriangulo3
    CALL dibujarTrianguloL3
    CALL setupTriangulo3
    CALL dibujarTrianguloR3

    CALL setupCuadrado2
    CALL dibujarCuadrado2

    CALL setupCuadrado3
    CALL dibujarCuadrado3


    INT 20h

setupCuadrado:
    MOV CX, 100
    MOV DX, 75
    RET

setupCuadrado2:   
    MOV CX, 115
    MOV DX, 100
    RET   

setupCuadrado3:   
    MOV CX, 160
    MOV DX, 100
    RET      

setupTriangulo1:
    MOV CX, 125
    MOV DX, 50
    MOV SI, 125 
    RET  

setupTriangulo2:
    MOV CX, 175
    MOV DX, 50
    MOV SI, 175 
    RET

setupTriangulo3:
    MOV CX, 150
    MOV DX, 150
    MOV SI, 150 
    RET        

dibujarCuadrado:
    CALL dibujarLineaC
    MOV CX, 100  
    CALL siguienteLinea
    CMP DX, 175
    JBE dibujarCuadrado
    RET

dibujarCuadrado2:
    CALL dibujarLineaC2
    MOV CX, 115  
    CALL siguienteLinea
    CMP DX, 110
    JBE dibujarCuadrado2
    RET  

dibujarCuadrado3:
    CALL dibujarLineaC3
    MOV CX, 160  
    CALL siguienteLinea
    CMP DX, 110
    JBE dibujarCuadrado3
    RET       


dibujarTrianguloL1:
    CALL dibujarLineaL
    MOV CX, 125
    CALL siguienteLinea
    dec SI
    CMP DX, 75
    JB dibujarTrianguloL1
    RET 

dibujarTrianguloR1:
    CALL dibujarLineaR
    MOV CX, 125
    CALL siguienteLinea
    inc SI
    CMP DX, 75
    JB dibujarTrianguloR1
    RET   

dibujarTrianguloL2:
    CALL dibujarLineaL
    MOV CX, 175
    CALL siguienteLinea
    dec SI
    CMP DX, 75
    JB dibujarTrianguloL2
    RET 

dibujarTrianguloR2:
    CALL dibujarLineaR
    MOV CX, 175
    CALL siguienteLinea
    inc SI
    CMP DX, 75
    JB dibujarTrianguloR2
    RET   


dibujarTrianguloL3:
    CALL dibujarLineaL
    MOV CX, 150
    CALL siguienteLineaInvertida
    dec SI
    CMP DX, 125
    JA dibujarTrianguloL3
    RET 

dibujarTrianguloR3:
    CALL dibujarLineaR
    MOV CX, 150
    CALL siguienteLineaInvertida
    inc SI
    CMP DX, 125
    JA dibujarTrianguloR3
    RET        

modoVideo:
    MOV AH, 00h
    MOV AL, 12h
    INT 10h
    RET

encenderPixel:
    MOV AH, 0Ch             
    MOV BH, 00h    
    INT 10h
    RET

dibujarLineaC:
    MOV AL, 09h 
    CALL encenderPixel
    INC CX
    CMP CX, 200
    JBE dibujarLineaC
    RET  

dibujarLineaC2:
    MOV AL, 01h 
    CALL encenderPixel
    INC CX
    CMP CX, 125
    JBE dibujarLineaC2
    RET   

dibujarLineaC3:
    MOV AL, 01h 
    CALL encenderPixel
    INC CX
    CMP CX, 170
    JBE dibujarLineaC3
    RET         

dibujarLineaL:
    MOV AL, 09h 
    CALL encenderPixel
    DEC CX 
    CMP CX, SI
    JAE dibujarLineaL
    RET

dibujarLineaR:
    MOV AL, 0Bh 
    CALL encenderPixel
    INC CX
    CMP CX, SI
    JBE dibujarLineaR
    RET  

siguienteLinea:
    INC DX
    RET

siguienteLineaInvertida:
    DEC DX
    RET
