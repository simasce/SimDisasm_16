org 100h                        

section .text
call initLoad
mov ah, 0x4c
int 0x21

initLoad:
    call loadParams
	mov dx, InputFile
	mov bx, InputFileHandle
	call loadFile
	mov dx, OutputFile
	mov bx, OutputFileHandle
	call createFile
	call fileLoop
	call closeFile
	mov bx, InputFileHandle
	call closeFile
ret

loadParams:
	push si
	push di
	push cx
	push dx
	push bx
	
    cld
	movzx cx, [0x80] ;param size
	cmp cx, 0
	je fileEx
	
	mov si, 0x81
.trimStart
	cmp byte [si], ' '
	jne .trimEnd
	inc si
	jmp .trimStart
.trimEnd
	mov bx, si
	
	mov si, bx
	mov di, InputFile
	rep movsb
	
	movzx cx, [0x80]
	mov si, InputFile
	add si, cx
.inputLoopStart:
	cmp byte [si], 0x0D
	je .inputLoopEnd
	dec si
	jmp .inputLoopStart
.inputLoopEnd:
	mov byte [si], 0
	
	movzx cx, [0x80] ;param size
	mov si, bx
	mov di, OutputFile
	rep movsb
	
	movzx cx, [0x80] ;param size
	mov si, OutputFile
	add si, cx
.paramLoopStart:
	cmp byte [si], '.'
	je .paramLoopEnd
	dec si
	jmp .paramLoopStart
.paramLoopEnd:
	mov byte [si+1], 'a'
	mov byte [si+2], 's'
	mov byte [si+3], 'm'
	mov byte [si+4], 0
	
	pop bx
	pop dx
	pop cx
	pop di
	pop si
ret

fileLoop:
	call readByte
	cmp ah, 0
	jne fileContinue
ret

fileContinue:
    mov ah, 0
	call loadOpcode
	call procOpcode
	jmp fileLoop
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
screenPrint: ;dx - print ptr
   mov ah, 09
   int 0x21
ret
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadFile: ;dx - filename, bx - file handle pointer (READING!)
   push ax
   push bx
   push cx
   
   xor ax, ax
   xor cx, cx
   mov al, 0x00
   mov ah, 0x3D
   int 0x21
   jc fileFail
   mov [bx], ax
   
   pop cx
   pop bx
   pop ax
ret

createFile: ;dx - filename, bx - file handle pointer 
   push ax
   push bx
   push cx
   
   xor ax, ax
   xor cx, cx
   mov al, 0x00
   mov ah, 0x3C
   int 0x21
   jc fileFail
   mov [bx], ax
   
   pop cx
   pop bx
   pop ax
ret

printString: 
   push ax 
   push cx
   push dx
   push bx
   xor cx, cx
   mov cl, [OutputCurrentIndex]
   mov bx, [OutputFileHandle]
   xor ax, ax
   mov ah, 0x40
   int 0x21
   jc fileFail
   pop cx
   push cx
   cmp cx, 0
   jne .printEnd
   mov dx, AddFileNewLine
   mov cx, 2
   xor ax, ax
   mov ah, 0x40
   int 0x21
   jc fileFail
.printEnd:
   pop bx
   pop dx 
   pop cx
   pop ax
ret
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
readByte: ;ret - ah - if read (0/1), al - read byte
   push dx
   push bx
   push cx
   
   mov bx, [InputFileHandle]
   mov cx, 1
   mov dx, InputReadByte
   xor ax, ax
   mov ah, 0x3F
   int 0x21
   jc fileFail
   mov ah, [InputReadByte]
   xchg ah, al
   
   mov cx, [CurrentOpcodeOffset]
   inc cx
   mov [CurrentOpcodeOffset], cx
   
   pop cx
   pop bx
   pop dx
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fileFail: ; NO RETURN - JMP ONLY
   mov dx, FileFailText
progFail:
   call screenPrint
progNFail:
   mov bx, [InputFileHandle]
   cmp bx, 0
   je fileEx
   call closeFile
fileEx:
   mov bx, [OutputFileHandle]
   cmp bx, 0
   je fileEx2
   call closeFile
fileEx2:
   mov ah, 0x4c
   int 0x21


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
closeFile: ;bx - file handle
   push ax
   push bx
   xor ax, ax
   mov ah, 0x3E
   int 0x21
   pop bx
   pop ax
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stringAppend:; dx - string to append (must end with $)
	push bx
	push si
	push ax
	push dx
	
	xor ax, ax
	xor bx, bx
	mov si, dx
	mov bl, byte [OutputCurrentIndex]
