;latest file containg the delay error solved # 1
[org 0x0100]
jmp Start
;3524
ptr: dw 3524			;3364 act as mainpoint for printing mario
monsterptr: dw 850
f: dw 0					;acting as flag to add walking effect in legs of mario
rightmoveflag:dw 0		;flag for moving right while moving up
leftmoveflag:dw 0		;flag for moving left while moving up
stuck: dw 0				;flag to stop mario from crossing hurdles
down: dw 0				;flag to avoid jumping down of mario before crossing the hurdle
enemyptr: dw 3442
enemymoveleftflag: dw 0
enemymoverightflag: dw 0
monstermoverightflag: dw 0
monstermoveleftflag: dw 0
oldkb: dd 0
endgame:dw 0
temp: dw 0x9		;temporary variables
temp2:dw 0x2
bullet_ptr:dw 0		;variable to keep track of bullets position
bullet_flag:dw 1
temp3:dw 0x30
String: db 'Press "S" to Start the Game!',0
String2: db 'Press "A" to Play Again!',0
message1: db 'Enter 4 Character Nick Name:',0
score: dw 0
string3: db 'SCORE:'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_endScreen_Message:			;print message when game ends
	;-----------------------------------------
		mov ah, 0x13 ; service 13 - print string
		mov al, 1 ; subservice 01 – update cursor
		mov bh, 0 ; output on page 0
		mov bl, 0x8e ; normal attrib
		mov dx, 0x0015 ; row 10 column 3
		mov cx, 23 ; length of string
		push cs
		pop es ; segment of string
		mov bp, String2 ; offset of string
		int 0x10 ; call BIOS video service
		;-------------------------------------------
		call Print_Score
		ret
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Print_Score:

push bp
 mov bp, sp
 push es
 push ax
 push bx
 push cx
 push dx
 push di
 
 mov ah, 0x13 ; service 13 - print string
mov al, 1 ; subservice 01 – update cursor
mov bh, 0 ; output on page 0
mov bl, 0x8e ; normal attrib
mov dx, 0x0040 ; row 10 column 3
mov cx, 6 ; length of string
push cs
pop es ; segment of string
mov bp, string3 ; offset of string
int 0x10 ; call BIOS video service
 
 mov ax, 0xb800
 mov es, ax ; point es to video base
 mov ax, word[cs:score] ; load number in ax
 mov bx, 10 ; use base 10 for division
 mov cx, 0 ; initialize count of digits
nextdigit03: mov dx, 0 ; zero upper half of dividend
 div bx ; divide by 10
 add dl, 0x30 ; convert digit into ascii value
 push dx ; save ascii value on stack
 inc cx ; increment count of values
 cmp ax, 0 ; is the quotient zero
 jnz nextdigit03 ; if no divide it again
 mov di, 140 ; point di to 70th column
nextpos03: pop dx ; remove a digit from the stack
 mov dh, 0x8e ; use normal attribute
 mov [es:di], dx ; print char on screen
 add di, 2 ; move to next screen location
 loop nextpos03 ; repeat for all digits on stack
 
 pop di
 pop dx
 pop cx
 pop bx
 pop ax
 pop es
 pop bp
 ret 
		;-------------------------------------------
		ret
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
collisiondetectionfromup:
	push bx
	push dx
	push si
	push cx
	
	mov bx,word[cs:enemyptr]
	mov dx,word[cs:ptr]
	add dx,160
	
	mov si,dx
	add si,6
	
	mov cx,bx
	add cx,4
	
	sub bx,2

	Up_collision_loop1:
		mov bx,word[cs:enemyptr]
	
		Up_collision_loop2:
			cmp bx,dx
			je resetvalueofptr
			add bx,2
			cmp bx,cx
			jne Up_collision_loop2
			
		add dx,2
		cmp dx,si
		jne Up_collision_loop1
		
		
		jmp exit_collisiondetectionfromup
resetvalueofptr:
		mov word[cs:ptr],3442
exit_collisiondetectionfromup:
		pop cx
		pop si
		pop dx
		pop bx
		ret
;------------------------------------------------------------Lose
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Lose:
	push ax
	push bx
	push es
	mov ax,0xb800
	mov es,ax
	call clear
	;-------------------------------G
	mov di,656
	mov si,674
	lose_loop1:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_loop1
	
	mov di,814
	mov si,1934
	lose_loop2:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		add di,160
		cmp di,si
	jne lose_loop2
	
	mov di,1936
	mov si,1954
	lose_loop3:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_loop3
	
	mov di,1792
	mov si,1472
	lose_loop4:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		sub di,160
		cmp di,si
	jne lose_loop4
	
	mov di,1464
	mov si,1474
	lose_loop5:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_loop5
	;---------------------------------
	;--------------------------A-------------
	mov di,1962
	mov si,1322
	lose_A_loop1:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		sub di,160
		cmp di,si
	jne lose_A_loop1
	
	mov di,1322
	mov si,532
	lose_A_loop2:
		mov word[es:di],0x0eDB
		mov word[es:di+2],0x0eDB
		sub di,158
		cmp di,si
	jne lose_A_loop2
	
	mov di,854
	mov si,1502
	lose_A_loop3:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		add di,162
		cmp di,si
	jne lose_A_loop3
	
	mov di,1982
	mov si,1342
	lose_A_loop4:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		sub di,160
		cmp di,si
	jne lose_A_loop4
	
	mov di,1640
	mov si,1660
	lose_A_loop5:
	mov word[es:di],0x0eDB
		;mov word[es:di+2],0x0eDB
		add di,2
		cmp di,si
	jne lose_A_loop5
	
	;----------------------------------------
	;------------------------M---------------
	mov di,1992
	mov si,552
	lose_M_loop1:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		sub di,160
		cmp di,si
	jne lose_M_loop1
	
	mov di,876
	mov si,1524
	lose_M_loop2:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		add di,162
		cmp di,si
	jne lose_M_loop2
	
	mov di,1362
	mov si,730
	lose_M_loop3:
		mov word[es:di],0x0eDB
		mov word[es:di+2],0x0eDB
		sub di,158
		cmp di,si
	jne lose_M_loop3
	
	mov di,2014
	mov si,574
	lose_M_loop4:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		sub di,160
		cmp di,si
	jne lose_M_loop4
	
	;-----------------------------------------
	;----------------------E-------------------
	mov di,2024
	mov si,744
	lose_E_loop1:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		sub di,160
		cmp di,si
	jne lose_E_loop1
	
	mov di,742
	mov si,764
	lose_E_loop2:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_E_loop2
	
	mov di,1382
	mov si,1404
	lose_E_loop3:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_E_loop3
	
	mov di,2022
	mov si,2044
	lose_E_loop4:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_E_loop4
	

	;------------------------------------------
	;-------------------------------------------OVER--------------------------------------
	;--------------------------------------------O----------------------------------------------
	mov di,2416
	mov si,2434
	lose_O_loop1:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_O_loop1
	
	mov di,2574
	mov si,3694
	lose_O_loop2:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		add di,160
		cmp di,si
	jne lose_O_loop2
	
	mov di,3696
	mov si,3714
	lose_O_loop3:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_O_loop3
	
	mov di,2594
	mov si,3714
	lose_O_loop4:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		add di,160
		cmp di,si
	jne lose_O_loop4
	;---------------------------------------------------------------------------------------------
	;-----------------------------------------V------------------------------------
	mov di,2442
	mov si,3242
	lose_V_loop1:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		add di,160
		cmp di,si
	jne lose_V_loop1
	
	mov di,3082+480+6+2+2+160
	mov si,2292+480+6+2+2+160
	lose_V_loop2:
		mov word[es:di],0x0eDB
		mov word[es:di+2],0x0eDB
		sub di,158
		cmp di,si
	jne lose_V_loop2
	
	mov di,3094+160-6-2-2
	mov si,3742+160-6-2-2
	lose_V_loop3:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		add di,162
		cmp di,si
	jne lose_V_loop3
	
	mov di,2462
	mov si,3262
	lose_V_loop4:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		add di,160
		cmp di,si
	jne lose_V_loop4
	;------------------------------------------------------------------------------
	
	;----------------------E-------------------
	mov di,2024+1760-32
	mov si,744+1760-32
	lose_E2_loop1:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		sub di,160
		cmp di,si
	jne lose_E2_loop1
	
	mov di,742+1760-32
	mov si,764+1760-32
	lose_E2_loop2:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_E2_loop2
	
	mov di,1382+1760-32
	mov si,1404+1760-32
	lose_E2_loop3:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_E2_loop3
	
	mov di,2022+1760-32
	mov si,2044+1760-32
	lose_E2_loop4:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_E2_loop4
	

	;------------------------------------------

		;----------------------r-------------------
	mov di,2024+1760
	mov si,744+1760
	lose_R_loop1:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		sub di,160
		cmp di,si
	jne lose_R_loop1
	
	mov di,742+1760
	mov si,764+1760
	lose_R_loop2:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_R_loop2
	
	mov di,1382+1760
	mov si,1404+1760
	lose_R_loop3:
		mov word[es:di],0x0eDB
		add di,2
		cmp di,si
	jne lose_R_loop3
	
	
	mov di,854+1760+60+480+6+160
	mov si,1502+1760+60+480+6+160
	lose_R_loop4:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		add di,162
		cmp di,si
	jne lose_R_loop4
	
	mov di,2024+1760-480-160+20-160+2
	mov si,744+1760+20+2
	lose_R_loop5:
		mov word[es:di],0x0eDB
		mov word[es:di-2],0x0eDB
		sub di,160
		cmp di,si
	jne lose_R_loop5
	;----------------------------------------------------------------------------------Ending Logic----------------------------------------
	;Press S printing String
		;mov ax,2
		;push ax
		;mov ax,2
		;push ax
	    ;mov ax,0x8f
		;push ax
		;mov ax,String2
		;push ax
		;push word 24
		;call printstr
		;---------------------- Getting S
 mov di,124
 mov word[es:di],0x0720
 add di,2
 mov word[es:di],0x0720
		call print_endScreen_Message
		
		infinite_Lose:
		in al,0x60
		cmp al,0x1e
		je ret_main2
		jmp infinite_Lose
		ret_main2:
		mov al, 0x20
		out 0x20, al 	
	call clear
	mov word[cs:score],0
	mov word[cs:monsterptr],850
	mov word[cs:enemyptr],3442
	
	mov word[cs:ptr],3524
	call Background
	call enemy
	call monster
	call MarioBody
	
	;--------------------------------------------------------------------------------Ending Logic---------------------------------
	pop es
	pop bx
	pop ax
	ret

