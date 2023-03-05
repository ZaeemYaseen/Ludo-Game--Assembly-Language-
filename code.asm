;Coded by Zaeem Muhammad Yaseen 20F-0329
; Hamza Sajjad 20F-0297
; Mubashir Ijaz 20F-0220

include	Irvine32.inc
includelib Irvine32.lib

BUFFER_SIZE = 501
;========================================
crushrow proto,r :DWORD,col:DWORD
crushcol proto,r :DWORD,col:DWORD
;========================================
;=============table3=====================
crushrow3 proto,r3 :DWORD,coltable_3:DWORD
blastrow3 proto,blastrow :DWORD,blastcol:DWORD
crushcol3 proto,rcol3 :DWORD,col3:DWORD
blastcol3 proto,ebx_row3 :DWORD,esi_col3:DWORD
.data
;==============credits==================
project byte "   ====================COMPIUTER ORGANIZATION AND ASSEMBLY LANGUAGE PROJECT====================",0
partner1 byte "			==>		ZAEEM MUHAMMAD YASEEN     20F-0329",0
partner2 byte "			==>		HAMZA SAJJAD              20F-0297",0
partner3 byte "			==>		MUHAMMAD MUBASHIR IJAZ    20F-0220",0

;============== BOARD ===================
Table Dword 10 dup (0)
rowsize = ($-Table)
	Dword	10 dup (0)
	Dword	10 dup (0)
	Dword	10 dup (0)
	Dword	10 dup (0)
	Dword	10 dup (0)
	Dword	10 dup (0)
	Dword	10 dup (0)
	Dword	10 dup (0)
	Dword	10 dup (0)

space byte "    ",0
rowspaces byte "                  ",0
col_num byte "             |   0   |   1    |   2    |   3    |   4    |   5    |   6    |   7    |   8    |   9    |",0
small_lines byte "             |-------|--------|--------|--------|--------|--------|--------|--------|--------|--------|",0
vertical_line byte "  | ",0
num DWORD 0
jagha byte "   ",0
;========================================
;			USER INPUT
name_str byte "   ==>   PLAYER NAME: ",0
Scores byte "  ==>   SCORES: ",0
name dword ?
enterrow1 byte "   ==>   ENTER ROW NUMBER: ",0
entercol1 byte "   ==>   ENTER COLUMN NUMBER: ",0
input2 byte "   ==>   ENTER '1' TO MOVE IT UPWARD, '2' TO MOVE IT LEFTWARD, '3' TO MOVE IT RIGHTWARD, '4' TO MOVE IT DOWNWARD: ",0
input2_1 byte "   ==>   Enter '3' TO MOVE IT RIGHTWARD, '4' TO MOVE IT DOWNWARD: ",0
input2_2 byte "   ==>   Enter '2' TO MOVE IT LEFTWARD, '4' TO MOVE IT DOWNWARD: ",0
input2_3 byte "   ==>   Enter '2' TO MOVE IT LEFTWARD, '3' for TO MOVE IT RIGHTWARD, '4' TO MOVE IT DOWNWARD: ",0
input2_4 byte "   ==>   Enter '1' MOVE IT UPWARD, '3' for TO MOVE IT RIGHTWARD: ",0
input2_5 byte "   ==>   Enter '1' MOVE IT UPWARD, '2' TO MOVE IT LEFTWARD: ",0
input2_6 byte "   ==>   Enter '1' MOVE IT UPWARD, '2' TO MOVE IT LEFTWARD, '3' TO MOVE IT RIGHTWARD: ",0
input2_7 byte "   ==>   Enter '1' MOVE IT UPWARD, '3' for TO MOVE IT RIGHTWARD, '4' TO MOVE IT DOWNWARD: ",0
input2_8 byte "   ==>   Enter '1' MOVE IT UPWARD, '2' TO MOVE IT LEFTWARD, '4' TO MOVE IT DOWNWARD: ",0
Row1 Dword ?
Col1 Dword ? 
Row2 Dword ?
Col2 Dword ?
wronginput byte "   ==>   ERROR.          ENTER VALID OPTION (1/2/3/4 FROM THE GIVEN CHOICES): ",0
wronginput1 byte "   ==>   ERROR.          VALUES BETWEEN (0 -> 9) ARE ALLOWED:  ",0
notallowed byte "	==> 	THE DESIRED NUBER IS PROHIBITED FOR SWAPPING.",0
;========================================

