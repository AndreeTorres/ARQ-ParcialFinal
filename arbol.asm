ORG 100h

main:
    CALL modoVideo
    
    ; dibujar triángulo superior (más pequeño)
    CALL setupTR1
    CALL dibujarTrianguloL
    CALL setupTR1
    CALL dibujarTrianguloR
    
    ; dibujar triángulo meDIo
    CALL setupTR2
    CALL dibujarTrianguloL
    CALL setupTR2
    CALL dibujarTrianguloR
    
    ; dibujar triángulo inferior (más grande)
    CALL setupTR3
    CALL dibujarTrianguloL
    CALL setupTR3
    CALL dibujarTrianguloR
    
    ; dibujar tronco
    CALL dibujarTronco

    int 20h

dibujarTrianguloL:
    CALL dibujarLineaL
    CALL siguienteLinea
    DEC SI
    CMP DX, BX
    JB dibujarTrianguloL
    RET

dibujarTrianguloR:
    CALL dibujarLineaR
    CALL siguienteLinea
    INC SI
    CMP DX, BX
    JB dibujarTrianguloR
    RET

; Setup para triángulo superior (pequeño)
setupTR1:
    MOV CX, 160     ; centro x
    MOV DX, 50      ; y inicial
    MOV SI, 160     ; punto central
    MOV BX, 80      ; límite y
    RET

; Setup para triángulo meDIo
setupTR2:
    MOV CX, 160     ; centro x  
    MOV DX, 70      ; y inicial
    MOV SI, 160     ; punto central
    MOV BX, 110     ; límite y
    RET

; Setup para triángulo inferior (grande)
setupTR3:
    MOV CX, 160     ; centro x
    MOV DX, 100     ; y inicial
    MOV SI, 160     ; punto central  
    MOV BX, 150     ; límite y
    RET

setup:
    MOV CX, 100 ;x
    MOV DX, 100 ;y
    MOV SI, 100 
    RET

modoVideo:
    MOV AH, 00h
    MOV AL, 12h
    INT 10h
    RET

;Enciende el pixel en la coordenada (CX, DX) - Verde para el árbol
encenderPixel:
    MOV AH, 0Ch       
    MOV AL, 02h    ;color verde
    MOV BH, 00h    ;pagina
    INT 10h
    RET

;Enciende el pixel en la coordenada (CX, DX) - Marrón para el tronco
encenderPixelTronco:
    MOV AH, 0Ch       
    MOV AL, 06h    ;color marrón
    MOV BH, 00h    ;pagina
    INT 10h
    RET

dibujarLineaL:
    CALL encenderPixel
    DEC CX ;maneja coordenada x derecha
    CMP CX, SI
    JAE dibujarLineaL
    RET

dibujarLineaR:
    CALL encenderPixel
    INC CX ;maneja coordenada x izquierda
    CMP CX, SI
    JBE dibujarLineaR
    RET   

siguienteLinea:
    MOV CX, 160    ; vuelve al centro
    ADD DX, 1
    RET

; Función para dibujar el tronco
dibujarTronco:
    MOV CX, 150     ; x inicial del tronco
    MOV DX, 150     ; y inicial del tronco
    
dibujarTroncoLoop:
    MOV DI, CX      ; guardar CX inicial
    MOV BP, 20      ; ancho del tronco
    
dibujarLineaTronco:
    CALL encenderPixelTronco
    INC CX
    DEC BP
    CMP BP, 0
    JNE dibujarLineaTronco
    
    MOV CX, DI      ; restaurar CX
    INC DX          ; SIguiente línea
    CMP DX, 170     ; altura del tronco
    JB dibujarTroncoLoop
    RET
