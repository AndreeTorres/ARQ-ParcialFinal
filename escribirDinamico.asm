org 100h
;Variables
section .data
    ;Cadena
    nombre db "Andree$" 
    ;Array de colores
    ; 20 -> Fondo verde letra negra
    ; 31 -> Fondo cyan letra azul
    ; 42 -> Fondo rojo letra verde
    ; 43 -> Fondo rojo letra cyan
    ; 40 -> Fondo rojo letra negra
    ; 55 -> Fondo magenta letra magenta
    ; 66 -> Fondo amarillo letra amarilla
    ; 77 -> Fondo blanco letra blanca
    color db 20h,31h,42h,43h,40h,55h,66h,77h

section .text
    ;Carga la direccion de la variable nombre en bp
    ;Esto es importante para poder acceder a los caracteres de la cadena
    mov bp, nombre 

    ;Establece el modo texto
    CALL establecerModoTexto

    ;Establece la posicion del cursor en la columna 35
    mov dl, 35d

print:
    ;Posiciona el cursor
    CALL posCursor

    ;Guarda en AL cada caracter de la cadena
    mov al, [bp+Si]

    ;Guarda en BL cada color correspondiente al arreglo de colores
    mov bl,[color+si]

    ;Llamada a la funcion de escribir
    ;Ya se definio arriba el caracter a imprimir en AL
    ;Y su atributo en BL
    CALL escribir

    ;Incrementa la columna, pasa a la siguiente
    inc dl

    ;Incremenmta el indice para pasar al siguiente caracter y atributo de colores
    inc si

    cmp al, '$'

    JNE print

fin:
    int 20h            ; Terminar el programa

establecerModoTexto:
    mov ah, 00h
    mov al, 03h
    int 10h
    ret

escribir:
    mov ah, 09h ;Funcion para la escritura de un caracter con su atributo
    mov bh, 00h ;Pagina 0
    mov cx, 01h ; Repeticion, solo una vez
    int 10h ;Interrupcion
    ret

posCursor:
    mov ah, 02h ;Funcion para mover el cursor
    mov bh, 00h ;Numero de pagina (en este caso 0)
    mov dh, 0Ah ;Fila 10 (No va a cambiar porque es todo en la misma linea)
    int 10h ;Ejecuta la interrupcion
    ret 
    