;-------------------------------------------------------------StartGame
StartGame:
;M
call Start_Background
push ax
push bx
push cx
push dx
push si
push di
push bp

;vertical left
	push word 1484 
	push word 364 
	push word 160 
	push word 0x00DB 
		call Flag_0
;horizontal top
	push word 524 
	push word 534 
	push word 2 
	push word 0x00DB 
		call Flag_1
;vertical mid
	push word 532 
	push word 1172 
	push word 160 
	push word 0x00DB 
		call Flag_1
;horizontal bottom
	push word 1012 
	push word 1018 
	push word 2 
	push word 0x00DB 
		call Flag_1
;vertical mid
	push word 1016 
	push word 376 
	push word 160 
	push word 0x00DB 
		call Flag_0
;horizontal top
	push word 536  
	push word 546  
	push word 2  
	push word 0x00DB  
		call Flag_1
;vertical right
	push word 544  
	push word 1664  
	push word 160  
	push word 0x00DB  
		call Flag_1


;A
;vertical left
	push word 1510  
	push word 390  
	push word 160  
	push word 0x00DB  
		call Flag_0
;horizontal top
	push word 550  
	push word 562  
	push word 2  
	push word 0x00DB  
		call Flag_1
;vertical right
	push word 560  
	push word 1680  
	push word 160  
	push word 0x00DB  
		call Flag_1
;horizontal mid
	push word 1030  
	push word 1042  
	push word 2  
	push word 0x00DB  
		call Flag_1

;R
;vertical left
	push word 1526  
	push word 406  
	push word 160  
	push word 0x00DB  
		call Flag_0
;horizontal top
	push word 566  
	push word 578  
	push word 2  
	push word 0x00DB  
		call Flag_1
;vertical right(top)
	push word 576  
	push word 1216  
	push word 160  
	push word 0x00DB  
		call Flag_1
;horizontal mid
	push word 1056  
	push word 1044  
	push word 2  
	push word 0x00DB  
		call Flag_0
;vertical right (bottom)
	push word 1054  
	push word 1694  
	push word 160  
	push word 0x00DB  
		call Flag_1
;horizontal bottom
	push word 1534  
	push word 1538  
	push word 2  
	push word 0x00DB  
		call Flag_1

;I

	push word 584  
	push word 1704  
	push word 160  
	push word 0x00DB 
		call Flag_1

;O

;horizontal top
	push word 592  
	push word 604  
	push word 2  
	push word 0x00DB  
		call Flag_1
;vertical right
	push word 602  
	push word 1722  
	push word 160  
	push word 0x00DB  
		call Flag_1
;horizontal bottom
	push word 1562  
	push word 1550  
	push word 2  
	push word 0x00DB  
		call Flag_0
;vertical left
	push word 1552  
	push word 432  
	push word 160  
	push word 0x00DB  
		call Flag_0
;B
 ;vertical line
     push word 2924
	 push word 1804
	 push word 160
	 push word 0x00DB
	 call Flag_0
;horizontal line
     push word 1964
	 push word 1976
	 push word 2
	 push word 0x00DB
	 call Flag_1
;vertical right
     push word 1974
	 push word 3094
	 push word 160
	 push word 0x00DB
	 call Flag_1
;horizontal mid
      push word 2444
	 push word 2454
	 push word 2
	 push word 0x00DB
	 call Flag_1
	 ; hori bottom
	  push word 2924
	 push word 2934
	 push word 2
	 push word 0x00DB
	 call Flag_1
;E
 ;vertical
     push word 2940
	 push word 1820
	 push word 160
	 push word 0x00DB
	 call Flag_0
;horizontal top
     push word 1980
	 push word 1990
	 push word 2
	 push word 0x00DB
	 call Flag_1
;horizontal mid
     push word 2460
	 push word 2470
	 push word 2
	 push word 0x00DB
	 call Flag_1	
;horizontal bottom
     push word 2940
	 push word 2950
	 push word 2
	 push word 0x00DB
	 call Flag_1	 
;T
 ;horizontal
     push word 1994
	 push word 2016
	 push word 2
	 push word 0x00DB
	 call Flag_1
;vertical
     push word 2004
	 push word 3124
	 push word 160
	 push word 0x00DB
	 call Flag_1
;A
;vertical
     push word 2980
	 push word 1860
	 push word 160
	 push word 0x00DB
	 call Flag_0
;horizontal top
     push word 2020
	 push word 2032
	 push word 2
	 push word 0x00DB
	 call Flag_1
;vertical right
     push word 2030
	 push word 3150
	 push word 160
	 push word 0x00DB
	 call Flag_1	 
;horizontal mid
     push word 2500
	 push word 2510
	 push word 2
	 push word 0x00DB
	 call Flag_1
;---------------------------------------
		;--------------------------------Name
	;mov ah, 0x13 ; service 13 - print string
	;mov al, 1 ; subservice 01 – update cursor
	;mov bh, 0 ; output on page 0
	;mov bl, 7 ; normal attrib
	;mov dx, 0x0400 ; row 10 column 3
	;mov cx, 16 ; length of string
	;push cs
	;pop es ; segment of string
	;mov bp, message1 ; offset of string
	;int 0x10 ; call BIOS video service
	    mov ax,2
		push ax
		mov ax,21
		push ax
	    mov ax,0x0f
		push ax
		mov ax,message1
		push ax
		push word 28
		call printstr
	
	push 0xb800
	pop es
	mov cx,0
	mov di,3420
	mov si,0
	loop1:
		mov ah,0				; Get Keystroke - Subservice 0
		int 0x16				; BIOS keyboard service
        	print:
			mov ah,0x0f				; set attributes
			mov word [es:di],ax		; Display the key pressed on screen
			mov byte[cs:message1+si],al
			add si,1
			add di,2				; increment cursor location	
			inc cx
			again:
				cmp cx,4
				jne loop1
		;---------------------------------
		
		
		
		;Press S printing String
		mov ax,2
		push ax
		mov ax,23
		push ax
	    mov ax,0x8f
		push ax
		mov ax,String
		push ax
		push word 28
		call printstr
		;---------------------- Getting S
		infinite_S:
		in al,0x60
		cmp al,0x1f
		je ret_main
		jmp infinite_S
		ret_main:
		mov al, 0x20
		out 0x20, al 				; send EOI to PIC
		;----------------------
		
		pop bp
		pop di
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		ret
;
Flag_1:
	push bp 
	mov bp,sp
	
	push ax 
	push bx
	push si
	push di
			;previous values of ax, bx, si, di are stored
	
	mov ax,0xB800
	mov es,ax
	mov ax,word[bp+4]   ;retrieving attribute
	mov bx,word[bp+6]	 
	mov di,word[bp+8]	 
	mov si,word[bp+10]	 
	
	
keep_printing_Flag_1:
	call Delay2
	mov word [es:si],ax
	add si,bx
	cmp si,di
		jne keep_printing_Flag_1
	;restoring old values of ax, bx, si, di
	pop di
	pop si
	pop bx
	pop ax
	pop bp

ret 8  ;end subroutine


Flag_0:
	push bp 
	mov bp,sp
	
	push ax 
	push bx
	push si
	push di
			;previous values of ax, bx, si, di are stored
	
	mov ax,0xB800
	mov es,ax
	mov ax,[bp+4]   ;retrieving attribute
	mov bx,[bp+6]	 
	mov di,[bp+8]	 
	mov si,[bp+10]	 
	
	
keep_printing_Flag_0:
	call Delay2
	mov word [es:si],ax
	sub si,bx
	cmp si,di
		jne keep_printing_Flag_0
	;restoring old values of ax, bx, si, di
	pop di
	pop si
	pop bx
	pop ax
	pop bp

ret 8  ;end subroutine
Start_Background:;For clear screen
		push ax
		push es
		push di
		push si
		mov ax,0xB800
		mov es,ax
		mov di,0
		mov si,4000
SB:
		mov word[es:di],0x08DB
		add di,2
		cmp di,si
		jne SB
		pop si
		pop di
		pop es
		pop ax
		ret
Delay2:;To make a certain Delay between printing characters
		push cx
		mov cx,0xffff
		loop_Delay2:
		sub cx,1
		jnz loop_Delay2
		pop cx
		ret
;-------------------------------------------------------------printstr
printstr: 
push bp
mov bp, sp
 push es
 push ax
 push cx
 push si
 push di

	mov ax, 0xb800
	mov es, ax ; point es to video base
	mov al, 80 ; load al with columns per row
	mul byte [bp+10] ; multiply with y position
	add ax, [bp+12] ; add x position
	shl ax, 1 ; turn into byte offset
	mov di,ax ; point di to required location
	mov si, [bp+6] ; point si to string
	mov cx, [bp+4] ; load length of string in cx
	mov ah, [bp+8] ; load attribute in ah 

 cld ; auto increment mode
	nextcha: 
	lodsb ; load next char in al
	stosw ; print char/attribute pair
	loop nextcha ; repeat for the whole string
 pop di
 pop si
 pop cx
 pop ax
 pop es
 pop bp
 ret 10

