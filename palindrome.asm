;Check if the input string palindrome.

SECTION .data
result	db	10,'Palindrome',10
result_len	equ	$-result		

SECTION .bss
string resb 100 ;assume it will be enough

SECTION .text
global _start
_start:

;get input block
  MOV 	EAX,3
  MOV	EBX,0
  MOV 	ECX,string
  MOV	EDX,100
  INT	80h ;call routine

  MOV	ESI,string
  MOV	AH,0	;for push/pop mechanism
  MOV	ECX,0	;in ecx will be the lenght of string
  
store_on_stack:
  MOV	AL,[ESI]
  CMP	AL,10 ;check is it end, if user entered enter!
  JE	compare
  PUSH	AX
  INC	ESI
  INC	ECX
  JMP	store_on_stack

compare:
  MOV	ESI,string
  iterate:
      POP	AX
      CMP	AL,[ESI]
      JNE	not_palindrom
      INC	ESI
      LOOP	iterate

palindrom: ;inform that is palindrome 
      MOV	EAX,4
      MOV	EBX,1
      MOV	ECX,result
      MOV	EDX,result_len
      INT	80h
  
not_palindrom:
      JMP	end
 
end: 
  MOV	EAX,1
  MOV	EBX,0
  INT	80h
