ORG 100h

SECTION .data
    msg1 db "1. Para ver figura$"
    msg2 db "2. Para Salir$"
    msg3 db "S. Para regresar$"
    msgFin db 'Fin del programa$'

SECTION .text

    XOR AX, AX
    XOR BX, BX
    XOR CX, CX
    XOR DX, DX

main:
    CALL mainMenu
    CALL menuFinal

mainMenu:
    CALL modoTexto

    MOV BH, 0d ; Página 0

    ; Línea 1
    MOV DH, 10d  ; Fila
    MOV DL, 27d  ; Columna
    CALL centrarCursor
    MOV DX, msg1
    CALL print

    ; Línea 2
    MOV DH, 11d
    MOV DL, 27d
    CALL centrarCursor
    MOV DX, msg2
    CALL print

    ; Línea 3
    MOV DH, 12d
    MOV DL, 27d
    CALL centrarCursor
    MOV DX, msg3
    CALL print

    CALL esperarTecla

    CMP AL, '1'
    JE irFigura
    CMP AL, '2'
    JE menuFinal
    JMP mainMenu

irFigura:
    CALL menu2
    RET

menu2:
    MOV SI, 200d            ; Inicializa SI → columna inicial del rectángulo
    MOV DI, 150d             ; Inicializa DI → fila inicial del rectángulo
    CALL IniciarModoVideo
    CALL DibujarOrejaIzquierda
    CALL DibujarOrejaDerecha
    CALL DibujarRectangulo
    CALL DibujarOjoIzquierdo
    CALL DibujarOjoDerecho
    CALL DibujarBoca
    CALL DibujarBigoteSupIz
    CALL DibujarBigoteInfIz
    CALL DibujarBigoteSupDer
    CALL DibujarBigoteInfDer

esperarFigura:
    CALL LeerTecla
    CMP AL, 's'
    JE main
    CMP AL, 13      ; Enter
    JE menuFinal
    JMP esperarFigura

menuFinal:
    CALL modoTexto
    MOV DH, 12d
    MOV DL, 30d
    CALL centrarCursor
    MOV DX, msgFin
    CALL print
    INT 20h


; ------------------ FUNCIONES -------------------

esperarTecla:
    MOV AH, 00h
    INT 16h
    RET

LeerTecla:
    MOV AH, 00h
    INT 16h
    RET

modoTexto:
    MOV AH, 00h
    MOV AL, 03h
    INT 10h
    RET

centrarCursor:
    MOV AH, 02h
    INT 10h
    RET

print:
    MOV AH, 09h
    INT 21h
    RET

CambiarPagina:
    MOV AH, 05h
    MOV AL, 01h
    INT 10h
    RET

IniciarModoVideo:
    MOV AH, 0h
    MOV AL, 12h
    INT 10h
    RET

DibujarOrejaIzquierda:
    MOV DX, 100d      ; fila inicial
    FilaOrejaIzq:
        MOV CX, 200d      ; columna inicial
    ColumnaOrejaIzq:
        MOV AH, 0Ch         ; Función 0Ch: escribir pixel
        MOV AL, 05h         ; Color rojo
        MOV BH, 0           ; Página 0
        INT 10h

        INC CX
        CMP CX, 250d
        JL ColumnaOrejaIzq ; Mientras CX < 250, sigue

        INC DX
        CMP DX, 150d
        JL FilaOrejaIzq    ; Mientras DX < 150, sigue

        RET

DibujarOrejaDerecha:
    MOV DX, 100d      ; fila inicial
    FilaOrejaDer:
        MOV CX, 350d      ; columna inicial
    ColumnaOrejaDer:
        MOV AH, 0Ch       ; Función 0Ch: escribir pixel
        MOV AL, 05h       ; Color rojo
        MOV BH, 0        ; Página 0
        INT 10h

        INC CX
        CMP CX, 400d
        JL ColumnaOrejaDer ; Mientras CX < 250, sigue

        INC DX
        CMP DX, 150d
        JL FilaOrejaDer   ; Mientras DX < 150, sigue

        RET


DibujarRectangulo:
    MOV AH, 0Ch       ; Función 0Ch: escribir pixel
    MOV AL, 0Fh       ; Color 0Fh (15 decimal): blanco
    MOV BH, 0         ; Número de página (0)
    MOV CX, SI       ; CX = columna actual
    MOV DX, DI       ; DX = fila actual
    INT 10h           ; Llama a BIOS para dibujar el pixel en (CX, DX)

    INC SI            ; Incrementa la columna (mueve un pixel a la derecha)
    CMP SI, 400d      ; Compara SI (columna final)
    JNE DibujarRectangulo ; Si aún no se llega al final de la fila, sigue dibujando

    INC DI            ; Incrementa la fila (pasa a la siguiente línea)
    MOV SI, 200d       ; Reinicia columna a SI (columna de inicio siguiente fila)

    CMP DI, 350d      ; Compara DI (fila final)
    JNE DibujarRectangulo ; Si no se ha llegado a la última fila, sigue dibujando

    RET               ; Retorna cuando el rectángulo ya está completo