;-------------------------------------------------------------------------------YOU WIN S---------------------------------------------------------------
You_Win:
        push ax
		push bx
		push es
		mov ax,0xb800
		mov es,ax
		mov word[es:2582],0x8eDB
		mov word[es:2422],0x8eDB
		mov word[es:2262],0x8eDB
		mov word[es:2102],0x8eDB
		;---strait line ends
		mov word[es:1940],0x8eDB
		mov word[es:1778],0x8eDB
		mov word[es:1616],0x8eDB
		mov word[es:1454],0x8eDB
		;left curls of Y
		mov word[es:1944],0x8eDB
		mov word[es:1786],0x8eDB
		mov word[es:1628],0x8eDB
		mov word[es:1470],0x8eDB
		;-------------------------------------Y Completed
		mov word[es:2602],0x8eDB
		mov word[es:2600],0x8eDB
		mov word[es:2438],0x8eDB
		mov word[es:2276],0x8eDB
		mov word[es:2114],0x8eDB
		mov word[es:1954],0x8eDB
		mov word[es:1796],0x8eDB
		mov word[es:1638],0x8eDB
		mov word[es:1480],0x8eDB
		mov word[es:1482],0x8eDB
		mov word[es:1644],0x8eDB
		mov word[es:1806],0x8eDB
		mov word[es:1968],0x8eDB
		mov word[es:2128],0x8eDB
		mov word[es:2286],0x8eDB
		mov word[es:2444],0x8eDB
		;--------------------------------------O Completed
		mov word[es:2618],0x8eDB
		mov word[es:2620],0x8eDB
		mov word[es:2622],0x8eDB
		mov word[es:2624],0x8eDB
		
		mov word[es:2456],0x8eDB
		mov word[es:2294],0x8eDB
		
		mov word[es:2134],0x8eDB
		mov word[es:1974],0x8eDB
		mov word[es:1814],0x8eDB
		mov word[es:1654],0x8eDB
		mov word[es:1494],0x8eDB
		
		mov word[es:2466],0x8eDB
		mov word[es:2308],0x8eDB
		
		mov word[es:2148],0x8eDB
		mov word[es:1988],0x8eDB
		mov word[es:1828],0x8eDB
		mov word[es:1668],0x8eDB
		mov word[es:1508],0x8eDB
		;--------------------------------------U Completed
		mov word[es:2650],0x8eDB
		mov word[es:2490],0x8eDB
		mov word[es:2330],0x8eDB
		
		mov word[es:2168],0x8eDB
		mov word[es:2006],0x8eDB
		mov word[es:1844],0x8eDB
		mov word[es:1682],0x8eDB
		mov word[es:1520],0x8eDB
		
		mov word[es:2172],0x8eDB
		mov word[es:2014],0x8eDB
		mov word[es:2176],0x8eDB
		
		mov word[es:2338],0x8eDB
		mov word[es:2498],0x8eDB
		mov word[es:2658],0x8eDB
		
		mov word[es:2180],0x8eDB
		mov word[es:2022],0x8eDB
		mov word[es:1864],0x8eDB
		mov word[es:1706],0x8eDB
		mov word[es:1548],0x8eDB
		;-----------------------------------W Completed
		mov word[es:1554],0x8eDB
		mov word[es:1556],0x8eDB
		mov word[es:1558],0x8eDB
		
		mov word[es:1716],0x8eDB
		mov word[es:1876],0x8eDB
		mov word[es:2036],0x8eDB
		mov word[es:2196],0x8eDB
		mov word[es:2356],0x8eDB
		mov word[es:2516],0x8eDB
		mov word[es:2676],0x8eDB
		
		mov word[es:2674],0x8eDB
		mov word[es:2678],0x8eDB
		;-----------------------------------I Completed
		mov word[es:2682],0x8eDB
		mov word[es:2522],0x8eDB
		mov word[es:2362],0x8eDB
		mov word[es:2202],0x8eDB
		mov word[es:2042],0x8eDB
		mov word[es:1882],0x8eDB
		mov word[es:1722],0x8eDB
		mov word[es:1562],0x8eDB
  
        mov word[es:1564],0x8eDB
		mov word[es:1726],0x8eDB
		mov word[es:1888],0x8eDB
		mov word[es:2050],0x8eDB
		mov word[es:2212],0x8eDB
		mov word[es:2374],0x8eDB
		mov word[es:2536],0x8eDB
		mov word[es:2698],0x8eDB
		
		mov word[es:2700],0x8eDB
		mov word[es:2540],0x8eDB
		mov word[es:2380],0x8eDB
		mov word[es:2220],0x8eDB
		mov word[es:2060],0x8eDB
		mov word[es:1900],0x8eDB
		mov word[es:1740],0x8eDB
		mov word[es:1580],0x8eDB
		mov di,124
 mov word[es:di],0x0720
 add di,2
 mov word[es:di],0x0720
		call print_endScreen_Message
		;-----------------------------------N Completed
		pop es
		pop bx
		pop ax
		ret
;-------------------------------------------------------------------------------YOU WIN E---------------------------------------------------------------
printnum: 
push bp
 mov bp, sp
 push es
 push ax
 push bx
 push cx
 push dx
 push di
 mov ax, 0xb800
 mov es, ax ; point es to video base
 
 mov di,124
 mov word[es:di],0x07153
 add di,2
 mov word[es:di],0x07163
 add di,2
 mov word[es:di],0x0716F
 add di,2
 mov word[es:di],0x07172
 add di,2
 mov word[es:di],0x07165
 add di,2
 mov word[es:di],0x0713A
 add di,2
 
 
 mov ax, word[cs:score] ; load number in ax
 
 mov bx, 10 ; use base 10 for division
 mov cx, 0 ; initialize count of digits
nextdigit0: mov dx, 0 ; zero upper half of dividend
 div bx ; divide by 10
 add dl, 0x30 ; convert digit into ascii value
 push dx ; save ascii value on stack
 inc cx ; increment count of values
 cmp ax, 0 ; is the quotient zero
 jnz nextdigit0 ; if no divide it again
 mov di, 140 ; point di to 70th column
nextpos0: pop dx ; remove a digit from the stack
 mov dh, 0x07 ; use normal attribute
 mov [es:di], dx ; print char on screen
 add di, 2 ; move to next screen location
 loop nextpos0 ; repeat for all digits on stack

 pop di
 pop dx
 pop cx
 pop bx
 pop ax
 pop es
 pop bp
 ret 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Delayforenemy2:
		push cx
		mov cx,0xfff
		lm1:
			sub cx,1
		cmp cx,0
		jne lm1
		mov cx,0xfff
		lm2:
			sub cx,1
		cmp cx,0
		jne lm2
		mov cx,0xfff
		lm3:
			sub cx,1
		cmp cx,0
		jne lm3
		
		pop cx
		ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Delayforenemy:;To make a certain Delay between printing characters
		push cx
		mov cx,0xfff
		l9:
			sub cx,1
		cmp cx,0
		jne l9
		mov cx,0xfff
		l7:
			sub cx,1
		cmp cx,0
		jne l7
		mov cx,0xfff
		l8:
			sub cx,1
		cmp cx,0
		jne l8
		
		pop cx
		ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Delay:;To make a certain Delay between printing characters
		push cx
		mov cx,0x8000
		l3:
			sub cx,1
			mov al,0
			in al, 0x60 ; read a char from keyboard port
			cmp al, 0x4d ; is the key left shift
			je changemoverightflag01
			
			cmp al, 0x4b ; is the key left shift
			je changemoveleftflag01
			
			jmp ignorechangingflag
		changemoverightflag01:
		mov word[cs:rightmoveflag],1
		jmp ignorechangingflag
		
		changemoveleftflag01:
		mov word[cs:leftmoveflag],1
		
		ignorechangingflag:
		cmp cx,0
		jne l3
		pop cx
		ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
move_enemy2:
	push ax
	
	cmp word[cs:temp2],0
	je dontexitmoveeneymy2 	
		sub word[cs:temp2],1
		
		pop ax
		
		ret 	
	dontexitmoveeneymy2:
	mov word[cs:temp2],0x2
	
	cmp word[cs:enemyptr],3442
	je moveenemyleft2
	cmp word[cs:enemyptr],3410
	je moveenemyright2
	
	cmp word[cs:enemymoverightflag],1
	je moveenemyright2
	jmp moveenemyleft2
	
	moveenemyright2:
		mov word[cs:enemymoverightflag],1
		mov word[cs:enemymoveleftflag],0
		call blankenemy
		add word[cs:enemyptr],2
		call enemy
		
		jmp ignore_moveeneyleft2
	moveenemyleft2:
		mov word[cs:enemymoveleftflag],1
		mov word[cs:enemymoverightflag],0
		call blankenemy
		sub word[cs:enemyptr],2
		call enemy
		
	ignore_moveeneyleft2:
		;call enemy
		
		push si
		push di
		mov si,word[cs:enemyptr]
		mov di,word[cs:ptr]
		sub di,si
		cmp di,152
		jne ignorechangingendgameflag2
		
		call Blank_Mario
		call Lose
		mov word[cs:ptr],3524
		call MarioBody
		mov word[cs:endgame],0
		;mov word[cs:endgame],1
		
	ignorechangingendgameflag2:
			;--------------------------------------------------Monster
	
	cmp word[cs:monsterptr],924
	je movemonsterleft2
	cmp word[cs:monsterptr],816
	je movemonsterright2
	
	cmp word[cs:monstermoverightflag],1
	je movemonsterright2
	jmp movemonsterleft2
	
	movemonsterright2:
	       mov word[cs:monstermoverightflag],1
		   mov word[cs:monstermoveleftflag],0
		   call blankmonster
           add word[cs:monsterptr],2
           call monster
           jmp ignore_movemonsterleft2
    movemonsterleft2:
	       mov word[cs:monstermoverightflag],0
		   mov word[cs:monstermoveleftflag],1
		   call blankmonster
           sub word[cs:monsterptr],2
           call monster
	ignore_movemonsterleft2:

		pop di
		pop si
		pop ax
		
		ret 		 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
