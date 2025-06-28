ORG 100h

SECTION .text
main:
    CALL iniciarModoVideo
    ; Inicializamos la posición base del triángulo
    MOV DX, 100       ; Y inicial (fila)
    MOV CX, 100       ; X inicial (columna)

    MOV SI, 1         ; Ancho de la línea (base creciente)

dibujarTriangulo:
    MOV DI, 0         ; Contador de píxeles por línea

dibujarLinea:
    CALL encenderPixel
    INC CX            ; Incrementar columna
    INC DI            ; Incrementar píxel en la línea
    CMP DI, SI        ; Comparar píxeles dibujados con el ancho de la línea
    JL dibujarLinea   ; Dibujar más píxeles si no se ha alcanzado el ancho

    ; Preparar la siguiente línea
    INC DX            ; Bajar una fila
    INC SI            ; Aumentar el ancho de la base
    CMP DX, 250       ; Altura del triángulo (de 100 a 250)
    JL dibujarTriangulo

    INT 20h           ; Terminar el programa

iniciarModoVideo:
    MOV AH, 00h       ; Función para cambiar modo de video
    MOV AL, 12h       ; Modo gráfico 640x480 con 16 colores
    INT 10h           ; Interrupción para cambiar modo de video
    RET

encenderPixel:
    MOV AH, 0Ch       ; Función para encender un píxel
    MOV AL, 04h       ; Color rojo (04h)
    MOV BH, 00h       ; Página de video (normalmente 0)
    INT 10h           ; Interrupción para dibujar el píxel
    RET

; Colores en modo gráfico (16 colores):
; 00h - Negro
; 01h - Azul
; 02h - Verde
; 03h - Cian
; 04h - Rojo
; 05h - Magenta
; 06h - Marrón
; 07h - Gris claro
; 08h - Gris oscuro
; 09h - Azul claro
; 0Ah - Verde claro
; 0Bh - Cian claro
; 0Ch - Rojo claro
; 0Dh - Magenta claro
; 0Eh - Amarillo
; 0Fh - Blanco

; Explicación de registros en modo gráfico:
; AH: Código de función para la interrupción (define la acción, como cambiar modo o dibujar píxel)
; AL: Parámetro de la función (define el modo gráfico o el color del píxel)
; BH: Página de video (permite seleccionar la página activa en memoria de video)
; DX: Representa la posición vertical (fila) en la pantalla
; CX: Representa la posición horizontal (columna) en la pantalla