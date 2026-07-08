      ******************************************************************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * COPYBOOK..: BHCEXTXX
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 05/07/2026
      * OBJETIVO..: LAYOUT DO REGISTRO DE EXTRATO (FD-REG-EXT)
      * USADO EM..: BHCPH001
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL              DESCRICAO DA VERSAO
      * --- -------- ------------------------ -----------------------
      * 001 05.07.26 JOAO ANTONIO G. CARVALHO IMPLANTACAO
      * ----------------------------------------------------------------
      ******************************************************************

           05 FD-EXT-ID-TRA              PIC 9(006).
           05 FILLER                     PIC X(001) VALUE ';'.
           05 FD-EXT-CD-CLI              PIC 9(005).
           05 FILLER                     PIC X(001) VALUE ';'.
           05 FD-EXT-TP-TRA              PIC X(001).
           05 FILLER                     PIC X(001) VALUE ';'.
           05 FD-EXT-VLR-TRA             PIC 9(009)V99.
           05 FILLER                     PIC X(001) VALUE ';'.
           05 FD-EXT-SDO-ANT             PIC 9(009)V99.
           05 FILLER                     PIC X(001) VALUE ';'.
           05 FD-EXT-SDO-ATU             PIC 9(009)V99.
           05 FILLER                     PIC X(001) VALUE ';'.
           05 FD-EXT-DT-TRA              PIC 9(008).