check_Bullet_Collision:
push bp
mov bp,sp
push di
push si
	;--------------------------------------------------
	mov di,word[cs:ptr]
	mov si,word[cs:bullet_ptr]
	sub di,160
	add si,174
	
	sub di,318
	cmp di,si
	je changevalueofPTRduetobullets
	
	
	mov di,word[cs:ptr]
	sub di,478
	cmp di,si
	je changevalueofPTRduetobullets
	
	mov di,word[cs:ptr]
	sub di,320
	cmp di,si
	je changevalueofPTRduetobullets
	
	mov di,word[cs:ptr]
	sub di,480
	cmp di,si
	je changevalueofPTRduetobullets
	
	mov di,word[cs:ptr]
	sub di,316
	cmp di,si
	je changevalueofPTRduetobullets
	
	mov di,word[cs:ptr]
	sub di,476
	cmp di,si
	je changevalueofPTRduetobullets
	jmp ignore_changevalueofPTRduetobullets
	;-----------------------------------------------------
	
	changevalueofPTRduetobullets:
	;mov byte[bp+4],5
	;call Blank_Mario
	;call clear
	;
	    ;mov ax,2
		;push ax
		;mov ax,2
		;push ax
	    ;mov ax,0x8f
		;push ax
		;mov ax,String
		;push ax
		;push word 24
		;call printstr
	;
	mov word[cs:ptr],3524
	call Lose
	ignore_changevalueofPTRduetobullets:
	pop si
	pop di
	pop bp
	ret 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
move_enemy:

	call printnum
	push ax
	cmp word[cs:temp3],0
	jne ignorechangingbullet_ptr
	cmp word[cs:bullet_flag],0
	je ignorechangingbullet_ptr
	;-----------------------------------------------------
	cmp word[cs:bullet_flag],1
	mov ax,word[cs:monsterptr]
	mov word[cs:bullet_flag],0
	mov word[cs:bullet_ptr],ax
ignorechangingbullet_ptr:
	cmp word[cs:bullet_ptr],0
	je ignorechangingbullet_ptr2
	mov ax,word[cs:bullet_ptr]
	mov di,ax
	mov word[es:di+14+160],0x0720
	add ax,160
	mov word[cs:bullet_ptr],ax 
	push di
	mov di,ax
	mov word[es:di+14+160],0x8c1F
	
	push ax
	call check_Bullet_Collision
	pop ax
	
	cmp ax,5
	je ignorechangingbullet_ptr2
	pop di
	cmp word[cs:bullet_ptr],2880
	ja changevalueofBulletPtrifabove
	jmp ignorechangingbullet_ptr2
	changevalueofBulletPtrifabove:
		cmp word[cs:bullet_ptr],3040
		jb changevalueofBulletPtr
	jmp ignorechangingbullet_ptr2
	changevalueofBulletPtr:
		mov di,ax
		mov word[es:di+14+160],0x0720
		;call Background
		mov word[cs:bullet_ptr],0
		mov word[cs:bullet_flag],1
		mov word[cs:temp3],0x30
	;------------------------------------------------------
	ignorechangingbullet_ptr2:
	dec word[cs:temp3]
	
	; push cx
	; push dx
	; call Delayforenemy
	; call Delayforenemy
	; call Delayforenemy
	; call Delayforenemy
	; mov dx,0x800
	; loopfordealy2:
	; mov cx,0x50
	; loopfordelay:
		; sub cx,1
		; cmp cx,0
		; jne loopfordelay
		; sub dx,1
		; cmp dx,0
		; jne loopfordealy2
	; pop dx
	; pop cx
	cmp word[cs:temp],0
	je dontexitmoveeneymy 	
		
		push si
		push di
		mov si,word[cs:enemyptr]
		mov di,word[cs:ptr]
		sub di,si
		cmp di,162
		pop di
		pop si
		jne exittheenemy2
		call Blank_Mario
		call Lose
		mov word[cs:ptr],3524
		call MarioBody
		mov word[cs:endgame],0
		
		jmp exittheenemy
		exittheenemy2:
		push si
		push di
		mov si,word[cs:enemyptr]
		mov di,word[cs:ptr]
		sub di,si
		cmp di,152
		pop di
		pop si
		jne exittheenemy
		call Blank_Mario
		call Lose
		mov word[cs:ptr],3524
		call MarioBody
		mov word[cs:endgame],0
		
	exittheenemy:
		sub word[cs:temp],1
		mov al, 0x20
		out 0x20, al 				; send EOI to PIC
		
		pop ax
		
		iret 	
	dontexitmoveeneymy:
	mov word[cs:temp],0x9
	
	
	
	cmp word[cs:enemyptr],3442
	je moveenemyleft
	cmp word[cs:enemyptr],3410
	je moveenemyright
	
	cmp word[cs:enemymoverightflag],1
	je moveenemyright
	jmp moveenemyleft
	
	moveenemyright:
		mov word[cs:enemymoverightflag],1
		mov word[cs:enemymoveleftflag],0
		call blankenemy
		add word[cs:enemyptr],2
		call enemy
		
		push si
		push di
		mov si,word[cs:enemyptr]
		mov di,word[cs:ptr]
		sub di,si
		cmp di,162
		pop di
		pop si
		jne ignorechangingendgameflag
		call Blank_Mario
		call Lose
		mov word[cs:ptr],3524
		call MarioBody
		mov word[cs:endgame],0
		
		jmp ignore_moveeneyleft
	moveenemyleft:
		mov word[cs:enemymoveleftflag],1
		mov word[cs:enemymoverightflag],0
		call blankenemy
		sub word[cs:enemyptr],2
		call enemy
		
		push si
		push di
		mov si,word[cs:enemyptr]
		mov di,word[cs:ptr]
		sub di,si
		cmp di,152
		pop di
		pop si
		jne ignorechangingendgameflag
		call Blank_Mario
		call Lose
		mov word[cs:ptr],3524
		call MarioBody
		mov word[cs:endgame],0

		;mov word[cs:endgame],1
	ignore_moveeneyleft:
		;call enem
		
		
	ignorechangingendgameflag:
			;--------------------------------------------------Monster
	
	cmp word[cs:monsterptr],924
	je movemonsterleft
	cmp word[cs:monsterptr],816
	je movemonsterright
	
	cmp word[cs:monstermoverightflag],1
	je movemonsterright
	jmp movemonsterleft
	
	movemonsterright:
	       mov word[cs:monstermoverightflag],1
		   mov word[cs:monstermoveleftflag],0
		   call blankmonster
           add word[cs:monsterptr],2
           call monster
           jmp ignore_movemonsterleft
    movemonsterleft:
	       mov word[cs:monstermoverightflag],0
		   mov word[cs:monstermoveleftflag],1
		   call blankmonster
           sub word[cs:monsterptr],2
           call monster
	ignore_movemonsterleft:
		   
	
	
		mov al, 0x20
		out 0x20, al 				; send EOI to PIC
		
		pop ax
		
		iret 		 
;----------------------------------------------------------------
monster:
        push ax
		push es
		push di
		mov ax,0xb800
		mov es,ax
		mov di,word[cs:monsterptr]
		
		mov word[es:di],0x0e1F
		mov word[es:di+2],0x0e1F
		mov word[es:di+4],0x0e1F
		mov word[es:di+6],0x0e1F
		mov word[es:di+8],0x0e1F
		mov word[es:di+10],0x0e1F
		
		mov word[es:di+12],0x8c7F				
		mov word[es:di+14+160],0x8c1F
		mov word[es:di+16],0x8c7F
		
		mov word[es:di+18],0x0e1F
		mov word[es:di+20],0x0e1F
		mov word[es:di+22],0x0e1F
		mov word[es:di+24],0x0e1F
		mov word[es:di+26],0x0e1F
		mov word[es:di+28],0x0e1F
		;--------------------------------Base Finished
		mov word[es:di-2],0x0e3C
		
		mov word[es:di-162],0x0eDE
		mov word[es:di-164],0x0e3C
		
		
		mov word[es:di-322],0x0eDE
		mov word[es:di-324],0x0e3C
		mov word[es:di-326],0x0e3C
		
		
		mov word[es:di-482],0x0eDE
		mov word[es:di-484],0x0e3C
		
		
		mov word[es:di-642],0x0e3C
		;mov word[es:di-802],0x0e11
		;left side
		mov word[es:di-640],0x0e7F
		mov word[es:di-638],0x0e7F
		;mov word[es:di-638-160],0x0e1F
		
		mov word[es:di-636],0x0e7F
		mov word[es:di-634],0x0e7F
		mov word[es:di-632],0x0e7F
		mov word[es:di-630],0x0e7F
		mov word[es:di-628],0x0e7F
		mov word[es:di-626],0x0e7F
		mov word[es:di-624],0x0e7F
		mov word[es:di-622],0x0e7F
		mov word[es:di-620],0x0e7F
		mov word[es:di-618],0x0e7F
		mov word[es:di-616],0x0e7F
		mov word[es:di-614],0x0e7F
		mov word[es:di-614+2],0x0e7F
		;upper side;;;;;;;;;;;;
		mov word[es:di-612+2],0x0e3E;lower
		
		mov word[es:di-452+2],0x0eDD
		mov word[es:di-450+2],0x0e3E
		
		mov word[es:di-292+2],0x0eDD
		mov word[es:di-290+2],0x0e3E
		mov word[es:di-288+2],0x0e3E
		
		mov word[es:di-132+2],0x0eDD
        mov word[es:di-130+2],0x0e3E
		
		mov word[es:di+28+2],0x0e3E;upper
		;right side
		
		
		mov word[es:di-160],0x05DB
		mov word[es:di-160+2],0x05DB
		mov word[es:di-160+4],0x05DB
		mov word[es:di-160+6],0x05DB
		mov word[es:di-160+8],0x05DB
		mov word[es:di-160+10],0x05DB
	    mov word[es:di-160+12],0x05DB
		mov word[es:di-160+14],0x05DB
		mov word[es:di-160+16],0x05DB
		mov word[es:di-160+18],0x05DB
		mov word[es:di-160+20],0x05DB
		mov word[es:di-160+22],0x05DB
		mov word[es:di-160+24],0x05DB
		mov word[es:di-160+26],0x05DB
		mov word[es:di-160+28],0x05DB
		
		mov word[es:di-320],0x05DB
		mov word[es:di-320+2],0x05DB
		mov word[es:di-320+4],0x05DB
		mov word[es:di-320+6],0x05DB
		mov word[es:di-320+8],0x05DB
		mov word[es:di-320+10],0x05DB
		mov word[es:di-320+12],0x05DB
		mov word[es:di-320+14],0x05DB
		mov word[es:di-320+16],0x05DB
		mov word[es:di-320+18],0x05DB
		mov word[es:di-320+20],0x05DB
		mov word[es:di-320+22],0x05DB
		mov word[es:di-320+24],0x05DB
		mov word[es:di-320+26],0x05DB
		mov word[es:di-320+28],0x05DB
		
		mov word[es:di-480],0x05DB
		mov word[es:di-480+2],0x05DB
		mov word[es:di-480+4],0x05DB
		mov word[es:di-480+6],0x05DB
		mov word[es:di-480+8],0x05DB
		mov word[es:di-480+10],0x05DB
		mov word[es:di-480+12],0x05DB
		mov word[es:di-480+14],0x05DB
		mov word[es:di-480+16],0x05DB
		mov word[es:di-480+18],0x05DB
		mov word[es:di-480+20],0x05DB
		mov word[es:di-480+22],0x05DB
		mov word[es:di-480+24],0x05DB
		mov word[es:di-480+26],0x05DB
		mov word[es:di-480+28],0x05DB
		;colors
		mov word[es:di-480+6],0x5093
		mov word[es:di-480+6+14],0x5093
		;eyes
		mov word[es:di-320+6+8],0x5076
		;nose
		
		
		pop di
		pop es
		pop ax
		ret
