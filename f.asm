.8086
.model small
.stack 2048
dados segmentpara public 'dados'
	linha db 5
	vector1 db	'sophiaMELLO0'
dados ends
codigo segment para public 'code'
assume cs:codigo, ds:dados

Main proc
	mov ax, dados
	mov ds, ax
	
	mov ax, 0b800h
	mov es, ax

	mov al, linha
	mov bl, 160
	mul bl
mov bx, ax
mov al, linha
add al, 10
mov dl, 160
mul dl
mov si, ax

mov cx, 40
add bx, 2

ciclo1:
mov ax, es:[bx]
add bx, 4
mov es:[si], ax
add si,2
loop ciclo1

mov di, 0

ciclo2:
mov ah, vector1[di]
cmp ah, '0'
je fim
cmp ah, 'A'
jb avanca
cmp ah, 'Z'
ja avanca
mov es:[SI], ah

sub si, 158
avanca: inc di
jmp ciclo2

fim: mov ah, 4CH
int 21H
codigo ends
end main
















