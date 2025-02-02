;**********************************************************************;
;                                                                      ;
;   This file is part of ZSM4, a Z80/Z180/Z280 relocatable macro-      ;
;   assembler written in Z80 assembly.                                 ;
;   Copyright (C) 2017-2020, Hector Peraza.                            ;
;   Modified by Ladislau Szilagyi ( dec 2021 - jan 2022 )              ;                           ;                                                                      ;
;   This program is free software; you can redistribute it and/or      ;
;   modify it under the terms of the GNU General Public License as     ;
;   published by the Free Software Foundation; either version 2 of     ;
;   the License, or (at your option) any later version.                ;
;                                                                      ;
;   This program is distributed in the hope that it will be useful,    ;
;   but WITHOUT ANY WARRANTY; without even the implied warranty of     ;
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the      ;
;   GNU General Public License for more details.                       ;
;                                                                      ;
;   You should have received a copy of the GNU General Public License  ;
;   along with this program; if not, write to the Free Software        ;
;   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.          ;
;                                                                      ;
;**********************************************************************;

*include        ZSM.INC

;local
        global  VAL
        global  ERRFLG,BACKUP,GNC,CPU
        global  PCFLAG,CURSEG
        global  OERROR,EVMODE
        global  GETPPC
        global  REQCHR
        global  HOFMSG,HOFNAM,HOFDAT,HOFTIM,HOFPG,HOFEND
        global  HDRBUF,REC,TITLEB,SBTTLB,IDLEN,IDBUF
	GLOBAL	ENDMARK

;external
        global  CMPHD
        global  EVAL,EVALNEW,EVALREG
        global  EVALCND,EVBRKT
        global  EVALSRG
        global  RELERR,REGVAL

        global  TYPTBL,CL1,CL2,CL3,CL4,CL5,CL6,CL7,CL8,CL9
        global  CL10,CL11,CL12,CL13,CL14,CL15,CL16,CL17,CL18,CL19
        global  CL20,CL21,CL22,CL23,CL24,CL25,CL26,CL27

        global  EMITB,REQ8U,SWITCH
        global  EMITV,OPCODE,EMITW,EMITVR
        global  MERROR,SETMDF,CCONST,MDFLVL,PERROR,WLOC,MAXLNE,ID
        global  SYMLUK,MCHECK,WERROR,GETSTR,ADDSYM,UCASE,OPNLIB
        global  DEFMAC,DFREPT,DFIRP,DFIRPC,MACLVL,ENDMAC
        global  CLINE,LSTB,WOBJ,WOBJ16,LSTW
        global  IDTOUP

        global  S662,S552,S321

        global  SYMPTR
        global  DSPTR
        global  NAMLEN
        global  MODNAM
        global  MODIDN
        global  CPU
        global  DEFCPU
        global  PC
        global  ASEGPC
        global  CSEGPC
        global  DSEGPC
        global  BSEGPC
        global  LEN
        global  LENDS
        global  CURSEG
;       global  CSSIZE
;       global  DSSIZE
        global  BSSIZE
;       global  CURCMN
;       global  LASTCM
        global  PTR1
        global  PASSNO
        global  CURLNE
        global  EQUFLG
        global  LBLFLG
        global  DSFLAG
        global  DBWFLG
        global  LOCFLG
        global  NEWSYM
        global  ENDADR
        global  ENDMOD
        global  EFLG
        global  OPCODE
        global  RADIX
        global  COMNTC
        global  VAL
        global  EVMODE
        global  EXTCHN
        global  CMNPTR
        global  SAVVAL
        global  SAVMOD
        global  SAVCHN
        global  SAVCMN
        global  LPFLAG
        global  LSTCNT
        global  LFLAG
        global  OFLAG
        global  QFLAG
        global  UMODE
        global  ZERODS
        global  ERRFLG
        global  ERRCNT
        global  MACFLG
        global  SYMPTR
        global  MAXMEM
        global  DSPTR
        global  PCFLAG
        global  UFLAG
        global  EVFLGS
        global  LSTOPT
        global  IFLIST
        global  NOLIST
;       global  PHFLAG
;        global  PHDIFF
        global  CONDSP
        global  CNDSTK
        global  CLEVEL
        global  SYMMOD
        global  SYMADR
        global  IDADR
        global  SYMTBL
        global  REC
        global  HDRBUF
        global  HOFDAT
        global  HOFTIM
        global  HOFNAM
        global  HOFPG
        global  HOFMSG
        global  HOFEND
        global  TITLEB
        global  SBTTLB
        global  IDLEN
        global  IDBUF
        global  OPLEN
        global  OPCODES
;       global  SELCMN
;       global  UPDSIZ
        global  CMPSYM
        global  EMITSV
        global  VALERR
        global  EMITSR
        global  SAVVARS
        global  ADDEXT
        global  CHK8U
        global  ERRQ

        psect   text

;       SUBTTL  Instruction Class 27 - Pseudo-operators
;
;       Class 27 - Pseudo operators
;
CL27:   ld      a,(OPCODE)
        dec     a
        ld      hl,PSDTAB
        jp      SWITCH
;
PSDTAB: defw    S300            ; EQU,ASET,DEFL
        defw    S307            ; DEFS,DS
        defw    S308            ; DEFB,DEFC,DEFM,DEFZ,DB,DC
        defw    S317            ; DEFW,DW
        defw    S320            ; END
        defw    S323            ; ORG
        defw    S324            ; FORM,PAGE,EJECT
        defw    S330            ; IF
        defw    S340            ; ELSE
        defw    S350            ; ENDIF
        defw    S360            ; LIST,.LIST,.XLIST,.LALL,.XALL,.SALL,etc.
        defw    S370            ; TITLE,SUBTTL
        defw    S390            ; CSEG
        defw    S391            ; DSEG
        defw    S380            ; ASEG
        defw    S392            ; COMMON
        defw    S500            ; PUBLIC
        defw    S520            ; EXTERN
        defw    S530            ; .Z80,.Z180,.Z280
        defw    S540            ; .EVEN,.ODD
        defw    S550            ; NAME
        defw    S560            ; IDENT
        defw    S570            ; INCLUDE,MACLIB
        defw    S580            ; MACRO,RETP,IRP,IRPC
        defw    S590            ; ENDM
        defw    S600            ; EXITM
        defw    S610            ; LOCAL
        defw    S620            ; RQST,.REQUEST
        defw    S630            ; .PHASE,.DEPHASE
        defw    S640            ; .RADIX
        defw    S650            ; .PRINTX
        defw    S660            ; .COMMENT
        defw    S670            ; PSECT
;
;       EQU, ASET, DEFL
;
S300:   ld      hl,(IDADR)      ; check for preceding symbol
        ld      a,h
        or      l
        jp      z,OERROR        ; error if not present
        ld      c,(hl)          ; save identity char
        push    bc
        call    EVALNEW         ; get value
        pop     bc

        ld      a,(OPCODE+1)
        or      a               ; ASET/DEFL?
        ld      b,DFLNAME
        jr      nz,S301         ; branch if yes
        ld      b,EQUNAME       ; else type is EQU

