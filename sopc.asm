sOP_Mov: db 'MOV$'
sOP_Push: db 'PUSH$'
sOP_Pop: db 'POP$'
sOP_Xchg: db 'XCHG$'
sOP_In: db 'IN$'
sOP_Out: db 'OUT$'
sOP_Xlat: db 'XLAT$'
sOP_Lea: db 'LEA$'
sOP_Lds: db 'LDS$'
sOP_Les: db 'LES$'
sOP_Lahf: db 'LAHF$'
sOP_Sahf: db 'SAHF$'
sOP_Pushf: db 'PUSHF$'
sOP_Popf: db 'POPF$'
sOP_Add: db 'ADD$'
sOP_Adc: db 'ADC$'
sOP_Inc: db 'INC$'
sOP_Aaa: db 'AAA$'
sOP_Baa: db 'BAA$'
sOP_Sub: db 'SUB$'
sOP_Ssb: db 'SSB$'
sOP_Sbb: db 'SBB$'
sOP_Dec: db 'DEC$'
sOP_Neg: db 'NEG$'
sOP_Cmp: db 'CMP$'
sOP_Aas: db 'AAS$'
sOP_Das: db 'DAS$'
sOP_Mul: db 'MUL$'
sOP_Imul: db 'IMUL$'
sOP_Aam: db 'AAM$'
sOP_Div: db 'DIV$'
sOP_Idiv: db 'IDIV$'
sOP_Aad: db 'AAD$'
sOP_Cbw: db 'CBW$'
sOP_Cwd: db 'CWD$'
sOP_Not: db 'NOT$'
sOP_Shl: db 'SHL$'
sOP_Shr: db 'SHR$'
sOP_Rol: db 'ROL$'
sOP_Ror: db 'ROR$'
sOP_Rcl: db 'RCL$'
sOP_Rcr: db 'RCR$'
sOP_And: db 'AND$'
sOP_Test: db 'TEST$'
sOP_Or: db 'OR$'
sOP_Xor: db 'XOR$'
sOP_Rep: db 'REP$'
sOP_Movs: db 'MOVS$'
sOP_Cmps: db 'CMP$'
sOP_Scas: db 'SCAS$'
sOP_Lods: db 'LODS$'
sOP_Stosw: db 'STOSW$'
sOP_Stosb: db 'STOSB$'
sOP_Call: db 'CALL$'
sOP_Jmp: db 'JMP$'
sOP_Jmpf: db 'JMP FAR$'
sOP_Callf: db 'CALL FAR$'
sOP_Ret: db 'RET$'
sOP_Je: db 'JE$'
sOP_Jl: db 'JL$'
sOP_Jle: db 'JLE$'
sOP_Jb: db 'JB$'
sOP_Jbe: db 'JBE$'
sOP_Jp: db 'JP$'
sOP_Jo: db 'JO$'
sOP_Js: db 'JS$'
sOP_Jne: db 'JNE$'
sOP_Jge: db 'JGE$'
sOP_Jg: db 'JG$'
sOP_Jae: db 'JAE$'
sOP_Ja: db 'JA$'
sOP_Jnp: db 'JNP$'
sOP_Jno: db 'JNO$'
sOP_Jns: db 'JNS$'
sOP_Loop: db 'LOOP$'
sOP_Loope: db 'LOOPE$'
sOP_Loopne: db 'LOOPNE$'
sOP_Jcxz: db 'JCXZ$'
sOP_Int: db 'INT$'
sOP_Into: db 'INTO$'
sOP_Iret: db 'IRET$'
sOP_Clc: db 'CLC$'
sOP_Cmc: db 'CMC$'
sOP_Stc: db 'STC$'
sOP_Sar: db 'SAR$'
sOP_Cld: db 'CLD$'
sOP_Std: db 'STD$'
sOP_Cli: db 'CLI$'
sOP_Sti: db 'STI$'
sOP_Hlt: db 'HLT$'
sOP_Wait: db 'WAIT$'
sOP_Esc: db 'ESC$'
sOP_Lock: db 'LOCK$'
sOP_Repne: db 'REPNE$'
sOP_Retf: db 'RETF$'
sOP_Daa: db 'DAA$'
sOP_Jz: db 'JZ$'
sOP_Jnz: db 'JNZ$'
sOP_Jpo: db 'JPO$'
sOP_Movsb: db 'MOVSB$'
sOP_Movsw: db 'MOVSW$'
sOP_Cmpsb: db 'CMPSB$'
sOP_Cmpsw: db 'CMPSW$'
sOP_Lodsb: db 'LODSB$'
sOP_Lodsw: db 'LODSW$'
sOP_Scasb: db 'SCASB$'
sOP_Scasw: db 'SCASW$'
sOP_Loopnz: db 'LOOPNZ$'
sOP_Loopz: db 'LOOPZ$'
sOP_Unknown: db '$$'
sOP_Empty: db '$$'
sOP_Skip: db '$$'
sOP_Unsupported: db '$$'