blankmonster:
        push ax
		push es
		push di
		mov ax,0xb800
		mov es,ax
		mov di,word[cs:monsterptr]
		
		mov word[es:di],0x0720
		mov word[es:di+2],0x0720
		mov word[es:di+4],0x0720
		mov word[es:di+6],0x0720
		mov word[es:di+8],0x0720
		mov word[es:di+10],0x0720
		
		mov word[es:di+12],0x0720				
		mov word[es:di+14+160],0x0720
		mov word[es:di+16],0x0720
		
		mov word[es:di+18],0x0720
		mov word[es:di+20],0x0720
		mov word[es:di+22],0x0720
		mov word[es:di+24],0x0720
		mov word[es:di+26],0x0720
		mov word[es:di+28],0x0720
		;--------------------------------Base Finished
		mov word[es:di-2],0x0720
		
		mov word[es:di-162],0x0720
		mov word[es:di-164],0x0720
		
		
		mov word[es:di-322],0x0720
		mov word[es:di-324],0x0720
		mov word[es:di-326],0x0720
		
		
		mov word[es:di-482],0x0720
		mov word[es:di-484],0x0720
		
		
		mov word[es:di-642],0x0720
		;mov word[es:di-802],0x0e11
		;left side
		mov word[es:di-640],0x0720
		mov word[es:di-638],0x0720
		;mov word[es:di-638-160],0x0e1F
		
		mov word[es:di-636],0x0720
		mov word[es:di-634],0x0720
		mov word[es:di-632],0x0720
		mov word[es:di-630],0x0720
		mov word[es:di-628],0x0720
		mov word[es:di-626],0x0720
		mov word[es:di-624],0x0720
		mov word[es:di-622],0x0720
		mov word[es:di-620],0x0720
		mov word[es:di-618],0x0720
		mov word[es:di-616],0x0720
		mov word[es:di-614],0x0720
		mov word[es:di-614+2],0x0720
		;upper side;;;;;;;;;;;;
		mov word[es:di-612+2],0x0720;lower
		
		mov word[es:di-452+2],0x0720
		mov word[es:di-450+2],0x0720
		
		mov word[es:di-292+2],0x0720
		mov word[es:di-290+2],0x0720
		mov word[es:di-288+2],0x0720
		
		mov word[es:di-132+2],0x0720
        mov word[es:di-130+2],0x0720
		
		mov word[es:di+28+2],0x0720;upper
		;right side
		
		
		mov word[es:di-160],0x0720
		mov word[es:di-160+2],0x0720
		mov word[es:di-160+4],0x0720
		mov word[es:di-160+6],0x0720
		mov word[es:di-160+8],0x0720
		mov word[es:di-160+10],0x0720
	    mov word[es:di-160+12],0x0720
		mov word[es:di-160+14],0x0720
		mov word[es:di-160+16],0x0720
		mov word[es:di-160+18],0x0720
		mov word[es:di-160+20],0x0720
		mov word[es:di-160+22],0x0720
		mov word[es:di-160+24],0x0720
		mov word[es:di-160+26],0x0720
		mov word[es:di-160+28],0x0720
		
		mov word[es:di-320],0x0720
		mov word[es:di-320+2],0x0720
		mov word[es:di-320+4],0x0720
		mov word[es:di-320+6],0x0720
		mov word[es:di-320+8],0x0720
		mov word[es:di-320+10],0x0720
		mov word[es:di-320+12],0x0720
		mov word[es:di-320+14],0x0720
		mov word[es:di-320+16],0x0720
		mov word[es:di-320+18],0x0720
		mov word[es:di-320+20],0x0720
		mov word[es:di-320+22],0x0720
		mov word[es:di-320+24],0x0720
		mov word[es:di-320+26],0x0720
		mov word[es:di-320+28],0x0720
		
		mov word[es:di-480],0x0720
		mov word[es:di-480+2],0x0720
		mov word[es:di-480+4],0x0720
		mov word[es:di-480+6],0x0720
		mov word[es:di-480+8],0x0720
		mov word[es:di-480+10],0x0720
		mov word[es:di-480+12],0x0720
		mov word[es:di-480+16],0x0720
		mov word[es:di-480+18],0x0720
		mov word[es:di-480+20],0x0720
		mov word[es:di-480+22],0x0720
		mov word[es:di-480+24],0x0720
		mov word[es:di-480+26],0x0720
		mov word[es:di-480+28],0x0720
		;colors
		mov word[es:di-480+6],0x0720
		mov word[es:di-480+6+14],0x0720
		;eyes
		mov word[es:di-320+6+8],0x0720
		;nose
		
		
		pop di
		pop es
		pop ax
		ret
;----------------------------------------------------------------

enemy:
		push di
		mov di,word[cs:enemyptr]
		mov ax, 0xb800
		mov es, ax
		
		;hairs
		mov word[es:di],0x0b5F;
		mov word[es:di+2],0x0b5F;
		;face
		mov word[es:di+160],0x0e0a
		mov word[es:di+162],0x0e0a
		;hands
		mov word[es:di+158],0x0bDA
		mov word[es:di+164],0x0bBF
		;legs
		mov word[es:di+160+160],0x0cBE
		mov word[es:di+160+162],0x0cD4
		pop di
		ret
blankenemy:
		push di
		mov di,word[cs:enemyptr]

		;hairs
		mov word[es:di],0x0720;
		mov word[es:di+2],0x0720;
		;face
		mov word[es:di+160],0x0720
		mov word[es:di+162],0x0720
		;hands
		mov word[es:di+158],0x0720
		mov word[es:di+164],0x0720
		;legs
		mov word[es:di+160+160],0x0720
		mov word[es:di+160+162],0x0720
		pop di
		ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Blank_Mario:			;this subroutine will print a mario but with blank spaces so that previous mario character could be earased 
		push es
		push di
		push ax
		mov ax,0xb800
		mov es,ax
		mov di,word[cs:ptr]
		;----Legs-----------------
		
		mov word[es:di+160],0x0720
		mov word[es:di+162],0x0720
		mov word[es:di+162],0x0720
		mov word[es:di+166],0x0720
;----------------------------

;-----------Main body-----------------
		mov word[es:di],0x0720
		mov word[es:di+2],0x0720
		mov word[es:di+4],0x0720

		mov word[es:di-160],0x0720
		mov word[es:di-158],0x0720
		mov word[es:di-156],0x0720
;---------------------------------------

;---------Hands----------
		mov word[es:di-158],0x0720
		mov word[es:di-158],0x0720
;-------------------------

;----------Head----------
		mov word[es:di-318],0x0720
		mov word[es:di-478],0x0720
		mov word[es:di-320],0x0720
		mov word[es:di-316],0x0720
