; Trabalho Prático: Turma P6, Grupo [6]
; NOTA (!!!): Renomear ficheiro para T6_G6.asm (x = nº do grupo)
;
; 2018013362, Marco António Ferreira Domingues
; 2016020677, Filipe Miguel Lemos Cantante
; 2017010181, Eduardo Manuel Abreu Pina


.8086
.model small
.stack 64

dseg segment para public 'data'
	; VARIÁVEIS...
	DIM db 7 	;altura largura
	LIN db 10
	COL db 11
	
	CARACTER db '*'
	;cor amarela
	;background preto

dseg ends

.code
    	assume ds:dseg

main proc
	mov ax, dseg
   	mov ds, ax
	 
   	mov ax, 0B800h
   	mov es, ax
	
	XOR CX, CX
	MOV CL, DIM			
;CX PREPARADO APARA O LOOP



	
	MOV DH, LIN
	MOV DL, COL
;posições na matriz NÃO adptadas ao dw
	
	MOV AX, 2
	MUL DL
	MOV DL, AL 
	;dl preparado para dw

	MOV AX, 2
	MUL DH
	MOV DH, AL
	;dh preparado para dw

	MOV AX, 80
	MUL DH
	ADD AL, DL
	ADC AH, 0
	MOV SI, AX
;SI FICA CANTO INFERIOR DIREITO

	MOV DI, SI
	MOV AX, 2
	MOV BX, CX
	MUL BX
	MOV BX, AX
	SUB DI, BX
	ADD DI, 2
;DI FICA CANTO INFERIOR ESQUEDO

	MOV BL, CARACTER
	MOV BH, 10001110b
;BX CONTEM AS CARACTRISTICAS A DESENHAR

ciclo:

	MOV ES:[DI], BX
	MOV ES:[SI], BX
; PASSOU CARATER PARA MEMORIA
	
	SUB DI, 158
	SUB SI, 162
;MUDOU A POSIÇÃO DE ESCRITA NA MEMORIA DE VIDEO	
	


	LOOP ciclo




    	mov ah, 4ch
    	int 21h
	main endp
end 