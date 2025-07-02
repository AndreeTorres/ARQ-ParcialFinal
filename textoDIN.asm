org 100h

;Declaración de variables
section .data
    ; name db "Carlo$" ;Declracion de cadena
    color db 20h, 31h, 42h, 53h, 41h ;Arreglo de colores

section .text
    ;mov bp, name;
    call establecerModoTexto;

    ;Coloca la columna del cursor
    mov dl, 35d 

print: 
    call posCursor ;Posiciona correctamente el cursor

    call escribirTecla ;Espera tecla

    mov bl, [color+si] ;almacena en bl el primer elemento del arreglo de colores
    ;en este caso es fondo verde con letra negra

    call escribir ;escribe en pantalla

    inc dl ;Se mueve de columna 
    inc si ;aumenta el indice para mover el atributo de color

    cmp al,13 ; Comprobar si la tecla es Enter

    je fin ; Si es igual termina el programa


    jmp print ;De lo contrario hace bucle


fin:
    int 20h

establecerModoTexto:
    mov ah, 00h ;Establece le modo texto
    mov al, 03h ;Modo especifico de tetxo (80x25)
    int 10h     ;interrupcion de la BIOS
    ret

;Esta funcion escribe lo que esta almacenado en AL
;Con el atributo de color que este almacenado en BL
escribir:
    mov ah, 09h ;Funcion para escribir un caracter co atributo
    mov bh, 00h ;Numero de pagina
    mov cx, 01h ;Cantidad de veces a repetir
    int 10h     ;interrupcion 
    ret

posCursor:
    mov ah, 02h ;Funcion para mover el cursor
    mov bh, 00h ;Pagina del cursor
    mov dh, 0Ah ;Fila del cursor
    int 10h ;Interrupcion de la BIOS
    ret


escribirTecla:
    MOV AH, 00h ;Funcion para hacer la escritura de texto desde teclado
    int 16h ;Interrupcion del teclado 
    ;Almacena en AH el ScanCode y en AL el ASCII
    ret