strAppendLoop:
	mov al, byte [si]
	mov byte [OutputString+bx], al
	inc bx
	inc si
	cmp al, '$'
	jne strAppendLoop
	dec bl
	mov byte [OutputCurrentIndex], bl

	pop dx
	pop ax
	pop si
	pop bx
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stringClear:
	mov [OutputCurrentIndex], byte 0
	mov [OutputString], byte '$'
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stringRMAppend:; dx - string to append (must end with $)
	push bx
	push si
	push ax
	
	xor ax, ax
	xor bx, bx
	mov si, dx
	mov bl, byte [RMOutputCurrentIndex]
strRMAppendLoop:
	mov al, byte [si]
	mov byte [RMString+bx], al
	inc bx
	inc si
	cmp al, '$'
	jne strRMAppendLoop
	dec bl
	mov byte [RMOutputCurrentIndex], bl

	pop ax
	pop si
	pop bx
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stringRMClear:
	mov [RMOutputCurrentIndex], byte 0
	mov [RMString], byte '$'
ret

convertStringNumToChar: ;ax - num, ax - char
	cmp al, 9
	ja .isHex
.isNum:
	add al, byte '0'
	ret
.isHex:
    sub al, 10
	add al, byte 'A'
ret

stringAppendNum: ;ax - number, dx - string,
	push ax
	push bx
	push cx
	push si
	
	mov si, 1 ;0-s can be clamped
	xor cx, cx
	mov bx, dx
	dec bx
	mov cl, byte [bx]
	
	mov bx, cx
	add bx, dx
	
	push dx
	
	mov byte [bx], '0'
	mov byte [bx+1], 'x'
	add bx, 2
	add cx, 2
	
.firstNum:
	mov dx, ax
	and ax, 0xF000
	shr ax, 12
	
	cmp si, 1
	jne .firstNumCont
	cmp ax, 0
	je .secondNum
.firstNumCont:

	xor si, si
	call convertStringNumToChar
	mov byte [bx], al
	inc bx
	inc cx
	
.secondNum:
	mov ax, dx
	and ax, 0x0F00
	shr ax, 8
	
	cmp si, 1
	jne .secondNumCont
	cmp ax, 0
	je .thirdNum
.secondNumCont:

	xor si, si
	call convertStringNumToChar
	mov byte [bx], al
	inc bx
	inc cx

.thirdNum:	
	mov ax, dx
	and ax, 0x00F0
	shr ax, 4
	
	cmp si, 1
	jne .thirdNumCont
	cmp ax, 0
	je .fourthNum
.thirdNumCont:

	xor si, si
	call convertStringNumToChar
	mov byte [bx], al
	inc bx
	inc cx
	
.fourthNum:
	mov ax, dx
	and ax, 0x000F
	call convertStringNumToChar
	mov byte [bx], al
	inc bx
	inc cx
	
	pop dx
	
	mov [bx], byte '$'
	mov bx, dx
	dec bx
	mov byte [bx], cl
	
	pop si
	pop cx
	pop bx
	pop ax
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getBinaryBits: ;dl - input, al - low, ah - high [0-7], al - output
	push dx
	push bx
	push cx
	
	xor bx, bx
	xor cx, cx
gBinaryBitLoop:
	mov bh, 1
	cmp cl, al
	jb gBinaryBitLoopEnd
	cmp cl, ah
	ja gBinaryBitLoopEnd
	shl bh, cl
	or bl, bh
gBinaryBitLoopEnd:
	cmp cl, 7
	jae gBinaryBitEnd
	inc cl
	jmp gBinaryBitLoop
gBinaryBitEnd:
	mov cl, al
	and dl, bl
	shr dl, cl
	mov al, dl
	
	pop cx
	pop bx
	pop dx
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadOpcode: ;al - opcode
	push dx
	push bx
	push ax
	
	call stringClear
	mov [OpcodeInfoCurMode], byte 0
	mov [OpcodeInfoCurOpcode], byte al
	mov [OpcodeInfoWide], byte 0
	mov [OpcodeInfoIsExtended], byte 0
	
	mov bx, ax
	mov bh, 0
	xor ax, ax
	xor dx, dx
	mov al, byte [sOPS_Size]
	mul bx
	add ax, sOP_Start
	
	;load register data
	mov dx, ax
	mov bx, dx
	mov ax, [bx]
	cmp ax, sOP_Skip
	je .loadEnd
	mov [OpcodeInfoName], ax

	add dx, 2
	mov bx, dx
	mov ax, [bx]
	mov bx, ax
	mov ax, [bx] ;double dereference
	mov [OpcodeInfoReg1], ax
	cmp ax, [sOP_m_all]
	jbe .isgood1
	mov [OpcodeInfoReg1], bx
	