S301:   ld      a,(NEWSYM)
        or      a               ; new symbol?
        jr      nz,S305         ; branch if yes

        ld      a,c             ; fetch identity char
        and     0E0h
        cp      MULTDEF         ; multiple defined?
        jr      z,S304          ; multi defined error if yes

        ld      hl,(SYMADR)
        inc     hl
        inc     hl
        ld      a,(hl)
        and     UNDEF           ; UNDEF bit set?
        jr      nz,S305         ; handle like new symbol if yes

        ld      a,(hl)
        and     EXTSYM          ; External bit set?
        jr      nz,S304         ; multi-defined error if yes

        ld      a,c
        and     0E0h
        cp      b               ; same type? (EQU or DEFL)
        jr      nz,S304         ; multi defined error if not
        cp      DFLNAME         ; DEFL?
        jr      z,S305          ; set/modify value if yes

        call    CMPSYM          ; same value and mode?
        jr      nc,S306         ; return if yes, else is multi def error

S304:   ld      a,(PASSNO)
        or      a
        jr      z,S303          ; branch if pass 1
        call    MERROR          ; else output multi defined error
        jr      S306
S303:   call    SETMDF          ; set multi defined flag
        jr      S306
;
;       New symbol
;
S305:   ld      a,(OPCODE+1)
        or      a               ; ASET/DEFL?
        ld      b,DFLNAME
        jr      nz,S305A        ; branch if yes
        ld      b,EQUNAME       ; else type is EQU
S305A:  ld      hl,(SYMADR)
        ld      de,(VAL)
        ld      (hl),e          ; store value
        inc     hl
        ld      (hl),d
        inc     hl
        ld      a,(EVMODE)
        ld      (hl),a          ; set mode
;       inc     hl
;       ld      de,(CMNPTR)
;       ld      (hl),e          ; set pointer to COMMON block
;       inc     hl
;       ld      (hl),d

        ld      hl,(IDADR)
        ld      a,(hl)
        and     1Fh             ;0Fh
        or      b               ; set type to EQUNAME or DFLNAME
        ld      (hl),a

        ld      c,a
        ld      a,(UFLAG)
        or      a
        ld      a,c
        jr      z,S306          ; branch if UFLAG not set

        ld      hl,(SYMADR)
        inc     hl
        inc     hl
        ld      a,(hl)
        or      UNDEF           ; else set UNDEF bit (if UFLAG is set
        ld      (hl),a          ;  on pass 2, 'U' error will be automatically
                                ;   generated by LSTOUT.)

S306:   ld      a,1
        ld      (EQUFLG),a
        ret
;
;       Check if symbol matches expected value. Used by EQU, DEFL and label
;       definition routines.
;
CMPSYM: ld      hl,(SYMADR)
        ld      e,(hl)
        inc     hl
        ld      d,(hl)
        push    hl
        ld      hl,(VAL)
        call    CMPHD
        pop     hl
        scf
        ret     nz              ; values differ
        inc     hl
        ld      a,(EVMODE)
        xor     (hl)
        and     0C0h .or. EXTSYM        ; ignore PUBLIC and UNDEF bits
        scf
        ret     nz              ; mode differs
        or      a               ; CARRY=0
        ret
;       and     0C0h
;       cp      0C0h
;       ccf
;       ret     nz              ; not COMMON, OK
;       inc     hl
;       ld      e,(hl)
;       inc     hl
;       ld      d,(hl)
;       ld      hl,(CMNPTR)
;       call    CMPHD
;       ret     z               ; same COMMON, OK
;       scf
;       ret                     ; COMMONs differ
;
;       DEFS, DS
;
S307:   call    EVALNEW
        ld      (LENDS),hl
        ld      a,(PASSNO)
        or      a
        jr      z,1f
        ld      de,(BSSIZE)     ;only on PASS 2
        add     hl,de
        ld      (BSSIZE),hl
1:
        ld      a,1
        ld      (DSFLAG),a
        ld      a,(EVMODE)
        or      a
        jp      nz,RELERR
        ret
;
;       DEFB, DEFC, DEFM, DEFZ, DB, DC
;
S308:   ld      a,1
        ld      (DBWFLG),a
        ld      a,(OPCODE+1)
        dec     a
        jp      z,S310          ; branch if DC
S308A:  call    GNC             ; get next non-blank char
        or      a
        jp      z,OERROR
        ld      hl,(PTR1)
        ld      c,a             ; save possible quote char in reg C
        cp      27H             ;' quote?
        jr      z,S308Q
        cp      '"'             ; both single and double allowed
        jr      nz,S308C
S308Q:  push    hl
        call    CCONST          ; character constant?
        pop     hl
        jr      c,S314          ; branch if not to process string
        ld      a,d
        or      a
        jr      nz,S314
S308C:  dec     hl              ; point to prev char
        ld      (PTR1),hl
        call    EVALNEW         ; evaluate expression
        ld      a,(EVMODE)
        call    REQ8U           ; require 8-bit value
        ld      a,l
        call    EMITB           ; output value
S308B:  call    GNC             ; fetch next non-blank char from record
        or      a               ; end of record?
        jr      z,S308D         ; done
        cp      ','             ; separator?
        jp      z,S308A         ; process next item if yes
        jp      DEBEND          ; else expression error
S308D:  ld      a,(OPCODE+1)
        or      a               ; test for DEFZ
        ret     z
        xor     a
        jp      EMITB           ; if DEFZ, emit an extra zero byte
;
S313:   call    EMITB           ; output char
        inc     hl
S314:   ld      a,(hl)
        or      a
        jr      z,ERRQ          ; end without another quote?
        cp      c               ; quote?
        jr      nz,S313         ; loop until found
        inc     hl              ; incr record ptr
        ld      a,(hl)
        cp      c
        jr      z,S313          ; double quotes
        ld      (PTR1),hl
        jr      S308B           ; process terminator/separators
;
DEBEND: ld      a,'E'           ; load expression error
        ld      (ERRFLG),a      ; set flag
        ret                     ; done
;
ERRQ:   ld      a,'Q'
        ld      (ERRFLG),a
        ret
;
;       DC, DEFC
;
S310:   call    GNC             ; get next non-blank char
        or      a
        jp      z,OERROR
        ld      hl,(PTR1)
        ld      c,0
        ld      b,a             ; save possible quote char in reg B
        cp      27H             ;' quote?
        jr      z,S312
        cp      '"'             ; both single and double allowed
        jr      z,S312
        jp      OERROR          ; error if no quote
S311:   ld      e,a
        ld      a,c
        ld      c,e
        or      a
        call    nz,EMITB        ; output char
        inc     hl