temp1 DWORD 0
temp_ebx DWORD 0
temp_esi DWORD 0

tempecx DWORD 0
points DWORD 0
colnum DWORD 0
rownum DWORD 0
temp_col DWORD 0
checkalltable DWORD 0
trow1 DWORD 0
trow2 DWORD 0
trow3 DWORD 0
tesi dword 0
tedx dword 0

dis_congrats byte "			=============================== CONGRATULATIONS LEVEL CONPLETED =============================== ",0
lvl_1 byte "			==================================== LEVEL-1 ==================================== ",0
lvl_2 byte "			==================================== LEVEL-2 ==================================== ",0
lvl_3 byte "			==================================== LEVEL-3 ==================================== ",0
;=================================================
input_name_msg byte "ENTER PLAYER NAME:",0
playername byte 30 Dup(?)
moves byte 0    ; moves
score byte 0    ; score
;=================================================
;For LEvel 2
minispace byte " ",0
lines byte "                                       |--------|--------|--------|--------|",0
counterforline Dword 0
count Byte 0
;=================================================
print macro text
local string
.data
string byte text,0
.code
	mov eax, lightgreen
	call settextcolor
mov edx, offset string
call writestring

endm
;=================================================
buffer BYTE BUFFER_SIZE DUP(?)
filename BYTE "highest_score.txt",0
fileHandle HANDLE ?
stringLength DWORD ?
bytesWritten DWORD ?
str1 BYTE "COULDN'T CREATE FILE",0dh,0ah,0
str2 BYTE "Bytes written to file [highest_score.txt]:",0
str3 BYTE "Enter up to 500 characters and press"
 BYTE "[Enter]: ",0dh,0ah,0
 ;=================================================
.code
main PROC

	call teamwork
	call create_write_file
	;call inputplayer
	call lvl1
	exit
main ENDP
;======================================
formatting PROC

	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
	call crlf
	ret
formatting ENDP
;======================================
teamwork PROC

	call formatting
	mov eax, red
	call settextcolor
	mov edx,offset project
	call writeString
	call crlf
	call crlf

	mov eax, blue
	call settextcolor
	mov edx,offset partner1
	call writeString
	call crlf
	call crlf

	mov eax, green
	call settextcolor
	mov edx,offset partner2
	call writeString
	call crlf
	call crlf

	mov eax, brown
	call settextcolor
	mov edx,offset partner3
	call writeString
	call crlf

	call waitMsg
	call clrscr
	ret
teamwork ENDP
;=======================================
crush3 proc
again_col:
call column3
mov eax,checkalltable
cmp eax,0
je again_col
mov checkalltable,0
again_row:
call Roww3
mov eax,checkalltable
cmp eax,0
je again_row
ret
crush3 endp
;========================================
lvl1 proc
;call crush3
mov points,0
	mov moves,14
	call populateBoard
	mov ecx, 2
	L1:
	push ecx
	mov eax, lightred
	call settextcolor
	mov edx, offset lvl_1
	call writestring
	call crlf
	call crlf
	call displayplayer
	call PrintTable
	call userinput
	call crush3
	pop ecx
	call clrscr   ; clear screen
	dec moves
	loop L1

	call formatting
	mov edx,offset dis_congrats
	call writeString
	call crlf

	call crlf
	call waitmsg

	call lvl2
	ret
lvl1 endp
;========================================
lvl2 proc
	call clrscr   ; clear screen
	mov moves,14
    call populateboard2
	mov ecx, 5
	L1:
	push ecx
	mov eax, lightred
	call settextcolor
	mov edx, offset lvl_2
	call writestring
	call crlf
	call displayplayer
	call color_board
	call PrintTable2
	call userinput
call crush
call plus_board
	pop ecx
	call clrscr   ; clear screen
	dec moves
	loop L1

	mov edx,offset dis_congrats
	call writeString
	call crlf	

	call waitmsg

	call lvl3
	ret