sPTR_BYTEPTR: db 'BYTE PTR $'
sPTR_WORDPTR: db 'WORD PTR $'

sExtra_80: dw sOP_Add, sOP_Or, sOP_Adc, sOP_Sbb, sOP_And, sOP_Sub, sOP_Xor, sOP_Cmp
sExtra_D0: dw sOP_Rol, sOP_Ror, sOP_Rcl, sOP_Rcr, sOP_Shl, sOP_Shr, sOP_Unknown, sOP_Sar
sExtra_F6: dw sOP_Test, sOP_Unknown, sOP_Not, sOP_Neg, sOP_Mul, sOP_Imul, sOP_Div, sOP_Idiv
sExtra_FE: dw sOP_Inc, sOP_Dec, sOP_Unknown, sOP_Unknown, sOP_Unknown, sOP_Unknown, sOP_Unknown, sOP_Unknown
sExtra_FF: dw sOP_Inc, sOP_Dec, sOP_Call, sOP_Callf, sOP_Jmp, sOP_Jmpf, sOP_Push, sOP_Unknown

sRM_00:	db 'BX+SI$'
sRM_10:	db 'BX+DI$'
sRM_20:	db 'BP+SI$'
sRM_30:	db 'BP+DI$'
sRM_40:	db 'SI$$$$'
sRM_50:	db 'DI$$$$'
sRM_60:	db '$$$$$$'
sRM_70:	db 'BX$$$$'

sRM_01:	db 'BX+SI$'
sRM_11:	db 'BX+DI$'
sRM_21:	db 'BP+SI$'
sRM_31:	db 'BP+DI$'
sRM_41:	db 'SI$$$$'
sRM_51:	db 'DI$$$$'
sRM_61:	db 'BP$$$$'
sRM_71:	Db 'BX$$$$'

;segments
sReg_ES: db 'ES$'
sReg_CS: db 'CS$'
sReg_SS: db 'SS$'
sReg_DS: db 'DS$'

;x16
sReg_AX: db 'AX$'
sReg_CX: db 'CX$'
sReg_DX: db 'DX$'
sReg_BX: db 'BX$'
;etc
sReg_SP: db 'SP$'
sReg_BP: db 'BP$'
sReg_SI: db 'SI$'
sReg_DI: db 'DI$'

;x8
sReg_AL: db 'AL$'
sReg_CL: db 'CL$'
sReg_DL: db 'DL$'
sReg_BL: db 'BL$'
sReg_AH: db 'AH$'
sReg_CH: db 'CH$'
sReg_DH: db 'DH$'
sReg_BH: db 'BH$'

sReg_aConst1 db '1$$'
sReg_aConst3 db '3$$'

sOP_m_none: dw 0
sOP_m_imm8 : dw 1
sOP_m_imm16 : dw 2
sOP_m_reg8 : dw 3
sOP_m_reg16 : dw 4
sOP_m_rm: dw 5 
sOP_m_immE8: dw 6 
sOP_m_immReg8: dw 7
sOP_m_immReg16: dw 8
sOP_m_segReg: dw 9
sOP_m_near: dw 10 
sOP_m_far: dw 11 
sOP_m_short: dw 12 
sOP_m_all: db 13