;------------------------
;----------------------------------------------------------------------Mario
		pop ax
		pop di
		pop es
		ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Background:
		push ax
		push bx
		push es
		mov ax,0xb800
		mov es,ax
		push 0
		push 4000
		push 2
		push word 0x0f20
		call Flag
		;-------------------------------------------------------black over white
		
			;-------------------------------------------------------creating kingdom
		mov word[es:3838],0x08DB
		mov word[es:3678],0x08DB
		mov word[es:3518],0x08DB
		mov word[es:3358],0x08DB
		;mov word[es:3198],0x08DB
		;
		mov word[es:3836],0x07DB
		mov word[es:3676],0x07DB
		mov word[es:3516],0x07DB
		mov word[es:3356],0x071E
        ;
		mov word[es:3834],0x07DB
		mov word[es:3674],0x07DB
		mov word[es:3514],0x071E
        ;
		mov word[es:3832],0x70DF;mov word[es:3832],0x07DB
		mov word[es:3672],0x70DC;mov word[es:3672],0x07DB
		mov word[es:3512],0x071E
        ;
		mov word[es:3830],0x07DB;mov word[es:3830],0x70DF;
		mov word[es:3670],0x07DB;mov word[es:3670],0x70DC;
		mov word[es:3510],0x071E;-------------------
		  ;
		mov word[es:3828],0x07DB;mov word[es:3828],0x70DF
		mov word[es:3668],0x07DB;mov word[es:3668],0x70DC
		mov word[es:3508],0x071E;-------------------
		  ;
		mov word[es:3826],0x70DF;mov word[es:3826],0x07DB
		mov word[es:3666],0x70DC;mov word[es:3666],0x07DB
		mov word[es:3506],0x071E
		  ;
		    ;
		mov word[es:3824],0x07DB
		mov word[es:3664],0x07DB
		mov word[es:3504],0x071E
		  ;
		mov word[es:3822],0x07DB
		mov word[es:3662],0x07DB
		mov word[es:3502],0x07DB
		mov word[es:3342],0x071E
			  ;
		mov word[es:3820],0x08DB
		mov word[es:3660],0x08DB
		mov word[es:3500],0x08DB
		mov word[es:3340],0x08DB
		;mov word[es:3180],0x08DB
		;small flag left
		mov word[es:3180],0x08BA
		mov word[es:3182],0x0c10
		;small flag right
		mov word[es:3198],0x08BA
		mov word[es:3196],0x0c11
		;-------------------------------------------------------Kingdom created
		
		;--------------------------------------------------------------Green Flag
		mov word[es:3720],0x0cDB
		mov word[es:3722],0x0cDB
		mov word[es:3724],0x0cDB
		;
		mov word[es:3560],0x0cDB
		mov word[es:3562],0x0cDB
		mov word[es:3564],0x0cDB
		;
		mov word[es:3398],0x0eDB;left
		mov word[es:3400],0x0cDB
		mov word[es:3402],0x0cDB
		mov word[es:3404],0x0cDB
		mov word[es:3406],0x0eDB;right
		;----------------------------------------------------------------------Small Obstacle

		mov word[es:3770],0x0cDB
		mov word[es:3772],0x0cDB
		mov word[es:3774],0x0cDB
		;
		mov word[es:3610],0x0cDB
		mov word[es:3612],0x0cDB
		mov word[es:3614],0x0cDB
		;
		mov word[es:3450],0x0cDB
		mov word[es:3452],0x0cDB
		mov word[es:3454],0x0cDB
		;
		mov word[es:3288],0x0eDB
		mov word[es:3290],0x0cDB
		mov word[es:3292],0x0cDB
		mov word[es:3294],0x0cDB
		mov word[es:3296],0x0eDB
		;----------------------------------------------------------------------Large Obstacle
		mov word[es:3808],0x0cDB
		mov word[es:3810],0x0cDB
		mov word[es:3812],0x0cDB
		;
		mov word[es:3648],0x0cDB
		mov word[es:3650],0x0cDB
		mov word[es:3652],0x0cDB
		;
		mov word[es:3486],0x0eDB
		mov word[es:3488],0x0cDB
		mov word[es:3490],0x0cDB
		mov word[es:3492],0x0cDB
		mov word[es:3494],0x0eDB
		;----------------------------------------------------------------------Small Obstacle 2
		push word 3840
		push word 4000
		push word 2
		push word 0x0aDB
		call Flag
		;----------------------------------------------------------Bottom Line green fore and 0 black back
		
		;----------------------------Name
		 mov ax,2
		push ax
		mov ax,0
		push ax
	    mov ax,0x0f
		push ax
		mov ax,message1
		push ax
		push word 4
		call printstr
		;----------------------------
		pop es
		pop bx
		pop ax
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MarioBody:
		call printnum
		push es
		push di
		mov ax,0xb800
		mov es,ax
		mov di,word[cs:ptr]
		;----Legs-----------------
		cmp word[cs:f],0
		je print0
		jmp print1
print0:
		mov word[es:di+160],0x0e2f
		mov word[es:di+162],0x0e6c
		mov word[cs:f],1
		jmp outoflegs
print1:
		mov word[es:di+162],0x0e6c
		mov word[es:di+166],0x0e5c
		mov word[cs:f],0
		
outoflegs:

;-----------------------------

;-----------Main body-----------------
		mov word[es:di],0x09DB
		mov word[es:di+2],0x09DB
		mov word[es:di+4],0x09DB

		mov word[es:di-160],0x09DB
		mov word[es:di-158],0x09DB
		mov word[es:di-156],0x09DB
;---------------------------------------

;---------Hands----------
		mov word[es:di-158],0x0eDD
		mov word[es:di-158],0x0eDE
;-------------------------

;----------Head----------
		mov word[es:di-318],0x3eDC
		mov word[es:di-478],0x03DC
		mov word[es:di-320],0x03DE
		mov word[es:di-316],0x03DD
;------------------------

;----------------------------------------------------------------------Mario
		
		pop di
		pop es
		ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
move:
;testloop:
;------------------------------------------------------------
		push si
		push di
		add word[cs:score],1
		mov si,word[cs:enemyptr]
		mov di,word[cs:ptr]
		sub di,si
		cmp di,162
		pop di
		pop si
		jne exitcheckingrightcollision
		call Blank_Mario
		call Lose
		mov word[cs:ptr],3524
		call MarioBody
		mov word[cs:endgame],0
		
		jmp exitcheckingcollision
	exitcheckingrightcollision:
		push si
		push di
		mov si,word[cs:enemyptr]
		mov di,word[cs:ptr]
		sub di,si
		cmp di,152
		pop di
		pop si
		jne exitcheckingcollision
		call Blank_Mario
		call Lose
		mov word[cs:ptr],3524
		call MarioBody
		mov word[cs:endgame],0
;------------------------------------------------------------		
exitcheckingcollision:
		mov al,0;
		cmp word[cs:endgame],1
		je nomatch
		push ax
		push es
		mov ax, 0xb800
		mov es, ax ; point es to video memory
		in al, 0x60 ; read a char from keyboard port
		
		cmp al, 0x4d ; is the key right arrow
		je right 
		
		cmp al,0x48	; is the key UP arrow
		je up
		
		cmp al,0x4b		; is the key left arrow
		je left
		jmp nomatch
right:
		call moveright
		jmp nomatch
		
up:
		call moveup
		jmp nomatch
left:
		call moveleft
		jmp nomatch

nomatch: 
        ;jmp far [cs:oldkb]
		pop es
		pop ax
		mov al, 0x20
		out 0x20, al ; send EOI to PIC
		;jmp testloop
		iret 
		; mov al, 0x20
		; out 0x20, al 				; send EOI to PIC
		
		; pop ax
		; iret 						; return from interrupt
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
moveright:										;this subroutine will move right
		call Blank_Mario
		add word[cs:ptr],2
		
		;----------------COLLISION DETECTION WITH ENEMY CHARACTER----------------------------------------
		push ax
		push bx
		mov ax,word[cs:ptr]
		mov bx,word[cs:enemyptr]
		sub bx,ax			;by checking the difference between enemy and mario we can check if they are collising or not
		;sub ax,bx
		;cmp ax,2830
		;cmp ax,2746
		;cmp ax,126
		cmp bx,0
		jb changevalueofax_bx
		jmp ignore_changevalueofax_bx
		changevalueofax_bx:
		mov ax,word[cs:ptr]
		mov bx,word[cs:enemyptr]
		sub ax,bx
		mov bx,ax
		
	ignore_changevalueofax_bx:
		cmp bx,0
		ja check_next_value_r
		
		cmp bx,152
		ja check_next_value_r
		jmp ignore_check_next_value_r
		
		check_next_value_r:
		cmp ax,6
		jb change_PTR_r
		cmp ax,166
		jb change_PTR_r
		jmp ignore_check_next_value_r
		change_PTR_r:
			call Blank_Mario
			call Lose
			mov word[cs:ptr],3524
			pop bx
			pop ax
			
		call Blank_Mario
		call MarioBody
		mov word[cs:rightmoveflag],0
		mov word[cs:leftmoveflag],0
	ret
		ignore_check_next_value_r:
			pop bx
			pop ax
		;------------------------------------------------------------------------------------------------

		
								;End of Large Obstacle
		mov si,2978
		End_large_obs:
		cmp word[cs:ptr],si
		je down_largehurdle
		add si,2
		cmp si,3000
		jne End_large_obs
								;---------------- if some one jumps from obstacle#2 to Obstacle#3
		mov si,3002
		End2_large_obs:
		cmp word[cs:ptr],si
		je down_largehurdle_to_small
		add si,2
		cmp si,3020
		jne End2_large_obs
		;--End of First Small Obstacle
		mov si,3088
		End_small_obs_1:
		cmp word[cs:ptr],si
		je down_smallhurdle
		add si,2
		cmp si,3124;3102
		jne End_small_obs_1
		;--;End of Second Small Obstacle
		mov si,3176
		End_small_obs_2:
		cmp word[cs:ptr],si
		je down_smallhurdle
		add si,2
		cmp si,3188
		jne End_small_obs_2
		;--
jmp ign_hurdles

down_largehurdle:
		add word[cs:ptr],480+160+2;480
		call Delay
		jmp ign_hurdles
down_largehurdle_to_small:
		add word[cs:ptr],160+160;;;;;320
		call Delay
		jmp ign_hurdles
down_smallhurdle:
		add word[cs:ptr],320+160+2;;;;;320
		call Delay
		jmp ign_hurdles
ign_hurdles:
		;---------------------------------------------------------Checks for Kingdom
		cmp word[cs:ptr],3174
		jne ign_win
		;;;;;;;;;;;;;;;;;;;;;;;;
		call Background
		call Blank_Mario
		mov word[cs:ptr],3186
		call MarioBody
		call enemy
		call monster
		call You_Win
		
		;;;;;;;;;;
		;mov ax,2
		;push ax
		;mov ax,23
		;push ax
	    ;mov ax,0x8f
		;push ax
		;mov ax,String2
		;push ax
		;push word 24
		;call printstr
		;---------------------- Getting S
		infinite_win2:
		in al,0x60
		cmp al,0x1e
		je ret_main4
		jmp infinite_win2
ret_main4:
		mov al, 0x20 
		out 0x20, al 
		call clear
	    mov word[cs:monsterptr],850
		mov word[cs:enemyptr],3442
		call Lose
		mov word[cs:ptr],3524
		call Background
		call enemy
		call monster
		call MarioBody
		;;;;;;;;;;;;;;;;;;;;;;;;
		;call Blank_Mario
		;mov word[cs:ptr],3186
		;call MarioBody
		;call enemy
		;call monster
		;call You_Win
		;infinte_You_Win_Loop_Right:
		;jmp infinte_You_Win_Loop_Right
		;mov word[es:520],0x0e61
		;cli
		ign_win:
		;mov word[cs:kingdom_flag],1
		;--------------------------------------------------------------------End Checks for Kingdom
		

		;cmp word[cs:ptr],3510
		;ja changevalueofptr
		cmp word[cs:ptr],3392+160;first small obstacle
		je stuck_1
		;cmp word[cs:ptr],3394;first small obstacle
		;je stuck_e
		cmp word[cs:ptr],3442+160;large obstacle
		je stuck_1
		cmp word[cs:ptr],3480+160;second small obstacle
		je stuck_1
		cmp word[cs:ptr],3510+160;second small obstacle
		je stuck_1

		;stuck_e:
		;sub word[cs:ptr],2


		stuck_back:
		call MarioBody
		jmp gotoend