S312:   ld      a,(hl)
        or      a
        jr      z,ERRQ          ; end without another quote?
        cp      b               ; quote?
        jr      nz,S311         ; loop until found
        inc     hl              ; incr record ptr
        ld      a,(hl)
        cp      b
        jr      z,S311          ; double quotes
        ld      a,c
        or      80h
        cp      80h
        call    nz,EMITB
        ld      (PTR1),hl
        call    GNC             ; fetch next non-blank char from record
        or      a               ; end of record?
        ret     z               ; done
        cp      ','             ; separator?
        jr      z,S310          ; process next item if yes
        jp      DEBEND          ; else expression error
;
;       DW, DEFW
;
S317:   ld      a,1
        ld      (DBWFLG),a
S317A:  call    GNC
        or      a
        jp      z,OERROR
        ld      hl,(PTR1)
        ld      c,a             ; save possible quote in reg C
        ld      b,0             ; char counter
        cp      27H             ;' quote?
        jr      z,S317Q
        cp      '"'             ; both single and double allowed
        jr      nz,S317C
S317Q:  push    hl
        call    CCONST          ; test for character constant
        pop     hl
        jr      c,S318
S317C:  dec     hl              ; point to prev char
        ld      (PTR1),hl       ; restore new ptr
        call    EVALNEW
        call    EMITV           ; output value
S317B:  call    GNC             ; fetch next non-blank char from record
        or      a               ; end of record?
        ret     z               ; done
        cp      ','             ; separator?
        jp      z,S317A         ; process next item if yes
        jp      DEBEND          ; else expression error
;
S318A:  call    EMITB
        inc     hl
        inc     b               ; chars in this string
S318:   ld      a,(hl)
        or      a
        jp      z,ERRQ          ; end without another quote?
        cp      c
        jr      nz,S318A
        inc     hl              ; incr record ptr
        ld      a,(hl)
        cp      c
        jr      z,S318A         ; double quotes
        ld      (PTR1),hl
        ld      a,b             ; get length of string
        rra                     ; is it even?
        jr      nc,S317B        ; finished if so
        xor     a               ; else load upper byte with 0
        call    EMITB           ;  to make a word
        jr      S317B           ; process terminator/separators
;
;       END
;
S320:   call    GNC             ; argument present (program start address)?
        or      a
        ld      hl,0
        ld      a,0
        jr      z,S320A         ; branch if not
        call    BACKUP
        call    EVALNEW         ; else get argument
	ld	a,0FFH
	ld	(ENDMARK),a	;mark END START
        ld      a,(EVMODE)
S320A:  ld      (ENDADR),hl
        ld      (VAL),hl
        ld      (ENDMOD),a
        ld      (EVMODE),a
        ld      a,1
        ld      (EQUFLG),a
S321:   ld      a,1
        ld      (EFLG),a
        ld      a,(CLEVEL)      ; check conditionals stack level
        or      a               ; at zero?
        call    nz,S322         ; error if not
        ld      a,(MDFLVL)      ; check MACRO def level
        or      a               ; at zero?
        ret     z               ; return if yes
        xor     a               ; else an ENDM is missing somewhere
        ld      (MDFLVL),a      ; reset level
        ld      hl,(SYMPTR)
        ld      (hl),a          ; restore end of symbol table marker
S322:   ld      a,'T'+80h       ; and force error output
        ld      (ERRFLG),a
        ret
;
;       ORG	= ASEG + set PC
;
S323:
;       ld      a,(PHFLAG)
;       or      a
;       jp      nz,PERROR       ; not allowed within .PHASE
;       call    UPDSIZ          ; update current segment size
        call    SAVEPC          ; save PC for current segment
	xor	a		
        ld      (CURSEG),a      ; set current segment type to Absolute
        call    EVALNEW
        ld      (PC),hl
        ld      a,(PASSNO)
        or      a
        ld      e,0		; crt seg
        call    nz,WLOC
        xor     a
        ld      (LOCFLG),a
        inc     a
        ld      (EQUFLG),a
        ret
;
;       FORM, PAGE, EJECT
;
S324:   ld      a,(OPCODE+1)
        or      a               ; PAGE?
        jr      z,S325          ; branch if not
        call    GNC
        or      a               ; argument follows?
        jr      z,S325          ; branch if not
        call    BACKUP
        call    EVALNEW         ; else evaluate expression
        ld      a,(EVMODE)
        call    REQ8U           ; result must be 8-bit unsigned, non-reloc
        ld      a,h
        or      a
        jr      nz,S325
        ld      a,l
        cp      10              ; in the range 10..255
        call    c,VALERR
        ld      (MAXLNE),a      ; set new page length
S325:   ld      a,(MAXLNE)
        ld      (CURLNE),a      ; cause hof on record after FORM/PAGE/EJECT
        ld      (NOLIST),a      ; suppress listing of FORM, PAGE, EJECT
        ret
;
;       IFxxx
;
S330:   ld      hl,(CONDSP)
        ld      a,(hl)          ; check current state
        rra
        jr      nc,S333         ; if false, simply inc depth level and return
        ld      a,(OPCODE+1)
        ld      hl,IFTBL
        jp      SWITCH

IFTBL:  defw    ZIF             ; IF
        defw    ZIF1            ; IF1
        defw    ZIF2            ; IF2
        defw    ZIF             ; IFT
        defw    ZIFF            ; IFF
        defw    ZIFDEF          ; IFDEF
        defw    ZIFNDF          ; IFNDEF
        defw    ZIFB            ; IFB
        defw    ZIFNB           ; IFNB
        defw    ZIFIDN          ; IFIDN
        defw    ZIFDIF          ; IFDIF
        defw    ZIF80           ; IFZ80
        defw    ZIF180          ; IFZ180
        defw    ZIF280          ; IFZ280
;
;       IF, IFT
;
ZIF:    ld      c,0
        jr      S331
;
;       IFF
;
ZIFF:   ld      c,0FFh
S331:   push    bc
        call    EVALNEW         ; evaluate the expression
        pop     bc
        ld      a,(ERRFLG)
        cp      ' '
        jr      nz,S332         ; on error, force true state
        ld      a,l             ; test for zero
        or      h               ; zero = false, non zero = true
S332:   add     a,0FFh
        sbc     a,a             ; make value 0FFh or 00h
        xor     c               ; complement result if IFF
S333:   ld      hl,(CONDSP)     ; get conditional stack pointer
        and     (hl)            ; include current state
        and     7Fh             ; clear ELSE bit
        ld      c,a             ; and save for later as new state
        ld      a,(CLEVEL)      ; get the stack depth
        cp      CSTKSZ          ; test for maximum level
        jr      nc,S334         ; error if already at max depth
        inc     a               ; inc to next depth
        ld      (CLEVEL),a      ; and store
        dec     hl              ; push stack
        ld      (CONDSP),hl     ; save new SP
        ld      (hl),c          ; put new state in stack
        ld      a,0FFh          ; suppress IF, ELSE, ENDIF
        ld      (IFLIST),a      ;  if "NOCOND"
        ret                     ;   & finish off
