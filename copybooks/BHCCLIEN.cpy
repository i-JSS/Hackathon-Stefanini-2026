      ******************************************************************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * COPYBOOK..: BHCCLIEN
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 05/07/2026
      * OBJETIVO..: LAYOUT DO REGISTRO DE CLIENTE (FD-REG-CLI)
      * USADO EM..: BHCPH000 (GRAVA) / BHCPH001 (LE + TABELA)
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL              DESCRICAO DA VERSAO
      * --- -------- ------------------------ -----------------------
      * 001 05.07.26 JOAO ANTONIO G. CARVALHO IMPLANTACAO
      * ----------------------------------------------------------------
      ******************************************************************
      
           05 FD-CLI-CD                 PIC 9(005).
           05 FD-CLI-NM                 PIC X(030).
           05 FD-CLI-CPF                PIC 9(011).
           05 FD-CLI-SDO                PIC 9(009)V99.
           05 FD-CLI-ST                 PIC X(001).