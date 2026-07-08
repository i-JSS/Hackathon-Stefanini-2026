      ******************************************************************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCPH000
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 05/07/2026
      * OBJETIVO..: GERADOR DE MASSA - FINANCE CORE
      * EXECUCAO..: COBOL - BATCH
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL              DESCRICAO DA VERSAO
      * --- -------- ------------------------ -----------------------
      * 001 05.07.26 JOAO ANTONIO G. CARVALHO IMPLANTACAO
      * ----------------------------------------------------------------
      ******************************************************************

      ******************************************************************
       IDENTIFICATION DIVISION.
      ******************************************************************

       PROGRAM-ID. BHCPH000.

      ******************************************************************
       ENVIRONMENT DIVISION.
      ******************************************************************

      *----------------------------------------
       CONFIGURATION                   SECTION.
      *----------------------------------------

       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

      *----------------------------------------
       INPUT-OUTPUT                    SECTION.
      *----------------------------------------

       FILE-CONTROL.
           SELECT FD-ARQ-CLI ASSIGN TO 'BHCFHCLI.txt'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FS-CLI.

           SELECT FD-ARQ-TRA ASSIGN TO 'BHCFHTRA.txt'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FS-TRA.

      ******************************************************************
       DATA DIVISION.
      ******************************************************************

      *----------------------------------------
       FILE                            SECTION.
      *----------------------------------------
      
       FD  FD-ARQ-CLI.
       01  BHCFHCLI-REG                 PIC X(058).
       
       FD  FD-ARQ-TRA.
       01  BHCFHTRA-REG                 PIC X(031).

      *----------------------------------------
       WORKING-STORAGE                 SECTION.
      *----------------------------------------

       77  FS-CLI                       PIC X(002) VALUE SPACES.
       77  FS-TRA                       PIC X(002) VALUE SPACES.

       01  WS-DATA-HORA-FULL.
           05 WS-DT-ANO                 PIC 9(004).
           05 WS-DT-MES                 PIC 9(002).
           05 WS-DT-DIA                 PIC 9(002).
           05 WS-HR-HORA                PIC 9(002).
           05 WS-HR-MIN                 PIC 9(002).
           05 WS-HR-SEG                 PIC 9(002).
           05 FILLER                    PIC X(009).

       01  WS-TOTALIZADORES.
           05 WS-TOT-CLI-GRV            PIC 9(005) VALUE ZEROS.
           05 WS-TOT-CLI-ERR            PIC 9(005) VALUE ZEROS.
           05 WS-TOT-TRA-GRV            PIC 9(005) VALUE ZEROS.
           05 WS-TOT-TRA-ERR            PIC 9(005) VALUE ZEROS.

       01  WS-IDX-CLI                   PIC 9(002) VALUE ZEROS.
       01  WS-IDX-TRA                   PIC 9(002) VALUE ZEROS.
       01  WS-MSG-ERR                   PIC X(080) VALUE SPACES.

      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------

       01  FD-REG-CLI.
           COPY BHCCLIEN.

       01  FD-REG-TRA.
           COPY BHCTRAXX.

       01  GDA-TB-CLI.
           05 GDA-CLI OCCURS 20 TIMES.
              10 GDA-CLI-CD              PIC 9(005).
              10 GDA-CLI-NM              PIC X(030).
              10 GDA-CLI-CPF             PIC 9(011).
              10 GDA-CLI-SDO             PIC 9(009)V99.
              10 GDA-CLI-ST              PIC X(001).

       01  GDA-TB-TRA.
           05 GDA-TRA OCCURS 40 TIMES.
              10 GDA-TRA-ID              PIC 9(006).
              10 GDA-TRA-CD-CLI          PIC 9(005).
              10 GDA-TRA-TP              PIC X(001).
              10 GDA-TRA-VLR             PIC 9(009)V99.
              10 GDA-TRA-DT              PIC 9(008).

      ******************************************************************
       PROCEDURE DIVISION.
      ******************************************************************

           PERFORM 100000-INICIALIZAR
           PERFORM 200000-CARREGAR-MASSA-CLI
           PERFORM 300000-GRAVAR-CLIENTES
           PERFORM 400000-CARREGAR-MASSA-TRA
           PERFORM 500000-GRAVAR-TRANSACOES
           PERFORM 600000-FINALIZAR
           .

           GOBACK.

      *----------------------------------------
       100000-INICIALIZAR              SECTION.
      *----------------------------------------

           MOVE FUNCTION CURRENT-DATE    TO WS-DATA-HORA-FULL

           OPEN OUTPUT FD-ARQ-CLI
           IF FS-CLI NOT = '00'
               MOVE 'ERRO AO ABRIR BHCFHCLI' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           OPEN OUTPUT FD-ARQ-TRA
           IF FS-TRA NOT = '00'
               MOVE 'ERRO AO ABRIR BHCFHTRA' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           DISPLAY '*************************************************'
           DISPLAY '* SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL'
           DISPLAY '* PROGRAMA..: BHCPH000'
           DISPLAY '* ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR'
           DISPLAY '* AUTOR.....: JOAO ANTONIO GINUINO CARVALHO'
           DISPLAY '* DATA/HORA.: ' WS-DT-DIA '/' WS-DT-MES '/'
               WS-DT-ANO ' - ' WS-HR-HORA ':' WS-HR-MIN ':' WS-HR-SEG
           DISPLAY '* OBJETIVO..: GERADOR DE MASSA - FINANCE CORE'
           DISPLAY '* EXECUCAO..: COBOL - BATCH'
           DISPLAY '*************************************************'
           .
       100000-FIM.
           EXIT.

      *----------------------------------------
       200000-CARREGAR-MASSA-CLI       SECTION.
      *----------------------------------------

           MOVE 00001 TO GDA-CLI-CD(01)
           MOVE 'JOAO SILVA' TO GDA-CLI-NM(01)
           MOVE 12345678901 TO GDA-CLI-CPF(01)
           COMPUTE GDA-CLI-SDO(01) = 150000 / 100
           MOVE 'A' TO GDA-CLI-ST(01)

           MOVE 00002 TO GDA-CLI-CD(02)
           MOVE 'MARIA SOUZA' TO GDA-CLI-NM(02)
           MOVE 23456789012 TO GDA-CLI-CPF(02)
           COMPUTE GDA-CLI-SDO(02) = 87550 / 100
           MOVE 'A' TO GDA-CLI-ST(02)

           MOVE 00003 TO GDA-CLI-CD(03)
           MOVE 'CARLOS LIMA' TO GDA-CLI-NM(03)
           MOVE 34567890123 TO GDA-CLI-CPF(03)
           COMPUTE GDA-CLI-SDO(03) = 5000 / 100
           MOVE 'A' TO GDA-CLI-ST(03)

           MOVE 00004 TO GDA-CLI-CD(04)
           MOVE 'ANA PEREIRA' TO GDA-CLI-NM(04)
           MOVE 45678901234 TO GDA-CLI-CPF(04)
           COMPUTE GDA-CLI-SDO(04) = 250000 / 100
           MOVE 'A' TO GDA-CLI-ST(04)

           MOVE 00005 TO GDA-CLI-CD(05)
           MOVE 'PAULO SANTOS' TO GDA-CLI-NM(05)
           MOVE 56789012345 TO GDA-CLI-CPF(05)
           COMPUTE GDA-CLI-SDO(05) = 0 / 100
           MOVE 'A' TO GDA-CLI-ST(05)

           MOVE 00006 TO GDA-CLI-CD(06)
           MOVE 'FERNANDA COSTA' TO GDA-CLI-NM(06)
           MOVE 67890123456 TO GDA-CLI-CPF(06)
           COMPUTE GDA-CLI-SDO(06) = 32000 / 100
           MOVE 'A' TO GDA-CLI-ST(06)

           MOVE 00007 TO GDA-CLI-CD(07)
           MOVE 'RICARDO ALMEIDA' TO GDA-CLI-NM(07)
           MOVE 78901234567 TO GDA-CLI-CPF(07)
           COMPUTE GDA-CLI-SDO(07) = 120000 / 100
           MOVE 'A' TO GDA-CLI-ST(07)

           MOVE 00008 TO GDA-CLI-CD(08)
           MOVE 'JULIANA ROCHA' TO GDA-CLI-NM(08)
           MOVE 89012345678 TO GDA-CLI-CPF(08)
           COMPUTE GDA-CLI-SDO(08) = 65000 / 100
           MOVE 'A' TO GDA-CLI-ST(08)

           MOVE 00009 TO GDA-CLI-CD(09)
           MOVE 'MARCOS OLIVEIRA' TO GDA-CLI-NM(09)
           MOVE 90123456789 TO GDA-CLI-CPF(09)
           COMPUTE GDA-CLI-SDO(09) = 7500 / 100
           MOVE 'A' TO GDA-CLI-ST(09)

           MOVE 00010 TO GDA-CLI-CD(10)
           MOVE 'PATRICIA GOMES' TO GDA-CLI-NM(10)
           MOVE 01234567890 TO GDA-CLI-CPF(10)
           COMPUTE GDA-CLI-SDO(10) = 180000 / 100
           MOVE 'A' TO GDA-CLI-ST(10)

           MOVE 00011 TO GDA-CLI-CD(11)
           MOVE 'LUCAS MARTINS' TO GDA-CLI-NM(11)
           MOVE 11223344556 TO GDA-CLI-CPF(11)
           COMPUTE GDA-CLI-SDO(11) = 40000 / 100
           MOVE 'A' TO GDA-CLI-ST(11)

           MOVE 00012 TO GDA-CLI-CD(12)
           MOVE 'CAMILA RIBEIRO' TO GDA-CLI-NM(12)
           MOVE 22334455667 TO GDA-CLI-CPF(12)
           COMPUTE GDA-CLI-SDO(12) = 99000 / 100
           MOVE 'A' TO GDA-CLI-ST(12)

           MOVE 00013 TO GDA-CLI-CD(13)
           MOVE 'ROBERTO BARBOSA' TO GDA-CLI-NM(13)
           MOVE 33445566778 TO GDA-CLI-CPF(13)
           COMPUTE GDA-CLI-SDO(13) = 3000 / 100
           MOVE 'A' TO GDA-CLI-ST(13)

           MOVE 00014 TO GDA-CLI-CD(14)
           MOVE 'BEATRIZ MENDES' TO GDA-CLI-NM(14)
           MOVE 44556677889 TO GDA-CLI-CPF(14)
           COMPUTE GDA-CLI-SDO(14) = 145000 / 100
           MOVE 'A' TO GDA-CLI-ST(14)

           MOVE 00015 TO GDA-CLI-CD(15)
           MOVE 'GUSTAVO NUNES' TO GDA-CLI-NM(15)
           MOVE 55667788990 TO GDA-CLI-CPF(15)
           COMPUTE GDA-CLI-SDO(15) = 25000 / 100
           MOVE 'A' TO GDA-CLI-ST(15)

           MOVE 00016 TO GDA-CLI-CD(16)
           MOVE 'HELENA DIAS' TO GDA-CLI-NM(16)
           MOVE 66778899001 TO GDA-CLI-CPF(16)
           COMPUTE GDA-CLI-SDO(16) = 70000 / 100
           MOVE 'I' TO GDA-CLI-ST(16)

           MOVE 00017 TO GDA-CLI-CD(17)
           MOVE 'RAFAEL FREITAS' TO GDA-CLI-NM(17)
           MOVE 77889900112 TO GDA-CLI-CPF(17)
           COMPUTE GDA-CLI-SDO(17) = 110000 / 100
           MOVE 'I' TO GDA-CLI-ST(17)

           MOVE 00018 TO GDA-CLI-CD(18)
           MOVE 'LARISSA CAMPOS' TO GDA-CLI-NM(18)
           MOVE 88990011223 TO GDA-CLI-CPF(18)
           COMPUTE GDA-CLI-SDO(18) = 55000 / 100
           MOVE 'I' TO GDA-CLI-ST(18)

           MOVE 00019 TO GDA-CLI-CD(19)
           MOVE 'EDUARDO MOREIRA' TO GDA-CLI-NM(19)
           MOVE 99001122334 TO GDA-CLI-CPF(19)
           COMPUTE GDA-CLI-SDO(19) = 200000 / 100
           MOVE 'B' TO GDA-CLI-ST(19)

           MOVE 00020 TO GDA-CLI-CD(20)
           MOVE 'TATIANE AZEVEDO' TO GDA-CLI-NM(20)
           MOVE 00112233445 TO GDA-CLI-CPF(20)
           COMPUTE GDA-CLI-SDO(20) = 33000 / 100
           MOVE 'B' TO GDA-CLI-ST(20)
           .
       200000-FIM.
           EXIT.

      *----------------------------------------
       300000-GRAVAR-CLIENTES          SECTION.
      *----------------------------------------

           PERFORM VARYING WS-IDX-CLI FROM 1 BY 1
               UNTIL WS-IDX-CLI > 20

           MOVE GDA-CLI-CD(WS-IDX-CLI)  TO FD-CLI-CD
           MOVE GDA-CLI-NM(WS-IDX-CLI)  TO FD-CLI-NM
           MOVE GDA-CLI-CPF(WS-IDX-CLI) TO FD-CLI-CPF
           MOVE GDA-CLI-SDO(WS-IDX-CLI) TO FD-CLI-SDO
           MOVE GDA-CLI-ST(WS-IDX-CLI)  TO FD-CLI-ST

           WRITE BHCFHCLI-REG                  FROM FD-REG-CLI

           IF FS-CLI = '00'
               ADD 1                            TO WS-TOT-CLI-GRV
           ELSE
               DISPLAY 'ERRO WRITE BHCFHCLI. FILE STATUS: '
                   FS-CLI
               ADD 1                            TO WS-TOT-CLI-ERR
           END-IF
           END-PERFORM
           .
       300000-FIM.
           EXIT.

      *----------------------------------------
       400000-CARREGAR-MASSA-TRA       SECTION.
      *----------------------------------------

           MOVE 000001 TO GDA-TRA-ID(01)
           MOVE 00001  TO GDA-TRA-CD-CLI(01)
           MOVE 'D'    TO GDA-TRA-TP(01)
           COMPUTE GDA-TRA-VLR(01) = 50000 / 100
           MOVE 20260704 TO GDA-TRA-DT(01)

           MOVE 000002 TO GDA-TRA-ID(02)
           MOVE 00002  TO GDA-TRA-CD-CLI(02)
           MOVE 'S'    TO GDA-TRA-TP(02)
           COMPUTE GDA-TRA-VLR(02) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(02)

           MOVE 000003 TO GDA-TRA-ID(03)
           MOVE 00003  TO GDA-TRA-CD-CLI(03)
           MOVE 'P'    TO GDA-TRA-TP(03)
           COMPUTE GDA-TRA-VLR(03) = 2000 / 100
           MOVE 20260704 TO GDA-TRA-DT(03)

           MOVE 000004 TO GDA-TRA-ID(04)
           MOVE 00004  TO GDA-TRA-CD-CLI(04)
           MOVE 'S'    TO GDA-TRA-TP(04)
           COMPUTE GDA-TRA-VLR(04) = 30000 / 100
           MOVE 20260704 TO GDA-TRA-DT(04)

           MOVE 000005 TO GDA-TRA-ID(05)
           MOVE 00005  TO GDA-TRA-CD-CLI(05)
           MOVE 'D'    TO GDA-TRA-TP(05)
           COMPUTE GDA-TRA-VLR(05) = 25000 / 100
           MOVE 20260704 TO GDA-TRA-DT(05)

           MOVE 000006 TO GDA-TRA-ID(06)
           MOVE 00006  TO GDA-TRA-CD-CLI(06)
           MOVE 'P'    TO GDA-TRA-TP(06)
           COMPUTE GDA-TRA-VLR(06) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(06)

           MOVE 000007 TO GDA-TRA-ID(07)
           MOVE 00007  TO GDA-TRA-CD-CLI(07)
           MOVE 'S'    TO GDA-TRA-TP(07)
           COMPUTE GDA-TRA-VLR(07) = 50000 / 100
           MOVE 20260704 TO GDA-TRA-DT(07)

           MOVE 000008 TO GDA-TRA-ID(08)
           MOVE 00008  TO GDA-TRA-CD-CLI(08)
           MOVE 'D'    TO GDA-TRA-TP(08)
           COMPUTE GDA-TRA-VLR(08) = 75000 / 100
           MOVE 20260704 TO GDA-TRA-DT(08)

           MOVE 000009 TO GDA-TRA-ID(09)
           MOVE 00009  TO GDA-TRA-CD-CLI(09)
           MOVE 'P'    TO GDA-TRA-TP(09)
           COMPUTE GDA-TRA-VLR(09) = 2500 / 100
           MOVE 20260704 TO GDA-TRA-DT(09)

           MOVE 000010 TO GDA-TRA-ID(10)
           MOVE 00010  TO GDA-TRA-CD-CLI(10)
           MOVE 'S'    TO GDA-TRA-TP(10)
           COMPUTE GDA-TRA-VLR(10) = 20000 / 100
           MOVE 20260704 TO GDA-TRA-DT(10)

           MOVE 000011 TO GDA-TRA-ID(11)
           MOVE 00011  TO GDA-TRA-CD-CLI(11)
           MOVE 'D'    TO GDA-TRA-TP(11)
           COMPUTE GDA-TRA-VLR(11) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(11)

           MOVE 000012 TO GDA-TRA-ID(12)
           MOVE 00012  TO GDA-TRA-CD-CLI(12)
           MOVE 'P'    TO GDA-TRA-TP(12)
           COMPUTE GDA-TRA-VLR(12) = 5000 / 100
           MOVE 20260704 TO GDA-TRA-DT(12)

           MOVE 000013 TO GDA-TRA-ID(13)
           MOVE 00013  TO GDA-TRA-CD-CLI(13)
           MOVE 'S'    TO GDA-TRA-TP(13)
           COMPUTE GDA-TRA-VLR(13) = 2000 / 100
           MOVE 20260704 TO GDA-TRA-DT(13)

           MOVE 000014 TO GDA-TRA-ID(14)
           MOVE 00014  TO GDA-TRA-CD-CLI(14)
           MOVE 'D'    TO GDA-TRA-TP(14)
           COMPUTE GDA-TRA-VLR(14) = 30000 / 100
           MOVE 20260704 TO GDA-TRA-DT(14)

           MOVE 000015 TO GDA-TRA-ID(15)
           MOVE 00015  TO GDA-TRA-CD-CLI(15)
           MOVE 'P'    TO GDA-TRA-TP(15)
           COMPUTE GDA-TRA-VLR(15) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(15)

           MOVE 000016 TO GDA-TRA-ID(16)
           MOVE 00001  TO GDA-TRA-CD-CLI(16)
           MOVE 'S'    TO GDA-TRA-TP(16)
           COMPUTE GDA-TRA-VLR(16) = 25000 / 100
           MOVE 20260704 TO GDA-TRA-DT(16)

           MOVE 000017 TO GDA-TRA-ID(17)
           MOVE 00002  TO GDA-TRA-CD-CLI(17)
           MOVE 'D'    TO GDA-TRA-TP(17)
           COMPUTE GDA-TRA-VLR(17) = 40000 / 100
           MOVE 20260704 TO GDA-TRA-DT(17)

           MOVE 000018 TO GDA-TRA-ID(18)
           MOVE 00003  TO GDA-TRA-CD-CLI(18)
           MOVE 'S'    TO GDA-TRA-TP(18)
           COMPUTE GDA-TRA-VLR(18) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(18)

           MOVE 000019 TO GDA-TRA-ID(19)
           MOVE 00004  TO GDA-TRA-CD-CLI(19)
           MOVE 'P'    TO GDA-TRA-TP(19)
           COMPUTE GDA-TRA-VLR(19) = 50000 / 100
           MOVE 20260704 TO GDA-TRA-DT(19)

           MOVE 000020 TO GDA-TRA-ID(20)
           MOVE 00005  TO GDA-TRA-CD-CLI(20)
           MOVE 'S'    TO GDA-TRA-TP(20)
           COMPUTE GDA-TRA-VLR(20) = 1000 / 100
           MOVE 20260704 TO GDA-TRA-DT(20)

           MOVE 000021 TO GDA-TRA-ID(21)
           MOVE 99999  TO GDA-TRA-CD-CLI(21)
           MOVE 'D'    TO GDA-TRA-TP(21)
           COMPUTE GDA-TRA-VLR(21) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(21)

           MOVE 000022 TO GDA-TRA-ID(22)
           MOVE 88888  TO GDA-TRA-CD-CLI(22)
           MOVE 'S'    TO GDA-TRA-TP(22)
           COMPUTE GDA-TRA-VLR(22) = 5000 / 100
           MOVE 20260704 TO GDA-TRA-DT(22)

           MOVE 000023 TO GDA-TRA-ID(23)
           MOVE 77777  TO GDA-TRA-CD-CLI(23)
           MOVE 'P'    TO GDA-TRA-TP(23)
           COMPUTE GDA-TRA-VLR(23) = 7500 / 100
           MOVE 20260704 TO GDA-TRA-DT(23)

           MOVE 000024 TO GDA-TRA-ID(24)
           MOVE 66666  TO GDA-TRA-CD-CLI(24)
           MOVE 'D'    TO GDA-TRA-TP(24)
           COMPUTE GDA-TRA-VLR(24) = 20000 / 100
           MOVE 20260704 TO GDA-TRA-DT(24)

           MOVE 000025 TO GDA-TRA-ID(25)
           MOVE 55555  TO GDA-TRA-CD-CLI(25)
           MOVE 'S'    TO GDA-TRA-TP(25)
           COMPUTE GDA-TRA-VLR(25) = 1000 / 100
           MOVE 20260704 TO GDA-TRA-DT(25)

           MOVE 000026 TO GDA-TRA-ID(26)
           MOVE 00016  TO GDA-TRA-CD-CLI(26)
           MOVE 'D'    TO GDA-TRA-TP(26)
           COMPUTE GDA-TRA-VLR(26) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(26)

           MOVE 000027 TO GDA-TRA-ID(27)
           MOVE 00017  TO GDA-TRA-CD-CLI(27)
           MOVE 'S'    TO GDA-TRA-TP(27)
           COMPUTE GDA-TRA-VLR(27) = 5000 / 100
           MOVE 20260704 TO GDA-TRA-DT(27)

           MOVE 000028 TO GDA-TRA-ID(28)
           MOVE 00018  TO GDA-TRA-CD-CLI(28)
           MOVE 'P'    TO GDA-TRA-TP(28)
           COMPUTE GDA-TRA-VLR(28) = 2500 / 100
           MOVE 20260704 TO GDA-TRA-DT(28)

           MOVE 000029 TO GDA-TRA-ID(29)
           MOVE 00019  TO GDA-TRA-CD-CLI(29)
           MOVE 'D'    TO GDA-TRA-TP(29)
           COMPUTE GDA-TRA-VLR(29) = 50000 / 100
           MOVE 20260704 TO GDA-TRA-DT(29)

           MOVE 000030 TO GDA-TRA-ID(30)
           MOVE 00020  TO GDA-TRA-CD-CLI(30)
           MOVE 'S'    TO GDA-TRA-TP(30)
           COMPUTE GDA-TRA-VLR(30) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(30)

           MOVE 000031 TO GDA-TRA-ID(31)
           MOVE 00001  TO GDA-TRA-CD-CLI(31)
           MOVE 'X'    TO GDA-TRA-TP(31)
           COMPUTE GDA-TRA-VLR(31) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(31)

           MOVE 000032 TO GDA-TRA-ID(32)
           MOVE 00002  TO GDA-TRA-CD-CLI(32)
           MOVE 'Z'    TO GDA-TRA-TP(32)
           COMPUTE GDA-TRA-VLR(32) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(32)

           MOVE 000033 TO GDA-TRA-ID(33)
           MOVE 00003  TO GDA-TRA-CD-CLI(33)
           MOVE 'T'    TO GDA-TRA-TP(33)
           COMPUTE GDA-TRA-VLR(33) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(33)

           MOVE 000034 TO GDA-TRA-ID(34)
           MOVE 00004  TO GDA-TRA-CD-CLI(34)
           MOVE 'S'    TO GDA-TRA-TP(34)
           COMPUTE GDA-TRA-VLR(34) = 300000 / 100
           MOVE 20260704 TO GDA-TRA-DT(34)

           MOVE 000035 TO GDA-TRA-ID(35)
           MOVE 00006  TO GDA-TRA-CD-CLI(35)
           MOVE 'P'    TO GDA-TRA-TP(35)
           COMPUTE GDA-TRA-VLR(35) = 100000 / 100
           MOVE 20260704 TO GDA-TRA-DT(35)

           MOVE 000036 TO GDA-TRA-ID(36)
           MOVE 00009  TO GDA-TRA-CD-CLI(36)
           MOVE 'S'    TO GDA-TRA-TP(36)
           COMPUTE GDA-TRA-VLR(36) = 10000 / 100
           MOVE 20260704 TO GDA-TRA-DT(36)

           MOVE 000037 TO GDA-TRA-ID(37)
           MOVE 00013  TO GDA-TRA-CD-CLI(37)
           MOVE 'P'    TO GDA-TRA-TP(37)
           COMPUTE GDA-TRA-VLR(37) = 50000 / 100
           MOVE 20260704 TO GDA-TRA-DT(37)

           MOVE 000038 TO GDA-TRA-ID(38)
           MOVE 00005  TO GDA-TRA-CD-CLI(38)
           MOVE 'D'    TO GDA-TRA-TP(38)
           COMPUTE GDA-TRA-VLR(38) = 0 / 100
           MOVE 20260704 TO GDA-TRA-DT(38)

           MOVE 000039 TO GDA-TRA-ID(39)
           MOVE 00007  TO GDA-TRA-CD-CLI(39)
           MOVE 'S'    TO GDA-TRA-TP(39)
           COMPUTE GDA-TRA-VLR(39) = 0 / 100
           MOVE 20260704 TO GDA-TRA-DT(39)

           MOVE 000040 TO GDA-TRA-ID(40)
           MOVE 00008  TO GDA-TRA-CD-CLI(40)
           MOVE 'P'    TO GDA-TRA-TP(40)
           COMPUTE GDA-TRA-VLR(40) = 0 / 100
           MOVE 20260704 TO GDA-TRA-DT(40)
           .
       400000-FIM.
           EXIT.

      *----------------------------------------
       500000-GRAVAR-TRANSACOES        SECTION.
      *----------------------------------------

           PERFORM VARYING WS-IDX-TRA FROM 1 BY 1
               UNTIL WS-IDX-TRA > 40

           MOVE GDA-TRA-ID(WS-IDX-TRA)      TO FD-TRA-ID
           MOVE GDA-TRA-CD-CLI(WS-IDX-TRA)  TO FD-TRA-CD-CLI
           MOVE GDA-TRA-TP(WS-IDX-TRA)      TO FD-TRA-TP
           MOVE GDA-TRA-VLR(WS-IDX-TRA)     TO FD-TRA-VLR
           MOVE GDA-TRA-DT(WS-IDX-TRA)      TO FD-TRA-DT

           WRITE BHCFHTRA-REG                   FROM FD-REG-TRA

           IF FS-TRA = '00'
               ADD 1                            TO WS-TOT-TRA-GRV
           ELSE
               DISPLAY 'ERRO WRITE BHCFHTRA. FILE STATUS: '
                   FS-TRA
               ADD 1                            TO WS-TOT-TRA-ERR
           END-IF
           END-PERFORM
           .
       500000-FIM.
           EXIT.

      *----------------------------------------
       600000-FINALIZAR                SECTION.
      *----------------------------------------

           CLOSE FD-ARQ-CLI
                 FD-ARQ-TRA

           DISPLAY '----------------------------------------'
           DISPLAY 'TOTAL CLIENTES GRAVADOS    : ' WS-TOT-CLI-GRV
           DISPLAY 'TOTAL CLIENTES COM ERRO    : ' WS-TOT-CLI-ERR
           DISPLAY 'TOTAL TRANSACOES GRAVADAS  : ' WS-TOT-TRA-GRV
           DISPLAY 'TOTAL TRANSACOES COM ERRO  : ' WS-TOT-TRA-ERR
           DISPLAY '----------------------------------------'
           .
       600000-FIM.
           EXIT.

      *----------------------------------------
       800000-TRATAR-ERRO              SECTION.
      *----------------------------------------

           DISPLAY '**** ERRO TECNICO ****'
           DISPLAY 'PROGRAMA...: BHCPH000'
           DISPLAY 'MENSAGEM...: ' WS-MSG-ERR
           DISPLAY 'FS-CLI.....: ' FS-CLI
           DISPLAY 'FS-TRA.....: ' FS-TRA
           GOBACK
           .
       800000-FIM.
           EXIT.

      ******************************************************************