org 100h

section .data
    color db 20h, 31h, 42h, 53h, 41h ;Arreglo de colores

section .text
    xor si, si             ; índice a color/posición = 0
    call establecerModoTexto
    mov dl, 35d            ; Establece la columna inicial para el cursor

;funcion principal
print:
    call posCursor 
 
    call lecturaTeclado 

    cmp al, 08h            ; ¿Backspace?
    je .backspace          ;Si se presiono backspace salta a esa subrutina

    call escrituraPantalla
    inc dl                 ; siguiente columna
    inc si                 ; siguiente color/índice
    cmp al,13              ; comparar con Enter y saltar si es Enter 

    je fin                 ; si es Enter, terminar
    jmp print              ;loopear si no

.backspace:
    cmp si, 0              ; ¿estamos en el inicio?
    je print               ; nada que borrar

    dec dl                 ; retrocede columna
    dec si                 ; retrocede índice
    call posCursor         ;posiciona el cursor atras 


    mov al, ' '            ; carácter espacio
    CALL escrituraPantalla

    jmp print

fin:
    int 20h

; — Rutinas de soporte —

establecerModoTexto:
    mov ah, 00h ;Funcion para activar el modo texto
    mov al, 03h ;Modo texto especifico 
    int 10h ;interrupcion BIOS
    ret

posCursor:
    mov ah, 02h ;funcion para posicionar el cursor
    mov bh, 00h ;pagina del cursor
    mov dh, 0Ah ;fila fija
    int 10h ;interrupcion
    ret

lecturaTeclado:
    MOV AH, 00h    ;Lee caracter desde teclado AH ScanCode AL ASCII
    INT 16h         ;interrupcion
    RET

escrituraPantalla:
    mov ah, 09h ;Funcion para escribir            
    mov bh, 00h ;Pagina 
    mov bl, [color+si] ;Atributo de color
    mov cx, 1   ;repeticion
    int 10h     ;interrupcion
    RET