.isgood1:
	add dx, 2
	mov bx, dx
	mov ax, [bx]
	mov bx, ax
	mov ax, [bx] ;double dereference
	mov [OpcodeInfoReg2], ax
	cmp ax, [sOP_m_all]
	jbe .isgood2
	mov [OpcodeInfoReg2], bx
	
.isgood2:

	;check if it's legit
	add dx, 2
	mov bx, dx
	mov dx, UnsupportedOpcodeFail
	mov ax, [bx]
	cmp ax, 0x0001
	jne progFail ; not legit
	
.loadEnd:
	pop ax
	pop bx
	pop dx
ret


procOpcode: 
    push ax
	push bx
	push cx
	push dx
	
	xor cx, cx ;prepare state counter
	
	;write the opcode
    mov dx, [OpcodeInfoName]
	cmp dx, sOP_Empty
	je .needsExtra
	call stringAppend
	call addSpace
.needsExtra:

	;check if wide
	mov ax, [OpcodeInfoReg1]
	cmp ax, 2 ;imm16
	je procIsWide
	cmp ax, 4 ;reg16
	je procIsWide
	
procWideCheck2:
	mov ax, [OpcodeInfoReg2]
	cmp ax, 2 ;imm16
	je procIsWide
	cmp ax, 4 ;reg16
	jne procExtendedCheck
	
procIsWide:
	mov byte [OpcodeInfoWide], 1
	
procExtendedCheck:
    mov ax, [OpcodeInfoReg1]
	cmp ax, 6 ;extened8
	je procIsExtended
	
procExtendedCheck2:
	mov ax, [OpcodeInfoReg2]
	cmp ax, 6 ;extened8
	jne procRMCheck
	
procIsExtended:
	mov byte [OpcodeInfoIsExtended], 1

procRMCheck:
	mov ax, [OpcodeInfoReg1]
	cmp ax, 5 ;RM
	jne procRMCheck2
	call readModRM
	
procRMCheck2:
	mov ax, [OpcodeInfoReg2]
	cmp ax, 5 ;RM
	jne procOpcodeStart
	call readModRM
	
procOpcodeStart:
	mov ax, [OpcodeInfoReg1]
procOpcodeNone:
	cmp ax, 0
	jne procOpcodeImm8
	jmp procOpcodeFinish
	
procOpcodeImm8:
	cmp ax, 1
	jne procOpcodeImm16
	call readByte
	mov ah, 0
	mov dx, OutputString
	call stringAppendNum
	jmp procOpcodeFinish
	
procOpcodeImm16:
	cmp ax, 2
	jne procOpcodeReg8
	call readByte
	mov ah, 0
	mov bx, ax
	call readByte
	mov ah, al
	mov al, bl
	mov dx, OutputString
	call stringAppendNum
	jmp procOpcodeFinish
	
procOpcodeReg8:
	cmp ax, 3
	jne procOpcodeReg16
	mov dx, [OpcodeInfoCurReg]
	call stringAppend
	jmp procOpcodeFinish
	
procOpcodeReg16:
	cmp ax, 4
	jne procOpcodeRM
	mov dx, [OpcodeInfoCurReg]
	call stringAppend
	jmp procOpcodeFinish
	
procOpcodeRM:
	cmp ax, 5
	jne procOpcodeEImm8 
	mov dx, RMString
	call stringAppend
	jmp procOpcodeFinish

procOpcodeEImm8:
	cmp ax, 6
	jne procOpcodeImmReg8 
	call readByte
	mov ah, 0
	mov dx, OutputString
	call stringAppendNum
	jmp procOpcodeFinish
	
procOpcodeImmReg8:
	cmp ax, 7
	jne procOpcodeImmReg16 
	jmp procOpcodeImmReg168
	
procOpcodeImmReg16:
	cmp ax, 8
	jne procSegmentReg 
