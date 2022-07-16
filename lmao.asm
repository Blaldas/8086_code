; Trabalho Prático: Turma P9, Grupo [x]
; NOTA (!!!): Renomear ficheiro para T9_Gx.asm (x = nº do grupo)
;
; [2018016626], [José Francisco Pereira Barra Marques]
; [2018018459], [Carolina Ferreira]
; [2018020767], [Rodrigo Vaz Caetano]

.8086
.model small
.stack 64

dseg segment para public 'data'
	LIN db 11
	COL db 11
	ALT db 5
	LARG db 7
	Caracter db '+'
dseg ends

.code
     assume ds:dseg

main proc
	mov ax, dseg
    mov ds, ax
	 
    mov ax, 0B800h
    mov es, ax
	
	xor cx,cx				;cx =0
	xor dx,dx				;dx =0
	mov cl,ALT				;cx = 0,alt
	mov dl,LARG				;dl = 0, larg
	
	xor bx,bx				;bx =0
	mov bl,LIN				;bx = 0,11
	mov ax,2				;ax = 2
	mul bl					;ax = 22
	mov si,ax				;si = 22--------linha
	;si=linha				
	
	xor bx,bx				;bx =0
	mov bl,COL				;bx =0,11
	mov ax,2				;ax =2
	mul bl					;ax = 22
	mov bx,ax				;bx =22----------coluna
	;bl=coluna				

	mov ax,80				;ax = 80
	mul si					;ax = 80*22 = 1760->linha certa
	add al,bl				;ax = 1782 -> POSICAO NO ECRA INICIAL
	adc ah,0				;----
	mov si,ax				;SI = 1782 -> POSICAO NO ECRA INICIAL
	;si tem o ponto desejado
	
	mov di,si				;DI tem o ponto desejado
;	sub di,bx				;ERRO->
;
;						nao fica com o ponto da esquerda, fica com o ponto inicial dessa linha
;
;						CODIGO CORRETO:
	mov bx,0
	mov bl, LARG
	mov ax, 2
	mul bl
	sub di, ax
;

	;di tem o ponto da esquerda									DI........SI
		
	mov al,Caracter							
	mov ah,10001001b			; ax fica com as letras
	;ax tem as caracteristicas
	
ciclo:
			
	mov es:[DI],ax
	mov es:[SI],ax

	sub si,2
	add di,2

	cmp si,di				; ERRO -> ESTA NAO PODE SER USADA COMO BREAK POINT.
						; CMP TEM DE COMPRAR UM REGISTO E UM NUMERO, APARENTEMENTE N PODE COMPARAR DOIR REGISTOS
	jne ciclo


	sub cx,1
	
ciclo2:
	mov es:[SI],ax
	add si,160
	add di,160
	sub cx,1
	loop ciclo2
	
	mov es:[SI],ax
	sub dl,1
	mov bx,ax
	div dl 
	;al tem ciclo3
	
ciclo3:
	add si,2
	sub di,2
	mov es:[SI],bx
	mov es:[DI],bx
	sub al,1
	cmp al,0
	jne ciclo3
	
fim:  
    mov ah, 4ch
    int 21h
main endp
end 