stuck_1:
		 mov word[cs:stuck],1
		 sub word[cs:ptr],2
		 jmp stuck_back  	 

		;checking if right end of screen is reached or not
		cmp word[cs:ptr],3510
		ja changevalueofptr
		cmp word[cs:ptr],3670
		ja changevalueofptr
		cmp word[cs:ptr],3350
		ja changevalueofptr
		cmp word[cs:ptr],3190
		ja changevalueofptr
		cmp word[cs:ptr],3030
		ja changevalueofptr
		cmp word[cs:ptr],3830
		ja changevalueofptr
		cmp word[cs:ptr],3990
		ja changevalueofptr
		call MarioBody
		jmp gotoend
changevalueofptr:
		mov word[cs:ptr],3510
		call MarioBody
gotoend:
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
moveup:											;this subroutine move up / up&right /up&left
		mov word[cs:rightmoveflag],0				;flag responsible for checking to move right or left
		mov word[cs:leftmoveflag],0
		push ax
		push cx
		mov cx,5									;number of steps while jumping
		;call clear
		;call Background
		call Blank_Mario							;print a blank mario in place of mario to remove it
		mov dx,word[cs:ptr]
		mov ax,0

	loopmoveup:			;this loop will move up OR up right/left
		call move_enemy2
		sub word[cs:ptr],160
		call MarioBody
		;----------
 ;------------------------------K I N G D O M 
	    ;;3174
		mov si,3174
	    chk_kingdom_reached_up1_3174:
	    cmp word[cs:ptr],si
	    je win_ret_sj
	    sub si,160
	    cmp si,2374
	    jne chk_kingdom_reached_up1_3174
		;;
		;;3176
		mov si,3176
	    chk_kingdom_reached_up1_3176:
	    cmp word[cs:ptr],si
	    je win_ret_sj
	    sub si,160
	    cmp si,2376
	    jne chk_kingdom_reached_up1_3176
		;;
	;-------------------------------K I N G D O M
		;----------
		cmp word[cs:rightmoveflag],1
		je moveupright

		cmp word[cs:leftmoveflag],1
		je moveupleft

		mov al,0
		in al, 0x60 ; read a char from keyboard port
		cmp al, 0x4d ; is the key right
		je changemoverightflag

		mov al,0
		in al, 0x60 ; read a char from keyboard port
		cmp al, 0x4b ; is the key left 
		je changemoveleftflag

		jmp ignoremoveupright
		
	changemoveleftflag:
		mov word[cs:leftmoveflag],1
		jmp moveupleft
	changemoverightflag:
		mov word[cs:rightmoveflag],1
	moveupright:
		call Blank_Mario
		add word[cs:ptr],4
		call MarioBody
	jmp ignoremoveupright
	
	moveupleft:
		call Blank_Mario
		sub word[cs:ptr],4
		call Background
		call MarioBody
	
	ignoremoveupright:
	jmp ign_win_ret_sj
win_ret_sj:
     jmp temp_win_ret2
ign_win_ret_sj:
	;------------------------------K I N G D O M 
	    ;;3174
		mov si,3174
	    chk_kingdom_reached_up2_3174:
	    cmp word[cs:ptr],si
	    je temp_win_ret2
	    sub si,160
	    cmp si,2374
	    jne chk_kingdom_reached_up2_3174
		;;3176
		mov si,3176
	    chk_kingdom_reached_up2_3176:
	    cmp word[cs:ptr],si
temp_win_ret2:  je temp_win_ret
	    sub si,160
	    cmp si,2376
	    jne chk_kingdom_reached_up2_3176
	;-------------------------------K I N G D O M
		call Delay
		call Blank_Mario
		mov al,0
		sub cx,1
		cmp cx,0
	jne loopmoveup
		
	mov cx,5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	loopmovedown:							;this loop will move down and also check if mario has landed on any hurdle or not
		call move_enemy2
		;call collisiondetectionfromup
		
		;----------------COLLISION DETECTION WITH ENEMY CHARACTER----------------------------------------
		push ax
		push bx
		mov ax,word[cs:ptr]
		mov bx,word[cs:enemyptr]
		sub ax,bx				;by checking the difference between enemy and mario we can check if they are collising or not
		mov bx,ax
		;sub ax,bx
		;cmp ax,2830
		;cmp ax,2746
		;cmp ax,126
		
		cmp bx,150
		jae check_next_value
		jmp ignore_check_next_value
		
		check_next_value:
		cmp ax,166
		jb change_PTR
		jmp ignore_check_next_value
		change_PTR:
			call Blank_Mario
			call Lose
			mov word[cs:ptr],3524
			pop bx
			pop ax
			
		call Blank_Mario
		call MarioBody
		mov word[cs:rightmoveflag],0
		mov word[cs:leftmoveflag],0
		pop cx
		pop ax
	ret
		ignore_check_next_value:
			pop bx
			pop ax
		;------------------------------------------------------------------------------------------------
		
		
		add word[cs:ptr],160
		call Blank_Mario;check
		;------------------------------K I N G D O M 
	    ;;3174
		mov si,3174
	    chk_kingdom_reached_down1_3174:
	    cmp word[cs:ptr],si
temp_win_ret:   je win_ret
	    sub si,160
	    cmp si,2374
	    jne chk_kingdom_reached_down1_3174
		;;3176
		mov si,3176
	    chk_kingdom_reached_down1_3176:
	    cmp word[cs:ptr],si
	    je win_ret
	    sub si,160
	    cmp si,2376
	    jne chk_kingdom_reached_down1_3176
		;;
	;-------------------------------K I N G D O M
jmp ign_win_ret
win_ret:
      jmp win_ret2	
ign_win_ret	
		;-----down stuck condition for obs 1		;if landed on hurdle then dont move down until end of hurdle is reached
		cmp word[cs:ptr],3394+160
		je stuck2_e1
		cmp word[cs:ptr],3396+160
		je stuck2_e2
		cmp word[cs:ptr],3398+160
		je stuck2_e3
		jmp ign_stuck2_e
		stuck2_e1:
		call Background
		sub word[cs:ptr],4+4
		jmp sj_hurdle
		stuck2_e2:
		call Background
		sub word[cs:ptr],6+4
		jmp sj_hurdle
		stuck2_e3:
		call Background
		sub word[cs:ptr],8+4
		jmp sj_hurdle;sj_end_stick_e
		ign_stuck2_e:
		;-----
		;-----down stuck condition for obs 2
		cmp word[cs:ptr],3440+160
		je stuck3_e1
		cmp word[cs:ptr],3442+160
		je stuck3_e2
		cmp word[cs:ptr],3444+160
		je stuck3_e3
		cmp word[cs:ptr],3446+160
		je stuck3_e4
		jmp ign_stuck3_e
		stuck3_e1:
		call Background
		sub word[cs:ptr],6+4
		jmp sj_hurdle
		stuck3_e2:
		call Background
		sub word[cs:ptr],6+4
		jmp sj_hurdle
		stuck3_e3:
		call Background
		sub word[cs:ptr],8+4
		jmp sj_hurdle;sj_end_stick_e
		stuck3_e4:
		call Background
		sub word[cs:ptr],10+4
		jmp sj_hurdle;sj_end_stick_e
		ign_stuck3_e:
		;-----
		;-----down stuck condition for obs 2
		cmp word[cs:ptr],3484+160
		je stuck4_e1
		cmp word[cs:ptr],3486+160
		je stuck4_e2
		cmp word[cs:ptr],3488+160
		je stuck4_e3
		cmp word[cs:ptr],3490+160
		je stuck4_e4
		jmp ign_stuck4_e
		stuck4_e1:
		call Background
		sub word[cs:ptr],6+4
		jmp sj_hurdle
		stuck4_e2:
		call Background
		sub word[cs:ptr],6+4
		jmp sj_hurdle
		stuck4_e3:
		call Background
		sub word[cs:ptr],8+4
		jmp sj_hurdle;sj_end_stick_e
		stuck4_e4:
		call Background
		sub word[cs:ptr],10+4
		jmp sj_hurdle;sj_end_stick_e
		ign_stuck4_e:
		;-----
		call MarioBody
jmp ign_win_ret2
win_ret2:
         jmp win_ret3
ign_win_ret2
		;------------------------------To Stop Over Hurdle
		;-----------First Small Obstacle
		mov si,3072
	    chk_small_obs_1:
	    cmp word[cs:ptr],si
	    je sj_hurdle
	    add si,2
	    cmp si,3086
	    jne chk_small_obs_1
		;;;;;;;;;Large Obstacle
		mov si,2962
	    chk_large_obs_1:
	    cmp word[cs:ptr],si
	    je sj_hurdle
	    add si,2
	    cmp si,2976
	    jne chk_large_obs_1
		;;;;;;;;;second small
		mov si,3160
	    chk_small_obs_2:
	    cmp word[cs:ptr],si
	    je sj_hurdle
	    add si,2
	    cmp si,3174
	    jne chk_small_obs_2
		;--
		jmp ign_this2
sj_hurdle:
        mov word[cs:down],1
        jmp hurdle
		ign_this2:
		
		cmp word[cs:rightmoveflag],1
		je movedownright
		
		cmp word[cs:leftmoveflag],1
		je sj_movedownleft
		mov al,0
		in al, 0x60 ; read a char from keyboard port
		cmp al, 0x4d ; is the key right
		je changemoverightflag2
		jmp ignoremovedownright
	
		mov al,0
		in al, 0x60 ; read a char from keyboard port
		cmp al, 0x4b ; is the key left 
		je changemoveleftflag
	    jmp ignoremovedownright
	changemoveleftflag2:
		mov word[cs:leftmoveflag],1
		jmp sj_movedownleft
	changemoverightflag2:
		mov word[cs:rightmoveflag],1
		jmp ign_this

