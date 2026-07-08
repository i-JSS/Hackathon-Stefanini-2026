      ******************************************************************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * COPYBOOK..: BHCTRAXX
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 05/07/2026
      * OBJETIVO..: LAYOUT DO REGISTRO DE TRANSACAO (FD-REG-TRA)
      * USADO EM..: BHCPH000 (GRAVA) / BHCPH001 (LE)
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL              DESCRICAO DA VERSAO
      * --- -------- ------------------------ -----------------------
      * 001 05.07.26 JOAO ANTONIO G. CARVALHO IMPLANTACAO
      * ----------------------------------------------------------------
      ******************************************************************
      
           05 FD-TRA-ID                 PIC 9(006).
           05 FD-TRA-CD-CLI             PIC 9(005).
           05 FD-TRA-TP                 PIC X(001).
           05 FD-TRA-VLR                PIC 9(009)V99.
           05 FD-TRA-DT                 PIC 9(008).