procOpcodeImmReg168:
    mov dx, AddCharPtrLeft
	call stringAppend
	call readByte
	mov ah, 0
	mov bx, ax
	call readByte
	mov ah, al
	mov al, bl
	mov dx, OutputString
	call stringAppendNum
	mov dx, AddCharPtrRight
	call stringAppend
	jmp procOpcodeFinish
	
procSegmentReg:
	cmp ax, 9
	jne procJNear 
	mov dx, [OpcodeInfoCurReg]
	sub dx, sReg_AL
    add dx, sReg_ES	
	call stringAppend
	jmp procOpcodeFinish
	
procJNear:
	cmp ax, 10
	jne procJFar 
	call readByte
	mov ah, 0
	mov bx, ax
	call readByte
	mov ah, al
	mov al, bl
	add ax, [CurrentOpcodeOffset]
	mov dx, OutputString
	call stringAppendNum
	jmp procOpcodeFinish
	
procJFar:
	cmp ax, 11
	jne procJShort
	;segment part
	call readByte
	mov ah, 0
	mov bx, ax
	call readByte
	mov ah, al
	mov al, bl
	push ax
	xor ax, ax
	call readByte
	mov ah, 0
	mov bx, ax
	call readByte
	mov ah, al
	mov al, bl
	mov dx, OutputString
	call stringAppendNum
	;add ':'
	mov dx, AddCharColumn
	call stringAppend
	pop ax
	;add etc
	mov dx, OutputString
	call stringAppendNum
	jmp procOpcodeFinish
	
procJShort:
	cmp ax, 12
	jne procPremadeReg
	call readByte
	mov ah, 0
	cbw
	add ax, [CurrentOpcodeOffset]
	mov dx, OutputString
	call stringAppendNum
	jmp procOpcodeFinish
	
procPremadeReg:
	cmp ax, sReg_aConst1
	je .premSucc
	cmp ax, sReg_aConst3
	je .premSucc
    cmp ax, sReg_ES
	jb progNFail ;invalid
	cmp ax, sReg_BH
	ja progNFail ;invalid
.premSucc:
	mov dx, ax
	call stringAppend
	
procOpcodeFinish:
	mov ax, [OpcodeInfoReg2]
	inc cx
	cmp cx, 2
	jae procOpcodeFullFinish
	call procTryComma ;check if comma should be added
	jmp procOpcodeNone
	
procOpcodeFullFinish:
	mov dx, OutputString
	xor bx, bx
	mov al, byte [OpcodeInfoCurOpcode]
	;rep/repne workaround
	cmp al, 0xF2 ;repne
	jne .FullFinish1
	mov bx, 1
	jmp .FullFinish2
.FullFinish1:
	cmp al, 0xF3 ;rep
	jne .FullFinish2
	mov bx, 1
.FullFinish2:
	call printString

	pop dx
	pop cx
	pop bx
	pop ax
ret

procTryComma:
	push ax
	cmp ax, 0
	je .noComma
	mov al, byte [OpcodeInfoCurOpcode]
	cmp al, 0xF2 ;repne
	je .noComma
	cmp al, 0xF3 ;rep
	je .noComma	
	mov dx, AddCharComma
	call stringAppend
	mov dx, AddCharSpace
	call stringAppend
.noComma
	pop ax
ret

procExtra: ;al - current reg
	push dx
	push bx
	push ax
	mov ah, byte [OpcodeInfoCurOpcode]
	cmp ah, 0x80
	je .is80
	jb .extraEnd
	cmp ah, 0x84
	ja .D0check 
.is80:
	mov dl, al
	mov ax, 2
	mul dl
	mov ah, 0
	add ax, sExtra_80
	mov bx, ax
	mov dx, [bx] ;dereference
	;finally print the extra
	call stringAppend
	call addSpace
	jmp .extraEnd
	
.D0check:
	cmp ah, 0xD0
	je .isD0
	jb .extraEnd
	cmp ah, 0xD3
	ja .F6check
.isD0:
	cmp ah, 0xD1
	jne .isD3
	mov byte [OpcodeInfoWide], 1
	jmp .isD0Cont
.isD3:
	cmp ah, 0xD3
	jne .isD0Cont
	mov byte [OpcodeInfoWide], 1
.isD0Cont:
	mov dl, al
	mov ax, 2
	mul dl
	mov ah, 0
	add ax, sExtra_D0
	mov bx, ax
	mov dx, [bx] ;dereference
	call stringAppend
	call addSpace
	jmp .extraEnd
	
.F6check:
	cmp ah, 0xF6
	je .isF6
	jb .extraEnd
	cmp ah, 0xF7
	ja .FEcheck ;change
