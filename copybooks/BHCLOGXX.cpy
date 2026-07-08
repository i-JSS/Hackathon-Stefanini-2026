      ******************************************************************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * COPYBOOK..: BHCLOGXX
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 05/07/2026
      * OBJETIVO..: LAYOUT DO REGISTRO DE LOG (FD-REG-LOG)
      * USADO EM..: BHCPH001
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL              DESCRICAO DA VERSAO
      * --- -------- ------------------------ -----------------------
      * 001 05.07.26 JOAO ANTONIO G. CARVALHO IMPLANTACAO
      * ----------------------------------------------------------------
      ******************************************************************

           05 FD-LOG-ID-TRA              PIC 9(006).
           05 FILLER                     PIC X(001) VALUE ';'.
           05 FD-LOG-CD-CLI              PIC 9(005).
           05 FILLER                     PIC X(001) VALUE ';'.
           05 FD-LOG-TP-TRA              PIC X(001).
           05 FILLER                     PIC X(001) VALUE ';'.
           05 FD-LOG-VLR-TRA             PIC 9(009)V99.
           05 FILLER                     PIC X(001) VALUE ';'.
           05 FD-LOG-CD-ERR              PIC X(002).
           05 FILLER                     PIC X(001) VALUE ';'.
           05 FD-LOG-MSG-ERR             PIC X(060).
           05 FILLER                     PIC X(001) VALUE SPACE.