;
S334:   ld      a,'A'           ; stack ov'flow
S335:   ld      (ERRFLG),a
        ret                     ; finish off
;
;       IF1
;
ZIF1:   ld      a,(PASSNO)      ; 00h = pass 1, 0FFh = pass 2
        cpl
        jr      S333
;
;       IF2
;
ZIF2:   ld      a,(PASSNO)      ; 00h = pass 1, 0FFh = pass 2
        jr      S333
;
;       IFZ80
;
ZIF80:  ld      c,0
        jr      S341
;
;       IFZ180
;
ZIF180: ld      c,1
        jr      S341
;
;       IFZ280
;
ZIF280: ld      c,2
S341:   ld      a,(CPU)
        sub     c               ; 00h if CPU matches
        ld      c,0FFh
        jr      S332
;
;       IFDEF
;
ZIFDEF: ld      c,0
        jr      S336
;
;       IFNDEF
;
ZIFNDF: ld      c,0FFh
S336:   push    bc
        call    ID              ; get symbol name
        ld      de,(SYMTBL)     ; start of symbol table
        ld      c,3             ;5
        call    SYMLUK          ; lookup symbol
        pop     bc
        ld      a,0
        jr      c,S332
        inc     hl
        inc     hl
        ld      a,(hl)          ; get mode bits
        cpl
        and     EXTSYM
        jr      S332
;
;       IFB
;
ZIFB:   ld      c,0FFh
S337:   push    bc
        ld      bc,RECMAX
        call    MCHECK          ; ensure enough memory for the string
        pop     bc
        jp      c,WERROR
        call    GNC
        cp      '<'             ; angle brackets are required
        jp      nz,OERROR
        call    BACKUP
        ld      de,(SYMPTR)
        inc     de              ; leave the end marker intact
        push    de
        push    bc
        call    GETSTR          ; get the string
        pop     bc
        ex      de,hl
        pop     de
        or      a
        sbc     hl,de           ; compute string length
        ld      a,h
        or      l
        jp      S332            ; length zero means TRUE
;
;       IFNB
;
ZIFNB:  ld      c,0
        jr      S337
;
;       IFIDN
;
ZIFIDN: ld      c,0FFh
S338:   push    bc
        ld      bc,RECMAX
        call    MCHECK          ; ensure enough memory for the strings
        pop     bc
        jp      c,WERROR
        call    GNC
        cp      '<'             ; angle brackets are required
        jp      nz,OERROR
        call    BACKUP
        ld      de,(SYMPTR)
        inc     de              ; leave the end marker intact
        push    de
        push    bc
        call    GETSTR          ; get the string
        pop     bc
        xor     a
        ld      (de),a
        inc     de
        pop     hl
        call    GNC
        cp      ','
        jp      nz,OERROR
        call    GNC
        cp      '<'
        jp      nz,OERROR
        push    bc
        push    de
        push    hl
        call    BACKUP
        call    GETSTR
        xor     a
        ld      (de),a
        pop     hl
        pop     de
        pop     bc
S339:   ld      a,(de)
        ld      b,a
        sub     (hl)
        jp      nz,S332
        ld      a,b
        or      a
        jp      z,S332
        inc     hl
        inc     de
        jr      S339
;
;       IFDIF
;
ZIFDIF: ld      c,0
        jr      S338
;
;       ELSE
;
S340:   ld      a,(CLEVEL)      ; get stack depth
        or      a               ; test if empty
        jr      z,S342
        ld      hl,(CONDSP)     ; get stack pointer
        ld      a,(hl)          ; get current state
        or      a               ; test ELSE bit
        jp      m,S343          ; error if set
        cpl                     ; flip state
        inc     hl              ; point to previous state
        and     (hl)            ; include in test
        dec     hl              ; point to current state again
        or      80h             ; set ELSE bit
        ld      (hl),a          ; and save new state
        ld      a,0FFh          ; suppress IF, ELSE, ENDIF
        ld      (IFLIST),a      ;  if "NOCOND"
        ret
;
S343:   inc     hl
        ld      a,(hl)
        rrca
        and     80h             ; force error if prev cond state is true
S342:   or      'C'             ; misplaced ELSE error
        jp      S335
;
;       ENDIF
;
S350:   ld      a,(CLEVEL)      ; get stack depth
        or      a               ; test if empty
        jr      z,S352
        dec     a               ; reduce depth
        ld      (CLEVEL),a      ; save new depth
        ld      hl,(CONDSP)     ; get conditional stack pointer
        inc     hl              ; pop a state
        ld      (CONDSP),hl     ; and put back
        ld      a,0FFh          ; suppress IF, ELSE, ENDIF
        ld      (IFLIST),a      ;  if "NOCOND"
        ret                     ; finish off
;
S352:   ld      a,'B'           ; stack underflow
        jp      S335
;
;       LIST control operator
;
;       ON       Enable listing
;       OFF      Disable listing
;       COND     Display FALSE conditional code
;       NOCOND   Don't display FALSE conditional code
;       SYMBOL   Produce symbols in output
;       NOSYMBOL Don't produce symbols in output
;       SORT     Sort symbols in output
;       NOSORT   Don't sort symbols in output
;       MACROS   Display full MACRO expansions
;       XMACROS  Display only MACRO lines that generate code
;       NOMACROS Don't display MACRO expansions
;
S360:   ld      ix,LSTOPT       ; IX points to LIST options byte
        ld      a,(OPCODE+1)    ; test for shortcuts
        dec     a
        jp      p,S362
S361:   call    ID              ; else get operand
	call	IDTOUP
        ld      a,(IDLEN)
        or      a               ; valid?
        jp      z,OERROR        ; early error exit
        ld      de,LSTOPS       ; LIST operands
        ld      c,1
        call    SYMLUK          ; lookup name
        jp      c,OERROR        ; error if not found
        ld      a,(hl)          ; get value
        ld      hl,S363
        push    hl              ; push return address
S362:   ld      hl,LSTTAB
        jp      SWITCH
S363:   call    GNC
        cp      ','             ; more options?
        jr      z,S361          ; loop if yes
        ret
;
LSTOPS: defb    2
        defm    'ON'
        defb    0
        defb    3
        defm    'OFF'
        defb    1
        defb    4
        defm    'COND'
        defb    2
        defb    6
        defm    'NOCOND'
        defb    3
        defb    6
        defm    'SYMBOL'
        defb    4
        defb    8
        defm    'NOSYMBOL'
        defb    5
        defb    4
        defm    'SORT'
        defb    6
        defb    6
        defm    'NOSORT'
        defb    7
        defb    6
        defm    'MACROS'
        defb    8
        defb    7
        defm    'XMACROS'
        defb    9
        defb    8
        defm    'NOMACROS'
        defb    10
        defb    0