lvl2 endp
;========================================
lvl3 proc
	call clrscr   ; clear screen
	mov moves,14
	call populateBoard3
	mov ecx, 14
	L1:
	push ecx
	call displayplayer
	call crlf
	call PrintTable3
	call userinput
	call crush3
	pop ecx
	call clrscr   ; clear screen
	dec moves
	loop L1
	call crlf
	call waitmsg
	ret
lvl3 endp
;========================================
; input procedure check for all the cases
; input options is called
 userinput proc
 call crlf
 Again:	
	Mov edx,offset enterrow1
	call writestring
	call readdec
	Mov Row1,eax

	cmp row1,9
	ja error
	jbe proceed
	error:   ; if input is invalid
	mov edx,offset wronginput1
	call writestring
	jmp Again

	proceed: ; if input is valid
	Mov edx,offset entercol1
	call writestring
	call readdec
	Mov Col1,eax

	cmp col1,9
	ja error1
	jbe proceed1

	error1:   ; if input is invalid
	mov edx,offset wronginput1
	call writestring
	jmp proceed

	proceed1: ; if input is valid
;------------------------------------------------------
	cmp Row1,0
	je zero				; checking for special cases
	cmp row1,9
	je nine
	cmp col1,0
	je zero1
	cmp col1,9
	je nine1
	mov ebx, 0 ; for normal case (again)
	call Input_options  ; calling proc if no special case
	ret
	zero:  ; row1==0
	cmp col1, 0
	je zz
	cmp col1,9
	je zn
	jb zb 
	zz: ; (0,0)
	mov ebx,1
	call Input_options
	ret
	zn: ;(0,9)
	mov ebx, 2
	call Input_options
	ret
	zb: ;(0, 1-8)
	mov ebx, 3
	call Input_options
	ret
	nine:  ; row1==9 
	cmp col1, 0
	je nz
	cmp col1,9
	je nn
	jb nb 
	nz: ;(9,0)
	mov ebx, 4
	call Input_options
	ret
	nn: ;(9,9)
	mov ebx, 5
	call Input_options
	ret
	nb: ;(9, 1-8)
	mov ebx, 6
	call Input_options
	ret
	zero1: ; (1-8, 0)
	mov ebx, 7
	call Input_options
	ret
	nine1: ;(1-8,9)
	mov ebx, 8
	call Input_options
	ret
	;For crushing

	ret
 userinput endp
 ;========================================
; For 2nd input
Input_options proc
	cmp ebx, 0
	je again
	cmp ebx,1
	je again1
	cmp ebx,2
	je again2
	cmp ebx,3
	je again3
	cmp ebx,4
	je again4
	cmp ebx,5
	je again5
	cmp ebx,6
	je again6
	cmp ebx,7
	je again7
	cmp ebx,8
	je again8
;-------------------
Again1:
	Mov edx,offset input2_1
	call writestring
	call crlf

	call readint
	
	cmp eax, 4
	ja error1
	cmp eax, 1
	je error1
	cmp eax, 2
	je error1
	jne proceed

	error1:   ; if input is invalid
	mov edx,offset wronginput
	call writestring
jmp Again1
;-------------------
Again2:
	Mov edx,offset input2_2
	call writestring
	call crlf

	call readint
	
	cmp eax, 4
	ja error2
	cmp eax, 1
	je error2
	cmp eax, 3
	je error2
	jne proceed

	error2:   ; if input is invalid
	mov edx,offset wronginput
	call writestring
jmp Again2
;-------------------
Again3:
	Mov edx,offset input2_3
	call writestring
	call crlf

	call readint
	
	cmp eax, 4
	ja error3
	cmp eax,1
	je error3
	jne proceed

	error3:   ; if input is invalid
	mov edx,offset wronginput
	call writestring
jmp Again3
;-------------------
Again4:
	Mov edx,offset input2_4
	call writestring
	call crlf

	call readint
	
	cmp eax, 4
	jnb error4
	cmp eax, 2
	je error4
	jne proceed

	error4:   ; if input is invalid
	mov edx,offset wronginput
	call writestring
jmp Again4
;-------------------
Again5:
	Mov edx,offset input2_5
	call writestring
	call crlf

	call readint
	
	cmp eax, 3
	jnb error5
	jne proceed

	error5:   ; if input is invalid
	mov edx,offset wronginput
	call writestring
