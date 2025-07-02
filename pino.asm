ORG 100h

SECTION .data
    msg1    db "1. Para ver figura$"
    msg2    db "2. Para Salir$"
    msg3    db "S. Para regresar$"
    msgFin  db "Fin del programa$"
    msgFinal db "Final FInalisimo$"

SECTION .text

main:
    CALL menu1
    JMP main

; ------------------ MENÚ PRINCIPAL -------------------
menu1:
    CALL IniciarModoTexto

    ; Línea 1
    MOV DH, 10d
    MOV DL, 27d
    CALL CentrarCursor
    MOV DX, msg1
    CALL Imprimir

    ; Línea 2
    MOV DH, 11d
    MOV DL, 27d
    CALL CentrarCursor
    MOV DX, msg2
    CALL Imprimir

    ; Línea 3
    MOV DH, 12d
    MOV DL, 27d
    CALL CentrarCursor
    MOV DX, msg3
    CALL Imprimir

    CALL LeerOpcionMenu

    CMP AL, '1'
    JE  irFigura
    CMP AL, '2'
    JE  menuFin
    JMP menu1


; ------------------ FIGURA (RECTÁNGULO) -------------------

irFigura:
    CALL IniciarModoVideo
    CALL DibujarPino

esperarFigura:
    CALL LeerTecla
    CMP AL, 's'
    JE main
    CMP AL, 13      ; Enter
    JE menuFin
    JMP esperarFigura

; ------------------ PANTALLA FIN DEL PROGRAMA -------------------
menuFin:
    CALL IniciarModoTexto
    MOV DH, 12d
    MOV DL, 30d
    CALL CentrarCursor
    MOV DX, msgFin
    CALL Imprimir
    INT 20h

; ------------------ FUNCIONES -------------------

LeerOpcionMenu:
    MOV AH, 00h
    INT 16h
    RET

LeerTecla:
    MOV AH, 00h
    INT 16h
    RET

IniciarModoTexto:
    MOV AH, 00h
    MOV AL, 03h
    INT 10h
    RET

CentrarCursor:
    MOV AH, 02h
    INT 10h
    RET

Imprimir:
    MOV AH, 09h
    INT 21h
    RET

IniciarModoVideo:
    MOV AH, 0h
    MOV AL, 12h
    INT 10h
    RET


; Dibuja un pino: dos triángulos y un tronco
DibujarPino:
    CALL PinoTrianguloSuperior
    CALL PinoTrianguloInferior
    CALL PinoTronco
    RET

; Triángulo superior – apex (319, 60), termina en y=110
PinoTrianguloSuperior:
    MOV CX, 319        ; columna apex (centro)
    MOV DX, 60         ; fila apex
    MOV AL, 0Ah        ; verde claro
    MOV BH, 0
    MOV AH, 0Ch
    MOV SI, 1
    MOV DI, 1
    INT 10h            ; dibuja pixel apex

FilaSuperior:
    INT 10h
    DEC SI
    JZ SiguienteFilaSuperior
    INC CX
    JMP FilaSuperior

SiguienteFilaSuperior:
    CMP DX, 110
    JZ  FinAlto
    MOV CX, 319
    SUB CX, DI
    INC DX
    INC DI
    MOV SI, DI
    ADD SI, SI
    JMP FilaSuperior

FinAlto:
    RET

; Triángulo inferior – apex (319, 120), termina en y=220
PinoTrianguloInferior:
    MOV CX, 319
    MOV DX, 120
    MOV AL, 0Ah
    MOV BH, 0
    MOV AH, 0Ch
    MOV SI, 1
    MOV DI, 1
    INT 10h
DibujarFilaInferior:
    INT 10h
    DEC SI
    JZ SiguienteFilaInferior
    INC CX
    JMP DibujarFilaInferior
SiguienteFilaInferior:
    CMP DX, 220
    JZ FinInferior
    MOV CX, 319
    SUB CX, DI
    INC DX
    INC DI
    MOV SI, DI
    ADD SI, SI
    JMP DibujarFilaInferior
FinInferior:
    RET

; Tronco – rectángulo columnas 299..339, filas 220..280
PinoTronco:
    MOV CX, 299        ; columna izquierda
    MOV DX, 220        ; fila superior
    MOV AL, 6          ; marrón
    MOV BH, 0
    MOV AH, 0Ch
    MOV DI, 40         ; ancho 40 columnas
    MOV SI, 60         ; alto  60 filas
DibujarFilaTronco:
    MOV BP, DI
DibujarPixelTronco:
    INT 10h
    INC CX
    DEC BP
    JNZ DibujarPixelTronco
    SUB CX, DI         ; regresa a columna izquierda
    INC DX
    DEC SI
    JNZ DibujarFilaTronco
    RET