      **********************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCP0006
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 29/06/2026
      * OBJETIVO..: CLASSIFICAR O SALDO DE UM CLIENTE
      * EXECUCAO..: COBOL - BATCH
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL     DESCRICAO DA VERSAO
      * --- -------- --------------- ----------------------------------
      * 001 29.06.26 JOAO CARVALHO   IMPLANTACAO
      * ----------------------------------------------------------------
      **********************

      **********************
       IDENTIFICATION DIVISION.
      **********************

       PROGRAM-ID. BHCP0006.

      **********************
       ENVIRONMENT DIVISION.
      **********************

      *----------------------------------------
       CONFIGURATION                   SECTION.
      *----------------------------------------
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

      **********************
       DATA DIVISION.
      **********************

      *----------------------------------------
       WORKING-STORAGE                 SECTION.
      *----------------------------------------

       01 GDA-NM-CLIENTE               PIC X(20) VALUE 'ANA PAULA'.
       01 GDA-VL-SALDO                 PIC S9(3) VALUE 500.
       01 GDA-VL-SALDO-FMT             PIC -ZZ9.
       01 GDA-TX-SITUACAO              PIC X(10) VALUE SPACES.

      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------

      **********************
       PROCEDURE DIVISION.
      **********************

       2000-CLASSIFICAR.
           IF GDA-VL-SALDO GREATER THAN ZERO
               MOVE 'POSITIVO' TO GDA-TX-SITUACAO
           ELSE
               IF GDA-VL-SALDO EQUAL TO ZERO
                   MOVE 'ZERADO' TO GDA-TX-SITUACAO
               ELSE
                   MOVE 'NEGATIVO' TO GDA-TX-SITUACAO
               END-IF
           END-IF.

       3000-EXIBIR.
           MOVE GDA-VL-SALDO TO GDA-VL-SALDO-FMT.
           DISPLAY 'CLIENTE: '  GDA-NM-CLIENTE.
           DISPLAY 'SALDO: '    GDA-VL-SALDO-FMT.
           DISPLAY 'SITUACAO: ' GDA-TX-SITUACAO.

           GOBACK.
      **********************