jmp Again5
;-------------------
Again6:
	Mov edx,offset input2_6
	call writestring
	call crlf

	call readint
	
	cmp eax, 4
	jnb error6
	jne proceed

	error6:   ; if input is invalid
	mov edx,offset wronginput
	call writestring
jmp Again6
;-------------------
Again7:
	Mov edx,offset input2_7
	call writestring
	call crlf

	call readint
	
	cmp eax, 4
	ja error7
	cmp eax, 2
	je error7
	jne proceed

	error7:   ; if input is invalid
	mov edx,offset wronginput
	call writestring
jmp Again6
;-------------------
Again8:
	Mov edx,offset input2_8
	call writestring
	call crlf

	call readint
	
	cmp eax, 4
	ja error8
	cmp eax, 3
	je error8
	jne proceed

	error8:   ; if input is invalid
	mov edx,offset wronginput
	call writestring
jmp Again6
;-------------------
Again:
	Mov edx,offset input2
	call writestring
	call crlf

	call readint
	
	cmp eax, 4
	ja error
	jbe proceed

	error:   ; if input is invalid
	mov edx,offset wronginput
	call writestring
	jmp Again
;-------------------
	proceed:  ; if input is valid
	cmp eax, 1
	je one
	cmp eax,2
	je two
	cmp eax, 3
	je three
	cmp eax, 4
	je four 

	one: 
	mov eax, row1
	dec eax
	mov row2, eax
	mov eax, col1
	mov col2, eax
	jmp to_swap

	two:
	mov eax, col1
	dec eax
	mov col2, eax
	mov eax, row1
	mov row2, eax
	jmp to_swap

	three:
	mov eax, col1
	inc eax
	mov col2, eax
	mov eax, row1
	mov row2, eax
	jmp to_swap

	four:
	mov eax, row1
	inc eax
	mov row2, eax
	mov eax, col1
	mov col2, eax
	jmp to_swap

	to_swap:
	call swap ; calling swap()

	ret
Input_options endp
 ;========================================
  ; SWAP INDEX
  ; called inside input options
swap proc  
  Mov ebx,offset Table
  mov eax,rowsize
  
  mul Row1

  Mov ebx, eax
  mov esi,Col1
  Mov eax,Table[ebx+esi*Type Table]

  push eax

  Mov edx,offset Table
  mov eax,rowsize
  
  Mul Row2
  
  add edx, eax
  mov edi,Col2
  Mov ecx,Table[edx+edi*Type Table]

  pop eax

  Mov Table[ebx+esi*Type Table],ecx

  Mov Table[edx+edi*Type Table],eax
 
  ret
  swap endp
;========================================
populateBoard Proc
	Mov ecx,10
	Mov ebx,0
	Mov esi,0
	
Label1:
	push ecx
	Mov ecx,10
	Mov esi,0
	
	Label2:		
		Mov eax,5		; Random Number Range (0-5)
		call randomRange
		inc eax	; Add 1 for range (1-5)
		cmp eax,5
		jne neechy
		mov ax,'B'
		neechy:
		mov Table[ebx+esi], eax
		mov eax,0
		add esi,type Table 
	Loop Label2
		pop ecx
		add ebx, rowsize
Loop Label1
ret
populateBoard endp
;========================================
; Sets different colors for different values
color_board proc
	cmp eax,1 
	je rad
	cmp eax,2 
	je bron
	cmp eax,3 
	je gren
	cmp eax,4 
	je blu
	cmp eax,5 
	je litmag

	rad:
	mov eax, red
	call settextcolor
	ret
	bron:
	mov eax, brown
	call settextcolor
	ret
	gren:
	mov eax, lightgreen
	call settextcolor
	ret
	blu:
	mov eax, blue
	call settextcolor
	ret
	litmag:
	mov eax, lightmagenta
	call settextcolor
ret
color_board endp

;========================================
PrintTable Proc	

	call crlf
	mov edx, offset col_num
	call writeString
	call crlf

	Mov ecx,10
	Mov ebx,0
	Mov esi,0
	