;
LSTTAB: defw    LST10           ; ON            .LIST
        defw    LST20           ; OFF           .XLIST
        defw    LST30           ; COND          .LFCOND
        defw    LST40           ; NOCOND        .SFCOND
        defw    LST50           ; SYMBOL
        defw    LST60           ; NOSYMBOL
        defw    LST70           ; SORT
        defw    LST80           ; NOSORT
        defw    LST90           ; MACROS        .LALL
        defw    LST91           ; XMACROS       .XALL
        defw    LST92           ; NOMACROS      .SALL
;
;       ON
;
LST10:  set     LISTFL,(ix)
        ret
;
;       OFF
;
LST20:  res     LISTFL,(ix)
        ret
;
;       COND
;
LST30:  set     CONDFL,(ix)
        ret
;
;       NOCOND
;
LST40:  res     CONDFL,(ix)
        ret
;
;       SYMBOL
;
LST50:  set     SYMBLS,(ix)
        ret
;
;       NOSYMBOL
;
LST60:  res     SYMBLS,(ix)
        ret
;
;       SORT
;
LST70:  set     SORTFL,(ix)
        ret
;
;       NOSORT
;
LST80:  res     SORTFL,(ix)
        ret
;
;       MACROS
;
LST90:  set     MACRFL,(ix)
        res     XMACFL,(ix)
        ret
;
;       XMACROS
;
LST91:  set     MACRFL,(ix)
        set     XMACFL,(ix)
        ret
;
;       NOMACROS
;
LST92:  res     MACRFL,(ix)
        ret
;
;       TITLE, SUBTTL
;
S370:   ld      a,(OPCODE+1)
        or      a
        ld      hl,TITLEB       ; point to title buffer
        ld      b,80            ; maximum count
        jr      z,S371          ; branch if TITLE
        ld      hl,SBTTLB       ; else is SUBTTL
        ld      b,60            ; maximum count
S371:   call    GNC             ; get next non blank
        ld      de,(PTR1)       ; get REC pointer into DE
        or      a               ; null title?
        jr      z,S374          ; finish if so
        ld      c,a
        cp      '"'
        jr      z,S372          ; quotes are optional,
        cp      27H             ;' and removed if present
        jr      z,S372
        ld      c,0
        dec     de
S372:   ld      a,(de)          ; get a char
        or      a               ; end of line
        jr      z,S374          ; exit if so
        inc     de              ; update REC pointer
        cp      c
        jr      z,S374
        ld      (hl),a          ; store character
        inc     hl              ; update buffer pointer
        djnz    S372            ; count down chars
S374:   cp      c
        call    nz,ERRQ
        ld      (hl),0          ; end with a null
        ld      (PTR1),de       ; update REC pointer
        ld      a,(OPCODE+1)
        or      a
        ret     nz              ; return if SUBTTL
        ld      a,(MAXLNE)      ; else cause hof on record after title
        ld      (CURLNE),a
        ld      (NOLIST),a      ; suppress listing of 'TITLE'
        ret
;
;       PSECT
;
S670:
        call    ID              ; get psect name
        ld      a,(ERRFLG)
        cp      ' '
        ret     nz              ; on error, return
        call    IDTOUP
        ld      hl,IDBUF
        ld      a,(hl)
        inc     hl
        cp      'T'
        jr      z,TEXT2
        cp      'D'
        jr      z,DATA2
        cp      'B'
        jr      z,BSS2
S671:
        ld      a,'L'
        ld      (ERRFLG),a
        ret
DATA2:
        ld      a,(hl)
        inc     hl
        cp      'A'
        jr      nz,S671
        ld      a,(hl)
        inc     hl
        cp      'T'
        jr      nz,S671
        ld      a,(hl)
        inc     hl
        cp      'A'
        jr      nz,S671
        jp      S391            ;PSECT DATA == DSEG
BSS2:
        ld      a,(hl)
        inc     hl
        cp      'S'
        jr      nz,S671
        ld      a,(hl)
        inc     hl
        cp      'S'
        jr      nz,S671
                                ;PSECT BSS
;       ld      a,(PHFLAG)
;       or      a
;       jp      nz,PERROR       ; not allowed within .PHASE
        ld      a,(LOCFLG)
        or      a
        ld      a,(CURSEG)
        jr      nz,S672
        cp      0C0h
        ret     z               ; current segment is BSS, ignore
S672:
;       call    UPDSIZ          ; update current segment size
        call    SAVEPC          ; save PC for current segment
        ld      hl,(BSEGPC)
        ld      (PC),hl         ; and load PC with latest Data PC
        ld      e,0C0h          ; segment type = BSS
        jp      S396            ; set segment type and loc counter

TEXT2:
        ld      a,(hl)
        inc     hl
        cp      'E'
        jr      nz,S671
        ld      a,(hl)
        inc     hl
        cp      'X'
        jr      nz,S671
        ld      a,(hl)
        inc     hl
        cp      'T'
        jr      nz,S671
        ld      a,(IDLEN)
        cp      4
        jr      nz,S671
        call    GNC
        cp      ','
        jr      nz,S390         ;PSECT TEXT == CSEG
        call    ID              ; get possible ABS
        ld      a,(ERRFLG)
        cp      ' '
        ret     nz              ; on error, return
        call    IDTOUP
        ld      hl,IDBUF
        ld      a,(hl)
        inc     hl
        cp      'A'
        jr      nz,S671
        ld      a,(hl)
        inc     hl
        cp      'B'
        jp      nz,S671
        ld      a,(hl)
        cp      'S'
        jp      nz,S671
                                ;PSECT TEXT,ABS == ASEG
;       ASEG
;
S380:
;       ld      a,(PHFLAG)
;       or      a
;       jp      nz,PERROR       ; not allowed within .PHASE
        xor     a
        dec     a
        ld      (LOCFLG),a      ; set loc pending flag
        ld      a,(CURSEG)
        or      a
        ret     z               ; current segment is Absolute, ignore
;       call    UPDSIZ          ; update current segment size
        call    SAVEPC          ; save PC for current segment
        ld      hl,(ASEGPC)
        ld      (PC),hl         ; and load PC with latest Absolute PC
        ld      a,00h
        ld      (CURSEG),a      ; set current segment type to Absolute
        ret
;
;       CSEG
;
S390:
;       ld      a,(PHFLAG)
;       or      a
;       jp      nz,PERROR       ; not allowed within .PHASE
        ld      a,(LOCFLG)
        or      a
        ld      a,(CURSEG)
        jr      nz,S390A
        cp      40h
        ret     z               ; current segment is Code, ignore
S390A:
;       call    UPDSIZ          ; update current segment size
        call    SAVEPC          ; save PC for current segment
        ld      hl,(CSEGPC)
        ld      (PC),hl         ; and load PC with latest Code PC
        ld      e,40h           ; segment type = Code
        jr      S396            ; set segment type and loc counter
;
;       DSEG
;
S391:
;       ld      a,(PHFLAG)
;       or      a
;       jp      nz,PERROR       ; not allowed within .PHASE
        ld      a,(LOCFLG)
        or      a
        ld      a,(CURSEG)
        jr      nz,S391A
        cp      80h
        ret     z               ; current segment is Data, ignore
