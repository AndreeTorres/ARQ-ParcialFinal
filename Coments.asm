ORG 100h


SECTION .text
   XOR AX,AX
   XOR BX,BX
   XOR CX,CX
   XOR DX,DX


   ; Posición inicial
   MOV DX, 90d    ; Columnas
   MOV CX, 90d     ; Filas
   MOV BP, 90d     ; Contador de filas


main:
   CALL iniciarModoVideo
   CALL dibujarTriangulo
  
   INT 20h   






dibujarTriangulo:
   ; Dibujar Columnas
   CALL encenderPixel
   INC DX
   CMP DX, 190d
   JNE dibujarTriangulo


   ; Dibujar en filas 
   INC CX ; Incrementamos fila
   INC BP ; Incrementamos contador para luego colocar de manera dinamica a columnas
   MOV DX,BP ; Ajustamos columna al valor actual de fila para colorear bien
   CMP CX, 190d
   JNE dibujarTriangulo
   RET




iniciarModoVideo:
   MOV AH, 0h
   MOV AL, 12h     ; 640x480, 16 colores
   INT 10h
   RET


encenderPixel:
   MOV AH, 0Ch           ; Función del BIOS para poner un píxel
   MOV AL, 01h           ; Color del píxel (rojo)
   MOV BH, 0             ; Página de video 0
   INT 10h               ; Enciende el píxel
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