Label3:
	push ecx
	Mov ecx,10
	call crlf
	Mov esi,0
	mov edx, offset rowspaces
	call writeString
	Label4:
	mov eax, Table[ebx+esi]
	push eax 
	call color_board  ; for coloring board()
	pop eax
	cmp eax,'B'
	jne neechy
	call writechar   ; Printing Bombs
	jmp done
	neechy:
	call WriteDec
	done:
	mov eax, lightblue
	call settextcolor
	mov edx, offset vertical_line
	call WriteString
	mov edx, offset space
	call WriteString
	add esi, type Table
	Loop Label4
	call crlf
	pop ecx
	add ebx, rowsize
	mov eax, lightcyan
	call settextcolor
	mov edx, offset small_lines
	call WriteString
	Loop Label3

ret
PrintTable endp
;==========================================
; Now procs for crushing
crush proc
again_col:
call column
mov eax,checkalltable
cmp eax,0
je again_col
again_row:
call Roww
mov eax,checkalltable
cmp eax,0
je again_row
;cmp 
ret
crush endp
;==========================================
;  checking Row
Roww proc
mov ebx,0
mov ecx,10
mov rownum,0
mov checkalltable,1
loop1:
mov esi,0
push ecx
mov ecx,8
l1:
mov eax,table[ebx+esi]
cmp eax,0
je last
mov temp1,eax


add esi,type table
mov eax,table[ebx+esi]
cmp eax,0
je last

cmp eax,temp1
je Same
jmp last

same:
add esi,type table
mov eax,table[ebx+esi]
cmp eax,temp1
jne l

push ebx
push esi
push ecx

invoke crushrow ,ebx,esi
pop ecx
pop esi
pop ebx
inc points
mov checkalltable,0

l:
sub esi,type table
last:
loop l1
pop ecx
add ebx,rowsize
inc rownum
loop loop1
ret
Roww endp
;==========================================
; Checking Column 
column proc
mov checkalltable,1
mov esi,0
mov ecx,10

loop1:
mov colnum,0
mov ebx,0
push ecx
mov ecx,8
l1:
mov eax,table[ebx+esi]
mov temp1,eax
inc colnum

add ebx,rowsize
mov eax,table[ebx+esi]

cmp eax,temp1
je Same

jmp last
same:
add ebx,rowsize
mov eax,table[ebx+esi]
cmp eax,temp1
jne l
push ebx
push esi
invoke crushcol ,ebx,esi
pop esi
pop ebx
mov eax,0
inc points
mov checkalltable,eax
l:
sub ebx,rowsize

last:
loop l1
pop ecx
add esi,type table
loop loop1
ret
column endp
;==========================================
;	crushcol procedure 
crushcol proc, r:DWORD,col :DWORD
mov ebx,r
mov esi,col
add colnum,2
mov eax,colnum
mov temp_col,eax

push colnum
again:
cmp eax,3
jbe outt
sub ebx,rowsize
sub ebx,rowsize
sub ebx,rowsize
mov edx,table[ebx+esi]
add ebx,rowsize
add ebx,rowsize
add ebx,rowsize
mov table[ebx+esi],edx
sub ebx,rowsize
dec eax
jmp again
outt:
sub ebx,rowsize
sub ebx,rowsize
mov eax,4
call randomrange
inc eax
mov table[ebx+esi],eax
add ebx,rowsize
mov eax,4
call randomrange
inc eax
mov table[ebx+esi],eax
add ebx,rowsize
mov eax,4
call randomrange
inc eax
mov table[ebx+esi],eax
mov ebx,r
pop colnum
mov colnum,1
ret
crushcol endp
;==========================================
;	Crushrow procedure 
crushrow proc, r:DWORD,col :DWORD
mov ebx,r
mov esi,col
sub esi,8
mov eax,rowsize
push ebx
mov temp1,ebx
mov ecx,rownum
pop ebx
cmp ecx,0
je last
l2:
mov eax,ebx
sub ebx,rowsize
mov temp1,ebx
mov eax,table[ebx+esi]
mov trow1,eax
add esi,type table
mov eax,table[ebx+esi]
mov trow2,eax
add esi,type table
mov eax,table[ebx+esi]
mov trow3,eax
add ebx,rowsize
sub esi,8
mov eax,trow1
mov table[ebx+esi],eax
add esi,type table
mov eax,trow2
mov table[ebx+esi],eax
add esi,type table
mov eax,trow3
mov table[ebx+esi],eax
sub esi,8
mov ebx,temp1
loop l2
last:
mov ebx,0
mov eax,5
call randomrange
inc eax
mov table[ebx+esi],eax
add esi,type table
mov eax,5
call randomrange
inc eax
mov table[ebx+esi],eax
add esi,type table
mov eax,5
call randomrange
inc eax
mov table[ebx+esi],eax
ret
crushrow endp
;==============================================================
; >>>>>   LEVEL 2   <<<<<<
;==============================================================
 populateboard2 proc
 Mov ecx,10
	Mov ebx,0
	Mov esi,0
	
	