S391A:
;       call    UPDSIZ          ; update current segment size
        call    SAVEPC          ; save PC for current segment
        ld      hl,(DSEGPC)
        ld      (PC),hl         ; and load PC with latest Data PC
        ld      e,80h           ; segment type = Data
        jr      S396            ; set segment type and loc counter
;
;       COMMON
;
S392:   
;       ld      a,(PHFLAG)
;       or      a
;       jp      nz,PERROR       ; not allowed within .PHASE
;       call    GNC
;       cp      '/'
;       jp      nz,OERROR
;       call    ID              ; get COMMON name
;       cp      '/'
;       jp      nz,OERROR
;       call    GNC
;       ld      a,CMNSYM
;       ld      (SYMMOD),a      ; set address mode to COMMON
;       call    ADDSYM          ; enter symbol (COMMON segment definition)
;       ret     c               ; on error, return
;       jr      z,S394          ; jump if already defined
;
;       push    hl
;       call    UPDSIZ          ; update current segment size
;       call    SAVEPC          ; save PC for current segment
;       ld      hl,(IDADR)
;       ld      (CURCMN),hl     ; set current COMMON segment
;       ld      a,(hl)
;       or      COMNAME         ; set symbol type to COMMON name
;       ld      (hl),a
;       pop     hl
;
;       xor     a
;       ld      (hl),a          ; clear COMMON segment length
;       inc     hl
;       ld      (hl),a
;       inc     hl
;S395:  ld      (hl),CMNSYM     ; mode is COMMON
;       inc     hl
;       ld      (hl),a          ; always reset PC value to zero, even
;       inc     hl              ;  for existing COMMON (they overlay)
;       ld      (hl),a
;
;       ld      hl,0
;       ld      (PC),hl         ; init PC
;
;       push    hl
;       ld      hl,(CURCMN)
;       call    SELCMN          ; select COMMON block
;       pop     hl
;
;       ld      e,0C0h          ; segment type = COMMON

S396:   ld      a,e
        ld      (CURSEG),a      ; set current segment type
        ld      a,(PASSNO)
        or      a
        call    nz,WLOC         ; if Pass 2, write loc counter !!!!!!
        xor     a
        ld      (LOCFLG),a
        ret

;S394:  ld      de,(IDADR)
;       ld      a,(de)
;       and     0E0h
;       cp      COMNAME         ; ensure symbol type is COMNAME
;       jp      nz,VALERR
;       ld      (CURCMN),de     ; set current COMMON segment
;
;       push    hl
;       call    UPDSIZ          ; update current segment size
;       call    SAVEPC          ; save PC for current segment
;       pop     hl
;
;       xor     a
;       inc     hl              ; skip segment length
;       inc     hl
;       jr      S395            ; exit via common code
;
;       GLOBAL                  ;ENTRY, GLOBAL, PUBLIC
;
S500:   call    ID              ; get label name
        ld      a,(ERRFLG)
        cp      ' '
        ret     nz              ; on error, return
        ld      hl,0
        ld      (VAL),hl
        ld      a,GBLSYM .or. UNDEF
        ld      (SYMMOD),a
        call    ADDSYM          ; enter symbol as Undefined PUBLIC label
        ret     c               ; on error, return
        inc     hl              ; skip over value
        inc     hl
        ld      a,(hl)          ; get mode bits
        jr      nz,S501         ; branch if new symbol
                                ; ... symbol already defined
        or      GBLSYM          ; set GLOBAL bit
        ld      (hl),a
;       ld      c,a
;       and     EXTSYM          ; EXTRN bit set?
;       jr      nz,S501         ; set error flag if yes
        and     UNDEF           ; UNDEF bit set?
        jr      z,S502          ; branch if not
S501:                           ; symbol is new or has UNDEF flag set
        or      EXTSYM          ; ...so mark-it as external
        ld      (hl),a
;
        ld      a,1
        ld      (UFLAG),a       ; else set flag for LSTOUT
S502:   call    GNC
        cp      ','
        jr      z,S500          ; loop for more
        ret
;
;       EXT, EXTRN
;
S520:   ret
;       call    ID              ; get label name
;       ld      a,(ERRFLG)
;       cp      ' '
;       ret     nz              ; on error, return
;       call    ADDEXT          ; else add External symbol
;       call    GNC
;       cp      ','
;       jr      z,S520          ; loop to process more
;       ret
;
;       Add external symbol reference. Also called by CHKEXT from the
;       expression evaluation routine when a symbol of type LABEL## is
;       encountered.
;
ADDEXT: ld      hl,0
        ld      (VAL),hl
        ld      a,EXTSYM        ; set mode to External
        ld      (SYMMOD),a
        call    ADDSYM          ; enter symbol as External label
        ret     c               ; on error, return
        ret     nz              ; return if new symbol

        ld      a,(EVFLGS)      ; symbol exists, check flags
        and     0E0h
        cp      MULTDEF
        jp      z,MERROR        ; error if multiple defined

        cp      EQUNAME
        jp      z,SETMDF        ; type can't be EQU or DEFL
        cp      DFLNAME
        jp      z,SETMDF

        inc     hl              ; skip over value
        inc     hl
        ld      a,(hl)          ; get mode bits
        ld      c,a
        and     EXTSYM          ; External?
        ret     nz              ; return if yes
        ld      a,c
        and     GBLSYM .or. UNDEF
        cp      UNDEF           ; undefined?
        jp      nz,SETMDF       ; error if not
        or      EXTSYM          ; else set mode to External
        ld      (hl),a
        ret
;
;       .Z80, .Z180, .Z280
;
S530:   
;       ld      a,(OPCODE+1)
;       ld      (CPU),a         ; set CPU type
;       ret
;
;       .EVEN, .ODD
;
S540:   
;	ld      a,(OPCODE+1)
;        ld      hl,(PC)
;        xor     l
;        rra
;        ret     nc
;        xor     a
;        jp      EMITB
;
;       NAME
;
S550:
;       ld      hl,MODNAM
;S551:
;        ret
;       ld      bc,RECMAX
;       call    MCHECK
;       jp      c,WERROR
;       push    hl
;       ld      de,(SYMPTR)
;       inc     de
;       push    de
;       call    S561            ; get name
;       ld      a,' '
;       ld      (de),a
;       pop     de
;       pop     hl
;       ld      a,(PASSNO)
;       or      a
;       ret     nz              ; ignore if pass 2
;       ld      a,(hl)
;       or      a
;       jp      nz,MERROR       ; allowed only once
S552:   push    hl
        inc     hl              ; point to name buffer
        ld      c,0             ; init char count
S553:   ld      a,(de)
        call    UCASE
        cp      ' '
        jr      z,S554
        ld      (hl),a          ; store name
        inc     hl
        inc     de
        inc     c
        ld      a,(NAMLEN)
        cp      c
        jr      nz,S553
S554:   pop     hl
        ld      (hl),c          ; store length of name
        ret
