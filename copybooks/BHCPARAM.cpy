      ******************************************************************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * COPYBOOK..: BHCPARAM
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 05/07/2026
      * OBJETIVO..: AREA DE PARAMETROS DO CALL BHCSH001
      * USADO EM..: BHCPH001 (WORKING-STORAGE, PREFIXO GDA-)
      *             BHCSH001 (LINKAGE SECTION, PREFIXO LK-)
      * OBS.......: MESMO GRUPO 01 NOS DOIS PROGRAMAS - EVITA
      *             DIVERGENCIA DE TAMANHO ENTRE CHAMADOR/CHAMADO
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL              DESCRICAO DA VERSAO
      * --- -------- ------------------------ -----------------------
      * 001 05.07.26 JOAO ANTONIO G. CARVALHO IMPLANTACAO
      * ----------------------------------------------------------------
      ******************************************************************

           05 GDA-TRA-ID                 PIC 9(006).
           05 GDA-TRA-CD-CLI             PIC 9(005).
           05 GDA-TRA-TP                 PIC X(001).
           05 GDA-TRA-VLR                PIC 9(009)V99.
           05 GDA-QT-CLI                 PIC 9(003).
           05 GDA-TB-CLI OCCURS 100 TIMES.
              10 GDA-CLI-CD              PIC 9(005).
              10 GDA-CLI-NM              PIC X(030).
              10 GDA-CLI-CPF             PIC 9(011).
              10 GDA-CLI-SDO             PIC 9(009)V99.
              10 GDA-CLI-ST              PIC X(001).
           05 GDA-TB-CLI-FLAT REDEFINES GDA-TB-CLI
                                         PIC X(5800).
           05 GDA-IDX-CLI                PIC 9(003).
           05 GDA-CD-RETORNO             PIC 9(002).
           05 GDA-MSG-ERRO               PIC X(060).