Label1:
	push ecx
	Mov ecx,10
	Mov esi,0
	
	Label2:		
		Mov eax,5		; Random Number Range (0-5)
		call randomRange
		inc eax			; Add 1 for range (1-5)
		mov Table[ebx+esi], eax
		mov eax,0
		add esi,type Table
	Loop Label2
		pop ecx
		add ebx, rowsize
Loop Label1
;==============================================================
call plus_board



 ret
 populateboard2 endp
 ;==============================================================
 plus_board proc
 ; making plus board 
 Mov ecx,10
	Mov ebx,0
	Mov esi,0
	Mov eax,0
	Mov edx,0

Label11:

	push ecx
	mov ecx,10
	mov esi,0
	Label12:
	
	cmp eax,3
	jb condition1
	jmp othercondition1
	condition1:
	cmp edx,3
	jb makezero

othercondition1:
	cmp eax,3		
	jb condition2
	jmp othercondition2	
	condition2:
	cmp edx,6
	ja makezero

othercondition2:
	cmp eax,3
	ja condition3
	jmp othercondition3
	condition3:
	cmp eax,6
	jb condition4
	jmp othercondition3
	condition4:
	cmp edx,3
	jae condition5
	jmp othercondition3
	condition5:
	cmp edx,6
	jbe makezero

othercondition3:
	cmp eax,6
	ja condition6
	jmp othercondition4
	condition6:
	cmp edx,3
	jb makezero

othercondition4:
cmp eax,6
ja condition7
jmp again
condition7:
cmp edx,6
ja makezero

	again:
	inc edx
	add esi,type Table
	jmp nextiteration
	makezero:
	mov Table[ebx+esi], 0

	jmp again
	nextiteration:
	Loop Label12
		mov edx,0
	inc eax
	pop ecx
	add ebx,rowsize
Loop Label11
 ret
 plus_board endp
;==============================================================
;	 print table2 
 printtable2 proc

	Mov ecx,10
	Mov ebx,0
	Mov esi,0
	
Label3:
	push ecx
	Mov ecx,10
	Mov esi,0

	call label14_proc

		pop ecx
		add ebx, rowsize
		mov eax, lightcyan
	    call settextcolor
		mov edx, offset small_lines
		call WriteString
Loop Label3
 ret
 printtable2 endp
 ;===================================================
 label14_proc proc
 	call crlf
	mov edx, offset rowspaces
		call WriteString
 		Label4:			
	mov eax, Table[ebx+esi]
		cmp eax,0
		je skip
		push eax
		call color_board
		pop eax
		call WriteDec
		jmp noskip
		skip:
		mov edx, offset minispace
		call WriteString
		noskip:
		mov eax, lightblue
		call settextcolor
		mov edx, offset vertical_line
		call WriteString
		mov edx, offset space
		call WriteString
		add esi, type Table
	Loop Label4
			call crlf
			ret
 label14_proc endp
;=====================================================
;	Table3 row checking 
roww3 proc
mov ebx,0
mov ecx,10
mov rownum,0
mov checkalltable,1
loop1:
mov esi,0
push ecx
mov ecx,8
l1:
mov eax,table[ebx+esi]
cmp eax,0
je last
mov temp1,eax

add esi,type table
mov eax,table[ebx+esi]
cmp eax,0
je last

cmp eax,temp1
je Same
jmp last
same:
add esi,type table
mov eax,table[ebx+esi]
cmp eax,temp1
jne l

