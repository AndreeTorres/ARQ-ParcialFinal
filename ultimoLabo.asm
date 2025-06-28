ORG 100h

SECTION .text
   MOV CX, 90d     ; Columna inicial
   MOV DX, 90d     ; Fila inicial
   MOV BP, 90d     ; Contador de filas


main:
   CALL IniciarModoVideo
   CALL DibujarTriangulo
   INT 20h


IniciarModoVideo:
   MOV AH, 0h
   MOV AL, 12h      ; Modo gráfico 640x480, 16 colores
   INT 10h
   RET


DibujarTriangulo:
   CALL encenderPixel
   INC DX                ; Incrementa la columna
   CMP DX, 190d          ; Hasta la columna que quiero llegar
   JL DibujarTriangulo   ; Si no, seguir dibujando píxeles en esta fila


   ; Al llegar al final de la fila, preparar siguiente fila
   INC CX
   INC BP                ; Incrementar contador de filas
   MOV DX, BP            ; Avanzar una fila (Y)
   CMP CX, 190d         
   JL DibujarTriangulo   ; Si no, seguir con la siguiente fila
   RET                   ; Termina cuando se dibujó todo


encenderPixel:
   MOV AH, 0Ch           ; Función del BIOS para poner un píxel
   MOV AL, 04h           ; Color rojo
   MOV BH, 0             ; Página de video 0
   INT 10h               ; Enciende el píxel
   RET