DibujarOjoIzquierdo:
    MOV DX, 200d      ; fila inicial
    FilaOjoIzq:
        MOV CX, 250d      ; columna inicial
    ColumnaOjoIzq:
        MOV AH, 0Ch       ; Función 0Ch: escribir pixel
        MOV AL, 0h       ; Color negro
        MOV BH, 0         ; Página 0
        INT 10h

        INC CX
        CMP CX, 275d
        JL ColumnaOjoIzq ; Mientras CX < 275, sigue

        INC DX
        CMP DX, 225d
        JL FilaOjoIzq    ; Mientras DX < 140, sigue

        RET

DibujarOjoDerecho:
    MOV DX, 200d      ; fila inicial
    FilaOjoDer:
        MOV CX, 325d      ; columna inicial
    ColumnaOjoDer:
        MOV AH, 0Ch       ; Función 0Ch: escribir pixel
        MOV AL, 0h       ; Color negro
        MOV BH, 0         ; Página 0
        INT 10h

        INC CX
        CMP CX, 350d
        JL ColumnaOjoDer ; Mientras CX < 350, sigue

        INC DX
        CMP DX, 225d
        JL FilaOjoDer    ; Mientras DX < 140, sigue

        RET

DibujarBoca:
    MOV DX, 285d      ; fila inicial
    FilaBoca:
        MOV CX, 275d      ; columna inicial
    ColumnaBoca:
        MOV AH, 0Ch       ; Función 0Ch: escribir pixel
        MOV AL, 0h       ; Color negro
        MOV BH, 0         ; Página 0
        INT 10h

        INC CX
        CMP CX, 325d     ; Compara CX (columna final)
        JL ColumnaBoca ; Mientras CX < 350, sigue

        INC DX
        CMP DX, 300d
        JL FilaBoca    ; Mientras DX < 140, sigue

        RET

DibujarBigoteSupIz:
    MOV DX, 220d      ; fila inicial
    FilaBigSupIz:
        MOV CX, 150d      ; columna inicial
    ColumnaBigSupIz:
        MOV AH, 0Ch       ; Función 0Ch: escribir pixel
        MOV AL, 05h       ; Color blanco
        MOV BH, 0         ; Página 0
        INT 10h

        INC CX
        CMP CX, 200d     ; Compara CX (columna final)
        JL ColumnaBigSupIz ; Mientras CX < 350, sigue

        INC DX
        CMP DX, 230d
        JL FilaBigSupIz    ; Mientras DX < 140, sigue

        RET

DibujarBigoteInfIz:
    MOV DX, 250d      ; fila inicial
    FilaBigInfIz:
        MOV CX, 150d      ; columna inicial
    ColumnaBigInfIz:
        MOV AH, 0Ch       ; Función 0Ch: escribir pixel
        MOV AL, 05h       ; Color blanco
        MOV BH, 0         ; Página 0
        INT 10h

        INC CX
        CMP CX, 200d     ; Compara CX (columna final)
        JL ColumnaBigInfIz ; Mientras CX < 350, sigue

        INC DX
        CMP DX, 260d
        JL FilaBigInfIz    ; Mientras DX < 140, sigue

        RET

DibujarBigoteSupDer:
    MOV DX, 220d      ; fila inicial
    FilaBigSupDer:
        MOV CX, 400d      ; columna inicial
    ColumnaBigSupDer:
        MOV AH, 0Ch       ; Función 0Ch: escribir pixel
        MOV AL, 05h       ; Color blanco
        MOV BH, 0         ; Página 0
        INT 10h

        INC CX
        CMP CX, 450d     ; Compara CX (columna final)
        JL ColumnaBigSupDer ; Mientras CX < 350, sigue

        INC DX
        CMP DX, 230d
        JL FilaBigSupDer    ; Mientras DX < 140, sigue

        RET

DibujarBigoteInfDer:
    MOV DX, 250d      ; fila inicial
    FilaBigInfDer:
        MOV CX, 400d      ; columna inicial
    ColumnaBigInfDer:
        MOV AH, 0Ch       ; Función 0Ch: escribir pixel
        MOV AL, 05h       ; Color blanco
        MOV BH, 0         ; Página 0
        INT 10h

        INC CX
        CMP CX, 450d     ; Compara CX (columna final)
        JL ColumnaBigInfDer ; Mientras CX < 350, sigue

        INC DX
        CMP DX, 260d
        JL FilaBigInfDer    ; Mientras DX < 140, sigue

        RET