push ebx
push esi
push ecx
call check_crush
pop ecx
pop esi
pop ebx
inc points
l:
sub esi,type table
last:
loop l1
pop ecx
add ebx,rowsize
inc rownum
loop loop1
ret
roww3 endp
;==============================================================
;	check_crush 
check_crush proc
mov checkalltable,0
cmp eax,'B'
jne neechy
invoke blastrow3 ,ebx,esi
add points,10
jmp done
neechy:
invoke crushrow3 ,ebx,esi
inc points
done:
ret
check_crush endp
;==============================================================
;/////////////////////////////Crushrow3//////////////////////////
crushrow3 proc, r3:DWORD,coltable_3 :DWORD
mov ebx,r3
mov esi,coltable_3
sub esi,8
mov eax,rowsize
push ebx
mov temp1,ebx
mov ecx,rownum
pop ebx
cmp ecx,0
je last
l2:
mov eax,ebx
sub ebx,rowsize
mov temp1,ebx
mov eax,table[ebx+esi]
mov trow1,eax
add esi,type table
mov eax,table[ebx+esi]
mov trow2,eax
add esi,type table
mov eax,table[ebx+esi]
mov trow3,eax
add ebx,rowsize
sub esi,8
mov eax,trow1
mov table[ebx+esi],eax
add esi,type table
mov eax,trow2
mov table[ebx+esi],eax
add esi,type table
mov eax,trow3
mov table[ebx+esi],eax
sub esi,8
mov ebx,temp1
loop l2
last:
mov ebx,0
mov eax,5
call randomrange
inc eax
cmp eax,5
jne cond1
mov eax,'B'
cond1:
mov table[ebx+esi],eax
add esi,type table
mov eax,5
call randomrange
inc eax
cmp eax,5
jne cond2
mov eax,'B'
cond2:
mov table[ebx+esi],eax
add esi,type table
mov eax,5
call randomrange
inc eax
cmp eax,5
jne cond3
mov eax,'B'
cond3:
mov table[ebx+esi],eax
ret
crushrow3 endp
;========================================
;/////////////////Blast Row/////////////
blastrow3 proc,blastrow :DWORD,blastcol :DWORD
mov ebx,blastrow
mov esi,blastcol
mov ecx,rownum
cmp ecx,0
je last
outerloop:
mov esi,0
push ecx
mov ecx,10
innerloop:
sub ebx,rowsize
mov eax,table[ebx+esi]
add ebx,rowsize
mov table[ebx+esi],eax
add esi,type table
loop innerloop
sub ebx,rowsize
pop ecx
loop outerloop
last:
mov esi,0
mov ecx,10
l1:
mov eax,5
call randomrange
inc eax
cmp eax,5
jne N
mov eax,'B'
N:
mov table[ebx+esi],eax
add esi,type table
loop l1
ret
blastrow3 endp
;==========================================
;	Checking Column3 
column3 proc
mov checkalltable,1
mov esi,0
mov ecx,10

loop1:
mov colnum,0
mov ebx,0
push ecx
mov ecx,8

l1:
mov eax,table[ebx+esi]
mov temp1,eax
inc colnum
add ebx,rowsize
mov eax,table[ebx+esi]
cmp eax,temp1
je Same

jmp last
same:
add ebx,rowsize
mov eax,table[ebx+esi]
cmp eax,temp1
jne l
push ebx
push esi

call checkcrushcol
pop esi
pop ebx
mov eax,0
mov checkalltable,eax
l:
sub ebx,rowsize

last:
loop l1
pop ecx
add esi,type table
loop loop1
ret
column3 endp;
;==========================================
checkcrushcol proc
push ecx
cmp eax,66
jne neechy
invoke blastcol3,ebx,esi
add points,10
jmp done
neechy:
invoke crushcol3 ,ebx,esi
inc points
done:
pop ecx
ret
checkcrushcol endp
;==========================================
blastcol3 proc,ebx_row3:DWORD,esi_col3:DWORD
mov ebx,0
mov esi ,esi_col3
mov ecx,10
l1:
 mov eax,5
 call randomrange
 inc eax
 cmp eax,5
 jne neechy
 mov eax,'B'
 neechy:
 mov table[ebx+esi],eax
 add ebx,rowsize
loop l1

ret
blastcol3 endp
;==========================================
;	crushcol procedure 
crushcol3 proc, rcol3:DWORD,col3 :DWORD
mov ebx,rcol3
mov esi,col3
add colnum,2
mov eax,colnum
mov temp_col,eax