sOPS_Size: db 8

sOP_Start:

OPs_00: dw sOP_Add , sOP_m_rm, sOP_m_reg8   , 0x00001
OPs_01: dw sOP_Add , sOP_m_rm, sOP_m_reg16  , 0x00001
OPs_02: dw sOP_Add , sOP_m_reg8, sOP_m_rm     , 0x0001
OPs_03: dw sOP_Add , sOP_m_reg16, sOP_m_rm  , 0x0001
OPs_04: dw sOP_Add , sReg_AL, sOP_m_imm8   , 0x0001
OPs_05: dw sOP_Add , sReg_AX, sOP_m_imm16  , 0x0001
OPs_06: dw sOP_Push, sReg_ES, sOP_m_none , 0x0001
OPs_07: dw sOP_Pop, sReg_ES, sOP_m_none , 0x0001
OPs_08: dw sOP_Or, sOP_m_rm, sOP_m_reg8 , 0x0001
OPs_09: dw sOP_Or, sOP_m_rm, sOP_m_reg16 , 0x0001
OPs_0A: dw sOP_Or, sOP_m_reg8, sOP_m_rm , 0x0001
OPs_0B: dw sOP_Or, sOP_m_reg16, sOP_m_rm , 0x0001
OPs_0C: dw sOP_Or, sReg_AL, sOP_m_imm8 , 0x0001
OPs_0D: dw sOP_Or, sReg_AX, sOP_m_imm16 , 0x0001
OPs_0E: dw sOP_Push, sReg_CS, sOP_m_none , 0x0001
OPs_0F: dw sOP_Skip, sOP_m_none, sOP_m_none , 0x0000
OPs_10: dw sOP_Adc, sOP_m_rm, sOP_m_reg8 , 0x0001
OPs_11: dw sOP_Adc, sOP_m_rm, sOP_m_reg16 , 0x0001
OPs_12: dw sOP_Adc, sOP_m_reg8, sOP_m_rm , 0x0001
OPs_13: dw sOP_Adc, sOP_m_reg16, sOP_m_rm , 0x0001
OPs_14: dw sOP_Adc, sReg_AL, sOP_m_imm8 , 0x0001
OPs_15: dw sOP_Adc, sReg_AX, sOP_m_imm16 , 0x0001
OPs_16: dw sOP_Push, sReg_SS, sOP_m_none , 0x0001
OPs_17: dw sOP_Pop, sReg_SS, sOP_m_none , 0x0001
OPs_18: dw sOP_Sbb, sOP_m_rm, sOP_m_reg8 , 0x0001
OPs_19: dw sOP_Sbb, sOP_m_rm, sOP_m_reg16 , 0x0001
OPs_1A: dw sOP_Sbb, sOP_m_reg8, sOP_m_rm , 0x0001
OPs_1B: dw sOP_Sbb, sOP_m_reg16, sOP_m_rm , 0x0001
OPs_1C: dw sOP_Sbb, sReg_AL, sOP_m_imm8 , 0x0001
OPs_1D: dw sOP_Sbb, sReg_AX, sOP_m_imm16 , 0x0001
OPs_1E: dw sOP_Push, sReg_DS, sOP_m_none , 0x0001
OPs_1F: dw sOP_Pop, sReg_DS, sOP_m_none , 0x0001
OPs_20: dw sOP_And, sOP_m_rm, sOP_m_reg8 , 0x0001
OPs_21: dw sOP_And, sOP_m_rm, sOP_m_reg16 , 0x0001
OPs_22: dw sOP_And, sOP_m_reg8, sOP_m_rm , 0x0001
OPs_23: dw sOP_And, sOP_m_reg16, sOP_m_rm , 0x0001
OPs_24: dw sOP_And, sReg_AL, sOP_m_imm8 , 0x0001
OPs_25: dw sOP_And, sReg_AX, sOP_m_imm16 , 0x0001
OPs_26: dw sReg_ES, sOP_m_none, sOP_m_none , 0x0001
OPs_27: dw sOP_Daa, sOP_m_none, sOP_m_none , 0x0001
OPs_28: dw sOP_Sub, sOP_m_rm, sOP_m_reg8 , 0x0001
OPs_29: dw sOP_Sub, sOP_m_rm, sOP_m_reg16 , 0x0001
OPs_2A: dw sOP_Sub, sOP_m_reg8, sOP_m_rm , 0x0001
OPs_2B: dw sOP_Sub, sOP_m_reg16, sOP_m_rm , 0x0001
OPs_2C: dw sOP_Sub, sReg_AL, sOP_m_imm8 , 0x0001
OPs_2D: dw sOP_Sub, sReg_AX, sOP_m_imm16 , 0x0001
OPs_2E: dw sReg_CS, sOP_m_none, sOP_m_none , 0x0001
OPs_2F: dw sOP_Das, sOP_m_none, sOP_m_none , 0x0001
OPs_30: dw sOP_Xor, sOP_m_rm, sOP_m_reg8 , 0x0001
OPs_31: dw sOP_Xor, sOP_m_rm, sOP_m_reg16 , 0x0001
OPs_32: dw sOP_Xor, sOP_m_reg8, sOP_m_rm , 0x0001
OPs_33: dw sOP_Xor, sOP_m_reg16, sOP_m_rm , 0x0001
OPs_34: dw sOP_Xor, sReg_AL, sOP_m_imm8 , 0x0001
OPs_35: dw sOP_Xor, sReg_AX, sOP_m_imm16 , 0x0001
OPs_36: dw sReg_SS, sOP_m_none, sOP_m_none , 0x0001
OPs_37: dw sOP_Aaa, sOP_m_none, sOP_m_none , 0x0001
OPs_38: dw sOP_Cmp, sOP_m_rm, sOP_m_reg8 , 0x0001
OPs_39: dw sOP_Cmp, sOP_m_rm, sOP_m_reg16 , 0x0001
OPs_3A: dw sOP_Cmp, sOP_m_reg8, sOP_m_rm , 0x0001
OPs_3B: dw sOP_Cmp, sOP_m_reg16, sOP_m_rm , 0x0001
OPs_3C: dw sOP_Cmp, sReg_AL, sOP_m_imm8 , 0x0001
OPs_3D: dw sOP_Cmp, sReg_AX, sOP_m_imm16 , 0x0001
OPs_3E: dw sReg_SS, sOP_m_none, sOP_m_none , 0x0001
OPs_3F: dw sOP_Aas, sOP_m_none, sOP_m_none , 0x0001
OPs_40: dw sOP_Inc, sReg_AX, sOP_m_none , 0x0001
OPs_41: dw sOP_Inc, sReg_CX, sOP_m_none , 0x0001
OPs_42: dw sOP_Inc, sReg_DX, sOP_m_none , 0x0001
OPs_43: dw sOP_Inc, sReg_BX, sOP_m_none , 0x0001
OPs_44: dw sOP_Inc, sReg_SP, sOP_m_none , 0x0001
OPs_45: dw sOP_Inc, sReg_BP, sOP_m_none , 0x0001
OPs_46: dw sOP_Inc, sReg_SI, sOP_m_none , 0x0001
OPs_47: dw sOP_Inc, sReg_DI, sOP_m_none , 0x0001
OPs_48: dw sOP_Dec, sReg_AX, sOP_m_none , 0x0001
OPs_49: dw sOP_Dec, sReg_CX, sOP_m_none , 0x0001
OPs_4A: dw sOP_Dec, sReg_DX, sOP_m_none , 0x0001
OPs_4B: dw sOP_Dec, sReg_BX, sOP_m_none , 0x0001
OPs_4C: dw sOP_Dec, sReg_SP, sOP_m_none , 0x0001
OPs_4D: dw sOP_Dec, sReg_BP, sOP_m_none , 0x0001
OPs_4E: dw sOP_Dec, sReg_SI, sOP_m_none , 0x0001
OPs_4F: dw sOP_Dec, sReg_DI, sOP_m_none , 0x0001
OPs_50: dw sOP_Push, sReg_AX, sOP_m_none , 0x0001
OPs_51: dw sOP_Push, sReg_CX, sOP_m_none , 0x0001
OPs_52: dw sOP_Push, sReg_DX, sOP_m_none , 0x0001
OPs_53: dw sOP_Push, sReg_BX, sOP_m_none , 0x0001
OPs_54: dw sOP_Push, sReg_SP, sOP_m_none , 0x0001
OPs_55: dw sOP_Push, sReg_BP, sOP_m_none , 0x0001
OPs_56: dw sOP_Push, sReg_SI, sOP_m_none , 0x0001
OPs_57: dw sOP_Push, sReg_DI, sOP_m_none , 0x0001
OPs_58: dw sOP_Pop, sReg_AX, sOP_m_none , 0x0001
OPs_59: dw sOP_Pop, sReg_CX, sOP_m_none , 0x0001
OPs_5A: dw sOP_Pop, sReg_DX, sOP_m_none , 0x0001
OPs_5B: dw sOP_Pop, sReg_BX, sOP_m_none , 0x0001
OPs_5C: dw sOP_Pop, sReg_SP, sOP_m_none , 0x0001
OPs_5D: dw sOP_Pop, sReg_BP, sOP_m_none , 0x0001
OPs_5E: dw sOP_Pop, sReg_SI, sOP_m_none , 0x0001
OPs_5F: dw sOP_Pop, sReg_DI, sOP_m_none , 0x0001
OPs_60: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_61: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_62: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_63: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_64: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_65: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_66: dw sOP_Empty, sOP_m_none, sOP_m_none , 0x0000
OPs_67: dw sOP_Empty, sOP_m_none, sOP_m_none , 0x0000
OPs_68: dw sOP_Empty, sOP_m_none, sOP_m_none , 0x0000
OPs_69: dw sOP_Unsupported, sOP_m_none, sOP_m_none  , 0x0000
OPs_6A: dw sOP_Unsupported, sOP_m_none, sOP_m_none  , 0x0000
OPs_6B: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_6C: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_6D: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_6E: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_6F: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_70: dw sOP_Jo, sOP_m_short, sOP_m_none , 0x0001
OPs_71: dw sOP_Jno, sOP_m_short, sOP_m_none , 0x0001
OPs_72: dw sOP_Jb, sOP_m_short, sOP_m_none , 0x0001
OPs_73: dw sOP_Jae, sOP_m_short, sOP_m_none , 0x0001
OPs_74: dw sOP_Jz, sOP_m_short, sOP_m_none , 0x0001
OPs_75: dw sOP_Jnz, sOP_m_short, sOP_m_none , 0x0001
OPs_76: dw sOP_Jbe, sOP_m_short, sOP_m_none , 0x0001
OPs_77: dw sOP_Ja, sOP_m_short, sOP_m_none , 0x0001
OPs_78: dw sOP_Js, sOP_m_short, sOP_m_none , 0x0001
OPs_79: dw sOP_Jns, sOP_m_short, sOP_m_none , 0x0001
OPs_7A: dw sOP_Jns, sOP_m_short, sOP_m_none , 0x0001
OPs_7B: dw sOP_Jpo, sOP_m_short, sOP_m_none , 0x0001
OPs_7C: dw sOP_Jl, sOP_m_short, sOP_m_none , 0x0001
OPs_7D: dw sOP_Jge, sOP_m_short, sOP_m_none , 0x0001
OPs_7E: dw sOP_Jle, sOP_m_short, sOP_m_none , 0x0001
OPs_7F: dw sOP_Jg, sOP_m_short, sOP_m_none , 0x0001
OPs_80: dw sOP_Empty, sOP_m_rm, sOP_m_imm8 , 0x0001
OPs_81: dw sOP_Empty, sOP_m_rm, sOP_m_imm16 , 0x0001
OPs_82: dw sOP_Empty, sOP_m_rm, sOP_m_imm8 , 0x0001
OPs_83: dw sOP_Empty,  sOP_m_rm, sOP_m_immE8 , 0x0001
OPs_84: dw sOP_Test, sOP_m_rm, sOP_m_reg8 , 0x0001
OPs_85: dw sOP_Test, sOP_m_rm, sOP_m_reg16 , 0x0001
OPs_86: dw sOP_Xchg, sOP_m_reg8, sOP_m_rm, 0x0001
OPs_87: dw sOP_Xchg, sOP_m_reg16, sOP_m_rm, 0x0001
OPs_88: dw sOP_Mov, sOP_m_rm, sOP_m_reg8 , 0x0001
OPs_89: dw sOP_Mov, sOP_m_rm, sOP_m_reg16 , 0x0001
OPs_8A: dw sOP_Mov, sOP_m_reg8, sOP_m_rm , 0x0001
OPs_8B: dw sOP_Mov, sOP_m_reg16, sOP_m_rm , 0x0001
OPs_8C: dw sOP_Mov, sOP_m_rm, sOP_m_segReg , 0x0001 
OPs_8D: dw sOP_Lea, sOP_m_reg16, sOP_m_rm , 0x0001
OPs_8E: dw sOP_Mov, sOP_m_segReg, sOP_m_rm , 0x0001 
OPs_8F: dw sOP_Pop, sOP_m_rm, sOP_m_none , 0x0001
OPs_90: dw sOP_Xchg, sReg_AX, sReg_AX , 0x0001 
OPs_91: dw sOP_Xchg, sReg_AX, sReg_CX , 0x0001
OPs_92: dw sOP_Xchg, sReg_AX, sReg_DX , 0x0001
OPs_93: dw sOP_Xchg, sReg_AX, sReg_BX , 0x0001
OPs_94: dw sOP_Xchg, sReg_AX, sReg_SP , 0x0001
OPs_95: dw sOP_Xchg, sReg_AX, sReg_BP , 0x0001
OPs_96: dw sOP_Xchg, sReg_AX, sReg_SI , 0x0001
OPs_97: dw sOP_Xchg, sReg_AX, sReg_DI , 0x0001
OPs_98: dw sOP_Cbw, sOP_m_none, sOP_m_none , 0x0001
OPs_99: dw sOP_Cwd, sOP_m_none, sOP_m_none , 0x0001
OPs_9A: dw sOP_Callf, sOP_m_far, sOP_m_none , 0x0001
OPs_9B: dw sOP_Wait, sOP_m_none, sOP_m_none , 0x0001
OPs_9C: dw sOP_Pushf, sOP_m_none, sOP_m_none , 0x0001
OPs_9D: dw sOP_Popf, sOP_m_none, sOP_m_none , 0x0001
OPs_9E: dw sOP_Sahf, sOP_m_none, sOP_m_none , 0x0001
OPs_9F: dw sOP_Lahf, sOP_m_none, sOP_m_none , 0x0001
OPs_A0: dw sOP_Mov, sReg_AL, sOP_m_immReg8 , 0x0001 
OPs_A1: dw sOP_Mov, sReg_AX, sOP_m_immReg16 , 0x0001
OPs_A2: dw sOP_Mov, sOP_m_immReg8, sReg_AL , 0x0001
OPs_A3: dw sOP_Mov, sOP_m_immReg16, sReg_AX , 0x0001
OPs_A4: dw sOP_Movsb, sOP_m_none, sOP_m_none , 0x0001
OPs_A5: dw sOP_Movsw, sOP_m_none, sOP_m_none , 0x0001
OPs_A6: dw sOP_Cmpsb, sOP_m_none, sOP_m_none , 0x0001
OPs_A7: dw sOP_Cmpsw, sOP_m_none, sOP_m_none , 0x0001
OPs_A8: dw sOP_Test, sReg_AL, sOP_m_imm8 , 0x0001
OPs_A9: dw sOP_Test, sReg_AX, sOP_m_imm16 , 0x0001
OPs_AA: dw sOP_Stosb, sOP_m_none, sOP_m_none , 0x0001
OPs_AB: dw sOP_Stosw, sOP_m_none, sOP_m_none , 0x0001
OPs_AC: dw sOP_Lodsb, sOP_m_none, sOP_m_none , 0x0001
OPs_AD: dw sOP_Lodsw, sOP_m_none, sOP_m_none , 0x0001
OPs_AE: dw sOP_Scasb, sOP_m_none, sOP_m_none , 0x0001
OPs_AF: dw sOP_Scasw, sOP_m_none, sOP_m_none , 0x0001
OPs_B0: dw sOP_Mov, sReg_AL, sOP_m_imm8 , 0x0001
OPs_B1: dw sOP_Mov, sReg_CL, sOP_m_imm8 , 0x0001
OPs_B2: dw sOP_Mov, sReg_DL, sOP_m_imm8 , 0x0001
OPs_B3: dw sOP_Mov, sReg_BL, sOP_m_imm8 , 0x0001
OPs_B4: dw sOP_Mov, sReg_AH, sOP_m_imm8 , 0x0001
OPs_B5: dw sOP_Mov, sReg_CH, sOP_m_imm8 , 0x0001
OPs_B6: dw sOP_Mov, sReg_DH, sOP_m_imm8 , 0x0001
OPs_B7: dw sOP_Mov, sReg_BH, sOP_m_imm8 , 0x0001
OPs_B8: dw sOP_Mov, sReg_AX, sOP_m_imm16 , 0x0001
OPs_B9: dw sOP_Mov, sReg_CX, sOP_m_imm16 , 0x0001
OPs_BA: dw sOP_Mov, sReg_DX, sOP_m_imm16 , 0x0001
OPs_BB: dw sOP_Mov, sReg_BX, sOP_m_imm16 , 0x0001
OPs_BC: dw sOP_Mov, sReg_SP, sOP_m_imm16 , 0x0001
OPs_BD: dw sOP_Mov, sReg_BP, sOP_m_imm16 , 0x0001
OPs_BE: dw sOP_Mov, sReg_SI, sOP_m_imm16 , 0x0001
OPs_BF: dw sOP_Mov, sReg_DI, sOP_m_imm16 , 0x0001  ;between here
OPs_C0: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_C1: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_C2: dw sOP_Ret, sOP_m_imm16, sOP_m_none , 0x0001
OPs_C3: dw sOP_Ret, sOP_m_none, sOP_m_none , 0x0001
OPs_C4: dw sOP_Les, sOP_m_reg16, sOP_m_rm , 0x0001
OPs_C5: dw sOP_Lds, sOP_m_reg16, sOP_m_rm , 0x0001
OPs_C6: dw sOP_Mov, sOP_m_rm, sOP_m_imm8 , 0x0001
OPs_C7: dw sOP_Mov, sOP_m_rm, sOP_m_imm16 , 0x0001
OPs_C8: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_C9: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_CA: dw sOP_Retf, sOP_m_imm16, sOP_m_none , 0x0001
OPs_CB: dw sOP_Retf, sOP_m_none, sOP_m_none , 0x0001
OPs_CC: dw sOP_Int, sReg_aConst3, sOP_m_none , 0x0001
OPs_CD: dw sOP_Int, sOP_m_imm8, sOP_m_none , 0x0001
OPs_CE: dw sOP_Into, sOP_m_none, sOP_m_none , 0x0001
OPs_CF: dw sOP_Iret, sOP_m_none, sOP_m_none , 0x0001
OPs_D0: dw sOP_Empty, sOP_m_rm, sReg_aConst1 , 0x0001
OPs_D1: dw sOP_Empty, sOP_m_rm, sReg_aConst1 , 0x0001
OPs_D2: dw sOP_Empty, sOP_m_rm, sReg_CL , 0x0001
OPs_D3: dw sOP_Empty, sOP_m_rm, sReg_CL , 0x0001
OPs_D4: dw sOP_Aam, sOP_m_imm8, sOP_m_none , 0x0001
OPs_D5: dw sOP_Aad, sOP_m_imm8, sOP_m_none , 0x0001
OPs_D6: dw sOP_Unsupported, sOP_m_none, sOP_m_none , 0x0000
OPs_D7: dw sOP_Xlat,  sOP_m_none, sOP_m_none , 0x0001
OPs_D8: dw sOP_Unknown,  sOP_m_none, sOP_m_none , 0x0000
OPs_D9: dw sOP_Unknown,  sOP_m_none, sOP_m_none , 0x0000
OPs_DA: dw sOP_Unknown,  sOP_m_none, sOP_m_none , 0x0000
OPs_DB: dw sOP_Unknown,  sOP_m_none, sOP_m_none , 0x0000
OPs_DC: dw sOP_Unknown,  sOP_m_none, sOP_m_none , 0x0000
OPs_DD: dw sOP_Unknown,  sOP_m_none, sOP_m_none , 0x0000
OPs_DE: dw sOP_Unknown,  sOP_m_none, sOP_m_none , 0x0000
OPs_DF: dw sOP_Unknown,  sOP_m_none, sOP_m_none , 0x0000
OPs_E0: dw sOP_Loopnz,  sOP_m_short, sOP_m_none , 0x0001
OPs_E1: dw sOP_Loopz,  sOP_m_short, sOP_m_none , 0x0001
OPs_E2: dw sOP_Loop,  sOP_m_short, sOP_m_none , 0x0001
OPs_E3: dw sOP_Jcxz,  sOP_m_short, sOP_m_none , 0x0001
OPs_E4: dw sOP_In,  sReg_AL, sOP_m_imm8 , 0x0001
OPs_E5: dw sOP_In,  sReg_AX, sOP_m_imm8 , 0x0001
OPs_E6: dw sOP_Out, sOP_m_imm8, sReg_AL , 0x0001
OPs_E7: dw sOP_Out,  sOP_m_imm8, sReg_AX , 0x0001
OPs_E8: dw sOP_Call,  sOP_m_near, sOP_m_none , 0x0001
OPs_E9: dw sOP_Jmp,  sOP_m_near, sOP_m_none , 0x0001
OPs_EA: dw sOP_Jmpf,  sOP_m_far, sOP_m_none , 0x0001
OPs_EB: dw sOP_Jmp,  sOP_m_short, sOP_m_none , 0x0001
OPs_EC: dw sOP_In,  sReg_AL, sReg_DX , 0x0001
OPs_ED: dw sOP_In,  sReg_AX, sReg_DX , 0x0001
OPs_EE: dw sOP_Out,  sReg_DX, sReg_AL , 0x0001
OPs_EF: dw sOP_Out,  sReg_DX, sReg_AX , 0x0001
OPs_F0: dw sOP_Lock,  sOP_m_none, sOP_m_none , 0x0001
OPs_F1: dw sOP_Unknown,  sOP_m_none, sOP_m_none , 0x0001
OPs_F2: dw sOP_Repne,  sOP_m_none, sOP_m_none , 0x0001
OPs_F3: dw sOP_Rep,  sOP_m_none, sOP_m_none , 0x0001
OPs_F4: dw sOP_Hlt,  sOP_m_none, sOP_m_none , 0x0001
OPs_F5: dw sOP_Cmc, sOP_m_none, sOP_m_none , 0x0001
OPs_F6: dw sOP_Empty, sOP_m_rm, sOP_m_none , 0x0001
OPs_F7: dw sOP_Empty, sOP_m_rm, sOP_m_none , 0x0001
OPs_F8: dw sOP_Clc, sOP_m_none, sOP_m_none , 0x0001
OPs_F9: dw sOP_Stc, sOP_m_none, sOP_m_none , 0x0001
OPs_FA: dw sOP_Cli, sOP_m_none, sOP_m_none , 0x0001
OPs_FB: dw sOP_Sti, sOP_m_none, sOP_m_none , 0x0001
OPs_FC: dw sOP_Cld, sOP_m_none, sOP_m_none , 0x0001
OPs_FD: dw sOP_Std, sOP_m_none, sOP_m_none , 0x0001
OPs_FE: dw sOP_Empty, sOP_m_rm, sOP_m_none , 0x0001
OPs_FF: dw sOP_Empty, sOP_m_rm, sOP_m_none , 0x0001

   
	
times 500 dw 0


