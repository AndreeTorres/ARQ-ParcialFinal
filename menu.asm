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
    CALL ImprimirLetra
    RET



; SUBRUTINA: Esperar tecla (Enter o S)

EsperarEnterOSalir:
.espera:
    CALL LeerTecla
    CMP AL, 0Dh      ; Enter
    JE .retorna
    CMP AL, 'S'
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
