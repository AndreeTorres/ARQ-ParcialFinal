ORG 100h

main:
    ; Establecer modo de video texto a color 80x25
    MOV AH, 00h
    MOV AL, 03h
    INT 10h

Menu:
    CALL LeerTecla

    ; Comparar con 'S' o 's' para salir
    CMP AL, 'S'
    JE end
    CMP AL, 's'
    JE end

    ; Comparar con '1'
    CMP AL, '1'
    JE Pagina1

    ; Comparar con '2'
    CMP AL, '2'
    JE Pagina2

    ; Comparar con '3'
    CMP AL, '3'
    JE Pagina3

    JMP Menu  ; si tecla inválida, vuelve al menú



; SUBRUTINA: Leer una tecla

LeerTecla:
    MOV AH, 00h
    INT 16h
    RET


; SUBRUTINAS: PÁGINAS 1, 2 y 3


Pagina1:
    CALL ActivarPagina1
    CALL EsperarEnterOSalir
    JMP Menu

Pagina2:
    CALL ActivarPagina2
    CALL EsperarEnterOSalir
    JMP Menu

Pagina3:
    CALL ActivarPagina3
    CALL EsperarEnterOSalir
    JMP Menu

ActivarPagina1:
    MOV AH, 05h
    MOV AL, 01h  ;  pag1
    INT 10h
    CALL ImprimirLetra
    RET

ActivarPagina2:
    MOV AH, 05h
    MOV AL, 02h  ; pag2
    INT 10h
    CALL ImprimirLetra
    RET

ActivarPagina3:
    MOV AH, 05h
    MOV AL, 03h  ; Pag 3
    INT 10h
    ; ; dibujar triángulo superior (más pequeño)
    ; CALL setupTR1
    ; CALL dibujarTrianguloL
    ; CALL setupTR1
    ; CALL dibujarTrianguloR
    
    ; ; dibujar triángulo meDIo
    ; CALL setupTR2
    ; CALL dibujarTrianguloL
    ; CALL setupTR2
    ; CALL dibujarTrianguloR
    
    ; ; dibujar triángulo inferior (más grande)
    ; CALL setupTR3
    ; CALL dibujarTrianguloL
    ; CALL setupTR3
    ; CALL dibujarTrianguloR
    
    ; ; dibujar tronco
    ; CALL dibujarTronco
    CALL dibujarGato
    RET



; SUBRUTINA: Esperar tecla (Enter o S)

EsperarEnterOSalir:
.espera:
    CALL LeerTecla
    CMP AL, 0Dh      ; Enter
    JE .retorna
    CMP AL, 'S'
    CMP AL, 's'
    JE end
    JMP .espera
.retorna:
    RET


; SUBRUTINA: Imprimir Letra A

ImprimirLetra:
    MOV AH, 0Eh
    MOV AL, 'A'
    MOV BH, 00h
    MOV BL, 0Ah
    INT 10h
    RET


; FINALIZAR PROGRAMA

end:
    INT 20h

dibujarTrianguloL:
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
encenderPixelP3:
    MOV AH, 0Ch       
    MOV AL, 02h    ;color verde
    MOV BH, 03h    ;pagina
    INT 10h
    RET

;Enciende el pixel en la coordenada (CX, DX) - Marrón para el tronco
encenderPixelTronco:
    MOV AH, 0Ch       
    MOV AL, 06h    ;color marrón
    MOV BH, 03h    ;pagina
    INT 10h
    RET

dibujarLineaL:
    CALL encenderPixelP3
    DEC CX ;maneja coordenada x derecha
    CMP CX, SI
    JAE dibujarLineaL
    RET

dibujarLineaR:
    CALL encenderPixelP3
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

dibujarGato:
    ; Dibuja la cabeza del gato
    MOV CX, 140     ; x inicial de la cabeza
    MOV DX, 50      ; y inicial de la cabeza
    
dibujarCabezaLoop:
    MOV DI, CX      ; guardar CX inicial
    MOV BP, 20      ; ancho de la cabeza
    
dibujarLineaCabeza:
    CALL encenderPixelP3
    INC CX
    DEC BP
    CMP BP, 0
    JNE dibujarLineaCabeza
    
    MOV CX, DI      ; restaurar CX
    INC DX          ; siguiente línea
    CMP DX, 70      ; altura de la cabeza
    JB dibujarCabezaLoop

    ; Dibuja las orejas del gato
    MOV CX, 130     ; x inicial de la oreja izquierda
    MOV DX, 40      ; y inicial de la oreja izquierda
    CALL dibujarTrianguloL

    MOV CX, 150     ; x inicial de la oreja derecha
    MOV DX, 40      ; y inicial de la oreja derecha
    CALL dibujarTrianguloR

    ; Dibuja el cuerpo del gato
    MOV CX, 140     ; x inicial del cuerpo
    MOV DX, 70      ; y inicial del cuerpo
    
dibujarCuerpoLoop:
    MOV DI, CX      ; guardar CX inicial
    MOV BP, 30      ; ancho del cuerpo
    
dibujarLineaCuerpo:
    CALL encenderPixelP3
    INC CX
    DEC BP
    CMP BP, 0
    JNE dibujarLineaCuerpo
    
    MOV CX, DI      ; restaurar CX
    INC DX          ; siguiente línea
    CMP DX, 100     ; altura del cuerpo
    JB dibujarCuerpoLoop

    RET