.isF6:
	push ax
    cmp ah, 0xF7
	jne .isF6Cont
	mov ah, 1
	mov byte [OpcodeInfoWide], ah
.isF6Cont
	mov dl, al
	mov ax, 2
	mul dl
	mov ah, 0
	add ax, sExtra_F6
	mov bx, ax
	mov dx, [bx] ;dereference
	call stringAppend
	call addSpace
	pop ax
	
	;extra TEST 
	cmp dx, sOP_Test
	jne .extraEnd
	cmp ah, 0xF7
	jne .isF6Test
	mov bx, [sOP_m_imm16]
	mov [OpcodeInfoReg2], bx 
	jmp .extraEnd
.isF6Test
	mov bx, [sOP_m_imm8]
	mov [OpcodeInfoReg2], bx 
	jmp .extraEnd
	
.FEcheck:
	cmp ah, 0xFE
	je .isFE
	jb .extraEnd
	ja .isFF ;change
.isFE:
	mov dl, al
	mov ax, 2
	mul dl
	mov ah, 0
	add ax, sExtra_FE
	mov bx, ax
	mov dx, [bx] ;dereference
	call stringAppend
	call addSpace
	jmp .extraEnd
.isFF:
	mov byte [OpcodeInfoWide], 1
	mov dl, al
	mov ax, 2
	mul dl
	mov ah, 0
	add ax, sExtra_FF
	mov bx, ax
	mov dx, [bx] ;dereference
	call stringAppend
	call addSpace
    
.extraEnd:
	pop ax
	pop bx
	pop dx
ret

readModRM: 
	push ax
	push bx
	push cx
	push dx
	
	call stringRMClear
	xor ax, ax
	mov [OpcodeInfoCurMod], al
	mov [OpcodeInfoCurRM], ax
	mov [OpcodeInfoCurReg], ax
	mov [OpcodeInfoCurDisp], ax
	mov [OpcodeInfoCurData], ax
	
	;step 1 : read stuff 
	
	;read MOD
	call readByte
	mov ah, 0
	mov byte [OpcodeInfoRMByte], byte al
	and al, 0xC0 ; 11000000
	shr al, 6
	mov [OpcodeInfoCurMod], byte al
	cmp al, 3
	je .noBrackets
	;mov dl, byte [OpcodeInfoWide]
	;cmp dl, 1
	;jne .isBytePtr
;.isWidePtr:
	;mov dx, sPTR_WORDPTR
	;call stringRMAppend
	;jmp .ptrEnd
;.isBytePtr:
	;mov dx, sPTR_BYTEPTR
	;call stringRMAppend
;.ptrEnd:
	mov dx, AddCharPtrLeft
	call stringRMAppend
	
.noBrackets:
	;read REG
	mov al, byte [OpcodeInfoRMByte]
	and al, 0x38 ; 00111000
	shr al, 3
	mov [OpcodeInfoCurReg], byte al
	;instantly proc
	mov dx, OpcodeInfoCurReg
	call procREGByte
	
	mov dx, [OpcodeInfoName]
	cmp dx, sOP_Empty
	jne .notEmpty
	call procExtra
	
.notEmpty:
	
	;read RM
	mov al, byte [OpcodeInfoRMByte]
	and al, 0x07 ; 00000111
	mov [OpcodeInfoCurRM], byte al
	
	;step 2 : process MOD + read the leftovers if needed
	mov al, byte [OpcodeInfoCurMod]
	
rmIs00:
	cmp al, 0 
	jne rmIs01
	
	
	xor ax, ax
	xor dx, dx
	mov al, byte [OpcodeInfoCurRM]
	mov cx, 6
	mul cx
	add ax, sRM_00
	mov dx, ax
	call stringRMAppend
	
	mov al, byte [OpcodeInfoCurRM]
	cmp al, 6; drc't add
	jne rmEnd
	call readByte ;read 16bit-low offset
	mov ah, 0
	mov bx, ax ; save it
	call readByte ;read 16bit-high offset
	mov bh, al 

	mov ax, bx;get the saved number
	mov dx, RMString
	call stringAppendNum
	jmp rmEnd
	
