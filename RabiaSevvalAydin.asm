; Standard header:
    #make_COM#
    ORG  100H

; Set video mode:
    MOV AH, 00h
    MOV AL, 03h
    INT 10h

; Load address of message to DX register:
    LEA DX, msg

; Print using DOS interrupt:
    MOV AH, 9
    INT 21h

; Wait for Enter key press:
    MOV AH, 0
    INT 16h
    
; Initialize position of FLOOR
    MOV DL, 0
    MOV DH, 11
    MOV AH, 02h
    INT 10h
    MOV AL, 0B8H
    MOV AH, 09H
    MOV BL, 0EH ;rengi de�i�tiriyor-bit color table
    MOV CX, 60
    INT 10h 	;-;
    MOV DL, 0
    MOV DH, 12
    MOV AH, 02h
    INT 10h
    MOV AL, 176
    MOV AH, 09H
    MOV BL, 0EH 
    MOV CX, 60
    INT 10h	;-;
    
; Initialize position of *
    MOV DL, 3
    MOV DH, 10
    MOV AH, 02h
    INT 10h
    MOV AL, '*'
    MOV AH, 09H
    MOV BL, 0CH ;rengi de�i�tiriyor-bit color table
    MOV CX, 1
    INT 10h 	;-;
; Initialize position of <
    MOV DL, 55
    MOV DH, 10
    MOV AH, 02h
    INT 10h
    MOV AL, '<'
    MOV AH, 09H
    MOV BL, 0CH ;rengi de�i�tiriyor-bit color table
    MOV CX, 1
    INT 10h 	;-;
    

; Main loop:
mov bp, dx

GAME_LOOP:
;Check if up arrow key is pressed:
;HEBELE

CMP CH, 01H	;CH O1 DE��L �SE ENGEL �LERLET-EN BA�TA 00 
jnz engel_ilerlet
MOV AH, 01H
INT 16h
CMP AH, 48H	;CH 48 �SE KARAKTER YUKARI G�DER, DE��L �SE ENGEL �LERLEMES�NE GE��L�R
JNE engel_ilerlet
mov AH, 0H	;Buffer temizleme
;MOV AH, 10H
INT 16H

;KARAKTER_Z�PLA
karakter_zipla:
mov ch, 00h
mov SI,0001
MOV DH,10
MOV DL,3
;2�er atlas�n/insin
yukari:
MOV AL, ' ' 
MOV AH, 09H
MOV BL, 0CH
MOV CX, 1
INT 10H
MOV AH, 02H,
INT 10H
DEC DH
MOV AL, '*'
MOV AH, 09H
MOV BL, 0CH
MOV CX, 1
INT 10H
INC SI
CMP SI,4
JNZ yukari
;_;
;_;
asagi:
MOV AL, '*'
MOV AH, 09H
MOV BL, 0CH
MOV CX, 1
INT 10H
MOV AL, ' ' 
MOV AH, 09H
MOV BL, 0CH
MOV CX, 1
INT 10H
MOV AH, 02H,
INT 10H
INC DH
DEC SI
CMP SI,0
JNZ asagi
MOV AL, '*'
MOV AH, 09H
MOV BL, 0CH
MOV CX, 1
INT 10H
;_;-2 A�A�I 2 YUKARI

;Move the obstacle
engel_ilerlet:
;MOV DH, BP
;MOV DL, SI
MOV DX, BP
MOV AH, 02H
INT 10h
MOV AL, '<'
MOV AH, 09H
MOV BL, 0CH ;rengi de�i�tiriyor-bit color table
MOV CX, 1
INT 10h
eskisini_yok_et:
MOV AL, ' '
MOV AH, 09H
MOV BL, 0EH
MOV CX, 1
INT 10H

DEC DL
MOV BP,DX
MOV CH, 01H
;DEC SI
CMP DL, 3 ;ENGEL KARAKTERE ULA�MI� MI?
JE yok_et_engel
JMP GAME_LOOP
;JMP engel_ilerlet

yok_et_engel:
MOV AL, ' '
MOV AH, 09H
MOV BL, 0EH
MOV CX, 1
INT 10H

yenisini_yola:
;MOV SI, 55
;MOV BP, 10
;MOV BP, 1055H
MOV DH,10
MOV DL,55
MOV BP,DX



    

    ; Jump back to the main loop
    JMP GAME_LOOP

; Data:
;msg DB 'Yukar� tu�una basarak y�ld�z� hareket ettirin.', 13, 10, '$'
msg DB '| =======ENGEL ATLAMA OYUNU=======', 13, 10, 
    DB '| �zerinize gelen engeller yukar�', 13, 10, 
    DB '| tu�una basarak ka�maya �al���n.', 13, 10, 
    DB '| Oyuna ba�lamak i�in enter tu�una', 13, 10, 
    DB '| bas�n.', 13, 10, 
    DB '| Bol �ans!',13,10
    DB '| ================================', 13,10
    DB '|                               ',13,10
    DB '| ',13,10
    DB '| ',13,10
    DB '| ',13,10
    DB '| ',13,10
    DB '| ',13,10
    DB '| ',13,10
    DB '| ',13,10
    DB '| ',13,10
    ;DB '*',13,10
    ;DB '*',13,10
    ;DB '*',13,10
    ;DB '*',13,10
    ;DB '*',13,10
    ;DB '*',13,10
    ;DB '*',13,10
    DB '|',13,10,'$'
    
msg2 DB 'Engelden zaman�nda ka�amad�n�z...!',13,10,'$'