;
;       IDENT
;
S560:   ret
;       ld      hl,MODIDN
;       jr      S551
;
;       INCLUDE, MACLIB
;
S570:   call    GNC             ; skip blanks
        ld      hl,(PTR1)
        dec     hl
        call    OPNLIB          ; open include file
        ld      (PTR1),hl
        ret
;
;       MACRO, REPT, IRP, IRPC
;
S580:   ld      hl,MTBL
        ld      a,(OPCODE+1)
        jp      SWITCH

MTBL:   defw    DEFMAC          ; MACRO
        defw    DFREPT          ; REPT
        defw    DFIRP           ; IRP
        defw    DFIRPC          ; IRPC
;
;       ENDM
;
S590:   jp      OERROR          ; ENDM without MACRO/REPT/IRP/IRPC
;
;       EXITM
;
S600:   ld      a,(MACLVL)
        or      a
        jp      nz,ENDMAC
        jp      OERROR          ; EXITM outside MACRO
;
;       LOCAL
;
S610:   jp      OERROR          ; LOCAL outside MACRO
;
;       RQST, .REQUEST
;
S620:  
;       ld      a,(PASSNO)
;       or      a
;       ret     z               ; ignore if pass 1
;S621:  call    ID              ; get operand
;       ld      a,(IDLEN)       ; valid?
;       ld      e,a
;       or      a
;       call    z,VALERR        ; error if yes
;       ld      hl,IDBUF
;       ld      a,e
;       or      a
;       call    nz,WRQST        ; output request library search
;       call    GNC
;       cp      ','             ; more names?
;       jr      z,S621          ; loop if yes
;       ret
;
;       .PHASE, .DEPHASE
;
S630:   
;       ld      a,(OPCODE+1)
;       or      a
;       jr      nz,S635         ; branch if .DEPHASE
;       ld      a,(PHFLAG)
;       or      a
;       jp      nz,PERROR       ; error if already in .PHASE
;       call    EVALNEW         ; get address
;       ld      a,(UFLAG)
;       or      a
;       ret     nz              ; 'U' error
;       ld      a,(EVMODE)
;       ld      c,a
;       and     EXTSYM
;       jp      nz,PERROR       ; can't be External ref
;       ld      a,(CURSEG)
;       or      01h
;       ld      (PHFLAG),a      ; use PHFLAG to remember old segment
;       ld      a,c
;       and     0C0h
;       ld      (CURSEG),a      ;!!!TODO: set CURCMN if addr is COMMON ref?
;       ld      de,(PC)
;       or      a
;       sbc     hl,de
;       ld      (PHDIFF),hl     ; compute offset from current PC
;       ret
;
;S635:  ld      a,(PHFLAG)
;       or      a
;       jp      z,PERROR        ; .DEPHASE without .PHASE
;       and     0C0h
;       ld      (CURSEG),a
;       xor     a
;       ld      (PHFLAG),a
;       ret
;
;       Get effective (.PHASE'd) PC value.
;
GETPPC:
       ld      hl,(PC)
	ret
;       ld      a,(PHFLAG)      ; .PHASE active?
;       or      a
;       ret     z               ; return PC if not
;       push    de
;       ld      de,(PHDIFF)
;       add     hl,de           ; else add offset
;       pop     de
;       ret
;
;       .RADIX
;
S640:   ld      hl,10           ; argument to .RADIX is always in decimal,
        ld      (RADIX),hl      ;  regardless of the previous radix
        call    EVALNEW         ; get value
        ld      a,(EVMODE)
        call    CHK8U
        jp      nz,VALERR
        ld      a,l
        cp      2               ; only 2, 8, 10 and 16 allowed
        jr      z,S641
        cp      8
        jr      z,S641
        cp      10
        jr      z,S641
        cp      16
        jp      nz,VALERR
S641:   ld      (RADIX),hl
        ret
;
;       .PRINTX
;
S650:   ld      bc,RECMAX
        call    MCHECK          ; ensure there is enough memory for string
        jp      c,WERROR
        ld      de,(SYMPTR)
        inc     de              ; don't touch end of symbol table marker
        push    de
        call    S561            ; get string
        xor     a
        ld      (de),a
        pop     hl
        jp      CLINE           ; display line on console
;
S561:   call    GNC
        or      a
        ret     z
        cp      '('
        jr      nz,S563
        call    GNC
        cp      27H             ;' quote?
        jr      z,S562
        cp      '"'
        jp      nz,ERRQ
S562:   call    S563
        call    GNC
        cp      ')'
        jp      nz,ERRQ
        ret
;
S563:   ld      c,a             ; C = quote char
        ld      hl,(PTR1)
S564:   ld      a,(hl)
        or      a
        jr      z,S565
        inc     hl
        cp      c
        jr      z,S566
        ld      (de),a
        inc     de
        jr      S564
S565:   call    ERRQ            ; string not properly closed
S566:   ld      (PTR1),hl
        ret
;
;       .COMMENT
;
S660:   
;	ret
;       call    GNC             ; get delimiter char
;       or      a
;       jp      z,OERROR        ; must be present
;       ld      (COMNTC),a      ; save it
;       ret
;
S662:   ld      c,a
        ld      hl,(PTR1)
S663:   ld      a,(hl)          ; get char
        or      a               ; end of line?
        jr      z,S664          ; exit loop if yes
        inc     hl
        sub     c               ; delimiter found?
        jr      nz,S663         ; loop if not
        ld      (COMNTC),a      ; else clear flag/delimiter
S664:   ld      (PTR1),hl
        ret
;
;       Require char following call.
;       Set error flag otherwise and return with CY flag set.
;
REQCHR: call    GNC
        call    UCASE
        ex      (sp),hl
        cp      (hl)
        inc     hl
        ex      (sp),hl
        ret     z
OERROR: ld      a,'O'
        ld      (ERRFLG),a
        scf
        ret
;
;       Require signed 8-bit value in HL, A = mode.
;
REQ8S:  call    CHK8S
        ret     z
        jp      c,RELERR
VALERR: ld      a,'V'
        ld      (ERRFLG),a
        ret
;
;       Check if value in HL is signed 8-bit, A = mode.
;
CHK8S:  or      a
        scf
        ret     nz
        ld      a,l             ; check low byte
        or      a
        ld      a,h
        jp      m,CHKM
        or      a               ; if positive, high byte must be zero
        ret                     ; NZ means error
CHKM:   inc     a               ; if negative, high byte must be 0FFh
        ret                     ; NZ means error
;
;       Require unsigned 8-bit value in HL, A = mode.
;
REQ8U:  call    CHK8U
        ret     z
        jp      c,RELERR
        jr      VALERR
;
;       Check if value in HL is unsigned 8-bit, A = mode.
;
CHK8U:  or      a
        scf                     ; return with CY set if reloc value
        ret     nz
        ld      a,h             ; check high byte
        or      a
        ret     z               ; can be either 00h or 0FFh
        inc     a
        ret                     ; NZ means error
;
;       Save variables VAL, EVMODE, EXTCHN and CMNPTR to
;       SAVVAL, SAVMOD, SAVCHN and SAVCMN.
;
SAVVARS:push    bc
        push    de
        ld      hl,VAL
        ld      de,SAVVAL
        ld      bc,7
        ldir
        pop     de
        pop     bc
        ret
;
;       Save current segment PC
;
SAVEPC: ld      hl,(PC)
        ld      a,(CURSEG)
        cp      40h             ; Code segment?
        jr      z,SAVPC1
        cp      80h             ; Data segment?
        jr      z,SAVPC2
        cp      0C0h            ; BSS segment? ;COMMON
        jr      nz,SAVPC3       ; jump if not (Absolute)
        ld      (BSEGPC),hl
        ret

;       ex      de,hl
;       ld      hl,(CURCMN)     ; get pointer to current COMMON segment
;       ld      a,(hl)          ; get name length
;       and     0Fh
;       ld      c,a
;       ld      b,0
;       add     hl,bc
;       inc     hl              ; point past name
;       inc     hl              ; skip segment length
;       inc     hl
;       inc     hl              ; skip address mode byte
;       ld      (hl),e          ; save COMMON segment PC
;       inc     hl
;       ld      (hl),d
;       ret

SAVPC3: ld      (ASEGPC),hl     ; save PC for current segment
        ret
SAVPC2: ld      (DSEGPC),hl
        ret
SAVPC1: ld      (CSEGPC),hl
        ret
;
;       Update current segment size
;
;UPDSIZ:        ld      hl,(PC)
;       ld      a,(CURSEG)
;       cp      40h             ; Code segment?
;       jr      z,UPD1
;       cp      80h             ; Data segment?
;       jr      z,UPD2
;       cp      0C0h            ; BSS segment?
;       ret     nz
;       ld      de,(BSSIZE)
;       call    CMPHD           ; CY if HL > DE
;       ret     nc
;       ld      (BSSIZE),hl
;       ret
;
;       push    hl
;       ld      hl,(CURCMN)     ; get pointer to current COMMON segment
;       ld      a,(hl)          ; get name length
;       and     0Fh
;       ld      e,a
;       ld      d,0
;       add     hl,de
;       inc     hl              ; point past name
;       ld      e,(hl)          ; get segment size field
;       inc     hl
;       ld      d,(hl)
;       ex      (sp),hl
;       call    CMPHD           ; CY if HL > DE
;       ex      de,hl
;       pop     hl
;       ret     nc
;       ld      (hl),d          ; update COMMON size
;       dec     hl
;       ld      (hl),e
;       ret
;UPD2:  ld      de,(DSSIZE)
;       call    CMPHD           ; CY if HL > DE
;       ret     nc
;       ld      (DSSIZE),hl
;       ret
;UPD1:  ld      de,(CSSIZE)
;       call    CMPHD           ; CY if HL > DE
;       ret     nc
;       ld      (CSSIZE),hl
;       ret
;
;       Select COMMON block
;
;SELCMN:        ld      a,h
;       or      l
;       ret     z
;       ld      de,(LASTCM)
;       call    CMPHD           ; same as last selected?
;       ret     z               ; return if yes
;       ld      (LASTCM),hl
;       ld      a,(PASSNO)
;       or      a
;       ret     z
;       ld      a,(hl)
;       and     0Fh             ; get name length
;       ld      e,a             ;  into reg E
;       inc     hl
;       jp      WSELCM          ; write selected COMMON to object file
;
;       Emit absolute byte in A to object file
;
EMITB:  push    hl
        ld      hl,PASSNO
        bit     0,(hl)
        jr      z,EMTB1         ; return if pass 1
        push    bc
        push    af
        call    LSTB            ; output to listing
        pop     af
        call    WOBJ            ; output to object file
        pop     bc
EMTB1:  pop     hl
        ld      a,(LEN)
        inc     a
        ld      (LEN),a
        ret
;
;       Emit absolute word in HL to object file
;
EMITW:  ld      a,l
        call    EMITB
        ld      a,h
        jp      EMITB
;
;       Emit word value in SAVVAL with segment type in SAVMOD to object file
;
EMITSV: ld      ix,SAVVAL       ; point to SAVVAL, SAVMOD, SAVCHN
        jr      EMTV0           ; continue below
;
;       Emit word value in VAL with segment type in EVMODE to object file
;
EMITV:  ld      ix,VAL          ; point to VAL, EVMODE, EXTCHN
EMTV0:  ld      a,(PASSNO)
        or      a
        jp      z,EMTV2         ; return if pass 1
EMTV1:  ld      a,(ix+2)        ; get mode
        bit     4,a             ; External?
        jr      z,EMTV3         ; branch if not
        push    bc
        ld      c,EXTSYM
        jr      EMTV6
EMTV3:  push    bc
        and     0C0h            ; mask segment bits
        ld      c,a
EMTV6:  ld      l,(ix+0)        ; get value into HL
        ld      h,(ix+1)
        push    hl
        call    WOBJ16          ; output relocatable value
        pop     hl
EMTV4:  ld      a,(ix+2)        ; get mode
        and     0E0H            ;0F0h           ; mask segment bits
        ld      c,a
        call    LSTW            ; output to listing
        pop     bc
EMTV2:  ld      a,(LEN)         ; update instr length
        inc     a
        inc     a
        ld      (LEN),a
        ret
;
;       Emit displacement SAVVAL-PC with segment type to object file.
;       Used by Z280 <addr> operands. On entry, DE contains an
;       additional offset to add to the displacement, as required
;       by some commands.
;
EMITSR:
       ld      ix,SAVVAL
       jr      EMTVR0
;
;       Emit displacement VAL-PC with segment type to object file.
;       Used by Z280 <addr> operands. On entry, DE contains an
;       additional offset to add to the displacement, as required
;       by some commands.
;
EMITVR:
       ld      ix,VAL
EMTVR0:
       ld      a,(PASSNO)
       or      a
       jr      z,EMTV2
       ld      l,(ix+0)        ; get value
       ld      h,(ix+1)
       dec     de              ; account for word length
       dec     de
       add     hl,de           ; add additional offset
       ld      de,(LEN)
       or      a
       sbc     hl,de
       ex      de,hl
       call    GETPPC          ; get effective PC value
       ex      de,hl           ;  into DE
       or      a
       sbc     hl,de           ; obtain relative displacement
       ld      (ix+0),l
       ld      (ix+1),h
       call    SUBVM           ; apply subtraction reloc rules
       jp      EMTV1
;
SUBVM:
       ld      a,(CURSEG)      ; check GETPPC
       and     11000000B       ; check current PC mode (2nd op)
       ret     z               ; return if Absolute
       ld      c,a
       ld      a,(ix+2)
       and     11000000B       ; else check VAL mode (1st op)
       cp      c
       jp      nz,RELERR       ; error if not same mode
       xor     a
       ld      (ix+2),a        ; else result just became Absolute
       ret