push colnum
again:
cmp eax,3
jbe outt
sub ebx,rowsize
sub ebx,rowsize
sub ebx,rowsize
mov edx,table[ebx+esi]
add ebx,rowsize
add ebx,rowsize
add ebx,rowsize
mov table[ebx+esi],edx
sub ebx,rowsize
dec eax
jmp again
outt:
sub ebx,rowsize
sub ebx,rowsize
mov eax,5
call randomrange
inc eax
cmp eax,5
jne cond1
mov eax,'B'
cond1:
mov table[ebx+esi],eax
add ebx,rowsize
mov eax,5
call randomrange
inc eax
cmp eax,5
jne cond2
mov eax,'B'
cond2:
mov table[ebx+esi],eax
add ebx,rowsize
mov eax,5
call randomrange
inc eax
cmp eax,5
jne cond3
mov eax,'B'
cond3:
mov table[ebx+esi],eax
mov ebx,rcol3
pop colnum
mov colnum,1
ret
crushcol3 endp
;==========================================
populateBoard3 Proc
	Mov ecx,10
	Mov ebx,0
	Mov esi,0
	
Label1:
	push ecx
	Mov ecx,10
	Mov esi,0
	
	Label2:		
		Mov eax,6		; Random Number Range (0-6)
		call randomRange
		inc eax	; Add 1 for range (1-6)
		cmp eax, 6
		jne down
		mov ax,'X'
		down:
		cmp eax,5
		jne neechy
		mov ax,'B'
		neechy:
		mov Table[ebx+esi], eax
		mov eax,0
		add esi,type Table 
	Loop Label2
		pop ecx
		add ebx, rowsize
Loop Label1
ret
populateBoard3 endp
;==========================================
PrintTable3 Proc	
	Mov ecx,10
	Mov ebx,0
	Mov esi,0
	
Label3:
	push ecx
	Mov ecx,10
	Mov esi,0

	call crlf
	mov edx, offset rowspaces
	call WriteString

	call label4_3

	call crlf

	pop ecx
	add ebx, rowsize
	mov eax, lightcyan
	call settextcolor
	mov edx, offset small_lines
	call WriteString
	Loop Label3
ret
PrintTable3 endp

label4_3 proc
	Label4:	
	mov eax, Table[ebx+esi]
	push eax 
	call color_board  ; for coloring board()
	pop eax
	cmp eax, 'X'
	jne down
	call writechar
	jmp done
	down:
	cmp eax,'B'
	jne neechy
	call writechar   ; Printing Bombs
	jmp done
	neechy:
	call WriteDec
	done:
	mov eax, lightblue
	call settextcolor
	mov edx, offset vertical_line
	call WriteString
	mov edx, offset space
	call WriteString

	add esi, type Table
	Loop Label4
ret
label4_3 endp
;========================================
;Display player name,Score,Moves 
displayplayer proc
print"Name: "
	mov eax, brown
	call settextcolor
mov edx,offset buffer
call writeString
print"            Score: "
	mov eax, brown
	call settextcolor
mov eax, points
call writeDec
print"            Remaining Moves: "
	mov eax, brown
	call settextcolor
mov al,moves
call writeDec

ret
displayplayer endp
;==========================================
create_write_file proc
	mov eax, brown
	call settextcolor

; Create a new text file.
mov edx,OFFSET filename
call CreateOutputFile
mov fileHandle,eax

; Check for errors.
cmp eax, INVALID_HANDLE_VALUE ; error found?
jne file_ok ; no: skip
mov edx,OFFSET str1 ; display error
call WriteString
jmp quit

file_ok:
; Ask the user to input a string.
mov edx, offset input_name_msg ; input msg
call WriteString

mov ecx,BUFFER_SIZE ; Input a string
mov edx,OFFSET buffer
call ReadString
mov stringLength,eax ; counts chars entered

; Write the buffer to the output file.
mov eax,fileHandle
mov edx,OFFSET buffer
mov ecx,stringLength   ; writing in file
call WriteToFile

;-----------------------------------------------
mov bytesWritten,eax ; save return value
call CloseFile

; Display the return value.
mov edx,OFFSET str2 ; "Bytes written"
call WriteString
mov eax,bytesWritten
call WriteDec
call Crlf
quit:

ret
create_write_file endp
;==========================================
END main
