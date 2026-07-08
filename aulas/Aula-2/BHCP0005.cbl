      **********************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCP0005
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 29/06/2026
      * OBJETIVO..: CALCULAR O SALDO FINAL DE UMA CONTA BANCARIA
      *             (SALDO FINAL = SALDO INICIAL + DEPOSITO - SAQUE)
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

       PROGRAM-ID. BHCP0005.

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

       01 GDA-VL-SALDO-INICIAL         PIC 9(4) VALUE 1000.
       
       01 GDA-VL-DEPOSITO              PIC 9(3) VALUE 500.
       
       01 GDA-VL-SAQUE                 PIC 9(3) VALUE 200.
       
       01 GDA-VL-SALDO-FINAL           PIC 9(4) VALUE ZEROS.

      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------

      **********************
       PROCEDURE DIVISION.
      **********************

       2000-PROCESSAR.
       
           MOVE GDA-VL-SALDO-INICIAL TO GDA-VL-SALDO-FINAL.
       
           ADD GDA-VL-DEPOSITO       TO GDA-VL-SALDO-FINAL.
       
           SUBTRACT GDA-VL-SAQUE     FROM GDA-VL-SALDO-FINAL.

       3000-EXIBIR.

           DISPLAY 'SALDO INICIAL: ' GDA-VL-SALDO-INICIAL.

           DISPLAY 'DEPOSITO: '      GDA-VL-DEPOSITO.

           DISPLAY 'SAQUE: '         GDA-VL-SAQUE.

           DISPLAY 'SALDO FINAL: '   GDA-VL-SALDO-FINAL.

           GOBACK.
      **********************