rmIs01:
	cmp al, 1 
	jne rmIs10

	call readByte ;read 8 bit displacement
	mov ah, 0
	mov bx, ax ; save it
	
	xor ax, ax
	xor dx, dx
	mov al, byte [OpcodeInfoCurRM]
	mov cx, 6
	mul cx
	add ax, sRM_01
	mov dx, ax
	call stringRMAppend
	
	cmp bx, 0
	je rmEnd
	
	mov dx, AddCharPlus
	call stringRMAppend
	
	mov ax, bx;get the saved number
	mov dx, RMString
	call stringAppendNum
	
	jmp rmEnd
	
rmIs10:
	cmp al, 2
	jne rmIs11
	
	call readByte ;read 16bit-low displacement
	mov ah, 0
	mov bx, ax ; save it
	call readByte ;read 16bit-high displacement
	mov bh, al 
	
	xor ax, ax
	xor dx, dx
	mov al, byte [OpcodeInfoCurRM]
	mov cx, 6
	mul cx
	add ax, sRM_01
	mov dx, ax
	call stringRMAppend
	
	cmp bx, 0
	je rmEnd
	
	mov dx, AddCharPlus
	call stringRMAppend
	
	mov ax, bx;get the saved number
	mov dx, RMString
	call stringAppendNum
	
	jmp rmEnd
	
rmIs11:
	mov dx, OpcodeInfoCurRM ;is just a REG lmao
	call procREGByte
	mov dx, [OpcodeInfoCurRM]
	
	;extra xchg stuff
	mov ax, sOP_Xchg
	cmp [OpcodeInfoName], ax
	jne .rm11Continue
    mov bx, [OpcodeInfoCurReg]
	xchg dx, bx
	mov [OpcodeInfoCurReg], bx
	
.rm11Continue
	call stringRMAppend
	
rmEnd:

    xor ax, ax
	mov al, byte [OpcodeInfoCurMod]
	cmp al, 3
	je .noBrackets2
	mov dx, AddCharPtrRight
	call stringRMAppend
	
.noBrackets2
	
	pop dx
	pop cx
	pop bx
	pop ax
ret


procREGByte: ;dx - byte pointer to make a string
	push dx
	push bx
	push cx
	push ax
	
	mov bx, dx
	xor cx, cx
	mov cl, byte [OpcodeInfoWide]
	
	xor ax, ax
	mov ax, [bx]
	cmp ax, 8
	ja progNFail ;something is wrong, we are out of bounds	
	
	;prep AX
	push dx
	xor dx, dx
	mov bx, 3
	mul bx
	pop dx
	
pRegByte:
	cmp cl, 0
	jne pRegWide
	cmp byte [OpcodeInfoIsExtended], 1
	je pRegWide
	add ax, sReg_AL
	jmp pRegEnd
pRegWide: 
	add ax, sReg_AX
	jmp pRegEnd
pRegEnd:
	mov bx, dx
	mov [bx], ax
	
	pop ax
	pop cx
	pop bx
	pop dx
ret

addSpace:
	push dx
	mov dx, AddCharSpace
	call stringAppend
	pop dx
ret

%include 'sopc.asm'

section .data

UnsupportedOpcodeFail: db 'Unsupported opcode found!$' , 0x0D, 0x0A
FileFailText: db 'File read or write error!$', 0x0D, 0x0A
NewLine: db 0x0D, 0x0A, '$'
InputFileHandle: db 00, 00
InputFile: times 50 db 00
InputReadByte: db 00
OutputFileHandle: db 00, 00
OutputFile: times 50 db 00
OutputCurrentIndex: db 00
OutputString: times 50 db '$' 
RMOutputCurrentIndex: db 00
RMString: times 50 db '$' 
CurrentOpcodeOffset: dw 0x100

OpcodeInfoWide: db 0
OpcodeInfoCurOpcode: db 0
OpcodeInfoCurMode: db 0
OpcodeInfoName: dw 0x0000
OpcodeInfoReg1: dw 0x0000
OpcodeInfoReg2: dw 0x0000
OpcodeInfoRMByte: db 0
OpcodeInfoCurMod: db 0
OpcodeInfoCurRM: db 0, 0 ;can be turned to string pointer
OpcodeInfoCurReg: db 0, 0 ;can be turned to string pointer
OpcodeInfoCurDisp: db 0,0
OpcodeInfoCurData: db 0,0
OpcodeInfoIsExtended: db 0

AddCharPtrLeft: db '[$'
AddCharPtrRight: db ']$'
AddCharPlus: db '+$'
AddCharComma: db ',$'
AddCharSpace: db ' $'
AddCharColumn: db ':$'

AddFileNewLine: db 0x0D, 0x0A

section .bss
