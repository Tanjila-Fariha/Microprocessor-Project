.MODEL SMALL
 
ORG 100H

.DATA

; declare variables here  
COUNT DB 0
STR1 DB "ENTER A NUMBER (2 DIGITS):$"  
J DW 0

.CODE
MAIN PROC

; initialize DS

MOV AX,@DATA
MOV DS,AX
 
; enter your code here
LEA DX,STR1
MOV AH,9
INT 21H
MOV AH,1
INT 21H 
SUB AL,030H
MOV BH,AL 
MOV AH,1 
INT 21H
SUB AL,030H
MOV BL,AL
MOV AL,10
MUL BH
MOV BH,0
ADD AX,BX 
MOV BX,AX
CALL M1 
RET
M1 PROC
    CMP BX,0
    JE ZERO 
    MOV CX,0
    PUSH CX  
    INC COUNT
    MOV CX,1
    PUSH CX
    INC COUNT   
    
    LOOP1:
    POP CX
    POP DX 
    MOV AX,CX
    ADD AX,DX
    CMP AX,BX
    JG E 
    PUSH DX
    PUSH CX
    PUSH AX 
    INC COUNT
    JMP LOOP1
    ZERO:
    MOV AX,0
    PUSH AX
    INC COUNT
    JMP F 
    E:
    PUSH DX
    PUSH CX 
    F:
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    MOV CL,COUNT
    MOV CH,0 
    LOOP2:
    POP AX
    MOV DL,10
    DIV DL
    MOV DX,AX
    ADD DL,030H
    MOV AH,2
    INT 21H 
    MOV DL,DH
    ADD DL,030H
    MOV AH,2
    INT 21H
    INC SI 
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    LOOP LOOP2  
    
    
    RET
    M1 ENDP

END
;exit to DOS
               
;MOV AX,4C00H
;INT 21H

MAIN ENDP
    END MAIN