sj_movedownleft:
         jmp movedownleft
    ign_this:	 
	movedownright:
		call Blank_Mario
		add word[cs:ptr],4
		;------------------------------K I N G D O M
	    ;;3174
		mov si,3174
	    chk_kingdom_reached_down2_3174:
	    cmp word[cs:ptr],si
	    je win_ret3
	    sub si,160
	    cmp si,2374
	    jne chk_kingdom_reached_down2_3174
		;;3176
		mov si,3176
	    chk_kingdom_reached_down2_3176:
	    cmp word[cs:ptr],si
	    je win_ret3
	    sub si,160
	    cmp si,2376
	    jne chk_kingdom_reached_down2_3176
		;;
	;-------------------------------K I N G D O M
		;-----down stuck condition
		cmp word[cs:ptr],3394+160
		je stuck_e1
		cmp word[cs:ptr],3396+160
		je stuck_e2
		cmp word[cs:ptr],3398+160
		je stuck_e3
		jmp ign_stuck_e
		stuck_e1:
		call Background
		sub word[cs:ptr],4
		jmp sj_hurdle2
		stuck_e2:
		call Background
		sub word[cs:ptr],6
		jmp sj_hurdle2;sj_end_stick_e
		stuck_e3:
		call Background
		sub word[cs:ptr],8
		jmp sj_hurdle2;sj_end_stick_e
		ign_stuck_e:
		;-----
jmp ign_win_ret3
win_ret3:
         jmp win
ign_win_ret3
		;-----down stuck condition for obs 2
		cmp word[cs:ptr],3440+160
		je stuck5_e1
		cmp word[cs:ptr],3442+160
		je stuck5_e2
		cmp word[cs:ptr],3444+160
		je stuck5_e3
		cmp word[cs:ptr],3446+160
		je stuck5_e4
		jmp ign_stuck5_e
		stuck5_e1:
		call Background
		sub word[cs:ptr],6
		jmp sj_hurdle2
		stuck5_e2:
		call Background
		sub word[cs:ptr],6
		jmp sj_hurdle2
		stuck5_e3:
		call Background
		sub word[cs:ptr],8
		jmp sj_hurdle2;sj_end_stick_e
		stuck5_e4:
		call Background
		sub word[cs:ptr],10
		jmp sj_hurdle2;sj_end_stick_e
		ign_stuck5_e:
		;-----
		;-----down stuck condition for obs 2
		cmp word[cs:ptr],3484+160
		je stuck6_e1
		cmp word[cs:ptr],3486+160
		je stuck6_e2
		cmp word[cs:ptr],3488+160
		je stuck6_e3
		cmp word[cs:ptr],3490+160
		je stuck6_e4
		jmp ign_stuck6_e
		stuck6_e1:
		call Background
		sub word[cs:ptr],8
		jmp sj_hurdle2
		stuck6_e2:
		call Background
		sub word[cs:ptr],8
		jmp sj_hurdle2
		stuck6_e3:
		call Background
		sub word[cs:ptr],10
		jmp sj_hurdle2;sj_end_stick_e
		stuck6_e4:
		call Background
		sub word[cs:ptr],10
		jmp sj_hurdle2;sj_end_stick_e
		ign_stuck6_e:
		;-----------First Small Obstacle
		mov si,3072
	    chk2_small_obs_1:
	    cmp word[cs:ptr],si
	    je sj_hurdle2
	    add si,2
	    cmp si,3086
	    jne chk2_small_obs_1
		;;;;;;;;;Large Obstacle
		mov si,2962
	    chk2_large_obs_1:
	    cmp word[cs:ptr],si
	    je sj_hurdle2
	    add si,2
	    cmp si,2976
	    jne chk2_large_obs_1
		;;;;;;;;;second small
		mov si,3160
	    chk2_small_obs_2:
	    cmp word[cs:ptr],si
	    je sj_hurdle2
	    add si,2
	    cmp si,3174
	    jne chk2_small_obs_2
		;--
	jmp ign_this3
	sj_hurdle2:
	    mov word[cs:down],1
		jmp hurdle
    ign_this3	
		call MarioBody
	jmp ignoremovedownright
	
	movedownleft:
		call Blank_Mario
		sub word[cs:ptr],4
		call MarioBody
		
	ignoremovedownright:
		;call Delay
		call Delay
		;call clear
		;call Background
		call Blank_Mario		
		mov al,0
		sub cx,1
		cmp cx,0
		jne loopmovedown
		;je hurdle
		;;;;;;;;;;;;;;;;;;;;;;;;
		;jmp hurdle
		
		;------------------BELOW CODE WILL GET MARIO TO THE GROUND IF IT--------------------
		;						JUMPS WHILE STANDING ON THE HURLDE
		je looptogetmariodowntoground

	looptogetmariodowntoground:
		cmp word[cs:ptr],3524
		jb getthemariodowntoground 
		jmp hurdle
		
		getthemariodowntoground:
			add word[cs:ptr],160
			cmp word[cs:ptr],3524
			jb getthemariodowntoground
		;jne loopmovedown
		
    ;------------------------------------------------------------------------------------------
	
	;add dx,ax
	;mov word[cs:ptr],dx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
jmp ign_win_up
win:								;this loop will word for win scren adn take A input form user
        ;cmp word[cs:ptr],3174
		;jne ign_win
		call Background
		call Blank_Mario
		mov word[cs:ptr],3186
		call MarioBody
		call enemy
		call monster
		call You_Win
		
		;;;;;;;;;;
		;mov ax,2
		;push ax
		;mov ax,23
		;push ax
	    ;mov ax,0x8f
		;push ax
		;mov ax,String2
		;push ax
		;push word 24
		;call printstr
		;---------------------- Getting S
		infinite_win:
		in al,0x60
		cmp al,0x1e
		je ret_main3
		jmp infinite_win
ret_main3:
		mov al, 0x20 
		out 0x20, al 
		call clear
	    mov word[cs:monsterptr],850
		mov word[cs:enemyptr],3442
		mov word[cs:score],0
		mov word[cs:ptr],3524
		call Background
		call enemy
		call monster
		call MarioBody
		;cli
		;ign_win:
jmp win_ign_hurdle	
ign_win_up:
hurdle:	
		call Blank_Mario
		call MarioBody
		win_ign_hurdle:
		mov word[cs:rightmoveflag],0
		mov word[cs:leftmoveflag],0
		pop cx
		pop ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
moveleft:			;this subroutine will move left
		;call clear
		;call Background 
		cmp word[cs:ptr],3524
		je exit_moveleft
		jmp ignore_exit_moveleft
		exit_moveleft:
			ret
	ignore_exit_moveleft:
		call Blank_Mario
		sub word[cs:ptr],2
		
		mov si,2962
		cmp word[cs:ptr],si
		je down_largehurdle1

		
		mov si,3072
		cmp word[cs:ptr],si
		je down_smallhurdle1

		
		mov si,3160
		cmp word[cs:ptr],si
		je down_smallhurdle1
		jmp ignorehurdles

	down_largehurdle1:
		add word[cs:ptr],480+160;480
		sub word[cs:ptr],2
		call Delay
		jmp ignorehurdles
		
	down_smallhurdle1:
		add word[cs:ptr],320+160;480
		sub word[cs:ptr],2
		call Delay
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ignorehurdles:
		;3670
		;3364
		cmp word[cs:ptr],3364 	
		jb changevalueofptr_left

		cmp word[cs:ptr],3408+160;first small obstacle
		je stuck_2
		cmp word[cs:ptr],3458+160;large obstacle
		je stuck_2
		cmp word[cs:ptr],3496+160;second small obstacle
		je stuck_2
		stuck_back_2:
		call MarioBody
		jmp gotoend
stuck_2:
		mov word[cs:stuck],1
		add word[cs:ptr],2
		jmp stuck_back_2  	 

		cmp word[cs:ptr],3364 	
		jb changevalueofptr_left

		call MarioBody
		jmp gotoend_left
changevalueofptr_left:
		cmp word[cs:ptr],3360
		jb gotoend_left
		mov word[cs:ptr],3364+160 
		;call MarioBody
gotoend_left:
	call MarioBody
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
clear:;For clear screen
		push ax
		push es
		push di
		push si
		mov ax,0xB800
		mov es,ax
		mov di,0
		mov si,4000
l1:
		mov word[es:di],0x0720
		add di,2
		cmp di,si
		jne l1
		pop si
		pop di
		pop es
		pop ax
		ret
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Flag:
		push bp
		mov bp,sp
		push ax
		push bx
		push di
		push cx
		push es

		mov ax,0xb800
		mov es,ax
		mov ax,[bp+4]
		mov bx,[bp+6]
		mov cx,[bp+8]
		mov di,[bp+10]
gen_loop:
		mov word[es:di],ax
		add di,bx
		cmp di,cx
		jne gen_loop
		pop es
		pop cx
		pop di
		pop bx
		pop ax
		pop bp

		ret 8
		;-------------------------------------------------------------


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Start:
        call StartGame
		call clear
		call Background
		call MarioBody
		call monster
		xor ax, ax
		mov es, ax 					; point es to IVT base
		mov ax, [es:9*4]
		mov [oldkb], ax 			; save offset of old routine
		mov ax, [es:9*4+2]
		mov [oldkb+2], ax 			; save segment of old routine
		cli 						; disable interrupts
		mov word [es:8*4], move_enemy 	; store offset at n*4
		mov [es:8*4+2], cs 			; store segment at n*4+

		mov word [es:9*4], move 	; store offset at n*4
		mov [es:9*4+2], cs 			; store segment at n*4+2
		sti 						; enable interrupts
		
		mov dx, Start				 ; end of resident portion
		add dx, 15 					; round up to next para
		mov cl, 4
		shr dx, cl 						; number of paras
		mov ax, 0x3100				 ; terminate and stay resident
		int 0x21 	
		
