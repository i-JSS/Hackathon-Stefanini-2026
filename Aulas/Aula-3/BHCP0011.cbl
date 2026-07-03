      **********************
      * SIGLA.....: BHC – BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCP0011
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 30/06/2026
      * OBJETIVO..: CADASTRAR CONTAS EM ARRAY DINAMICO, CLASSIFICAR
      *             O CLIENTE CONFORME O SALDO E CHAMAR O
      *             SUBPROGRAMA BHCS0001 PARA EMITIR O RELATORIO.
      * EXECUCAO..: COBOL - BATCH (PROGRAMA PRINCIPAL)
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL     DESCRICAO DA VERSAO
      * --- -------- --------------- ----------------------------------
      * 001 30.06.26 JOAO CARVALHO   IMPLANTACAO
      * ----------------------------------------------------------------
      **********************

      **********************
       IDENTIFICATION DIVISION.
      **********************

       PROGRAM-ID. BHCP0011.

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

       01  GDA-ORIGEM-DADOS.
           05  FILLER.
               10  FILLER             PIC 9(05) VALUE 10001.
               10  FILLER             PIC X(15) VALUE 'JOAO'.
               10  FILLER             PIC X(01) VALUE 'C'.
               10  FILLER             PIC 9(05)V99 VALUE 15000.
           05  FILLER.
               10  FILLER             PIC 9(05) VALUE 10002.
               10  FILLER             PIC X(15) VALUE 'MARIA'.
               10  FILLER             PIC X(01) VALUE 'P'.
               10  FILLER             PIC 9(05)V99 VALUE 10000.
           05  FILLER.
               10  FILLER             PIC 9(05) VALUE 10003.
               10  FILLER             PIC X(15) VALUE 'PEDRO'.
               10  FILLER             PIC X(01) VALUE 'C'.
               10  FILLER             PIC 9(05)V99 VALUE 8200.
           05  FILLER.
               10  FILLER             PIC 9(05) VALUE 10004.
               10  FILLER             PIC X(15) VALUE 'ANA'.
               10  FILLER             PIC X(01) VALUE 'P'.
               10  FILLER             PIC 9(05)V99 VALUE 30000.
           05  FILLER.
               10  FILLER             PIC 9(05) VALUE 10005.
               10  FILLER             PIC X(15) VALUE 'LUCAS'.
               10  FILLER             PIC X(01) VALUE 'C'.
               10  FILLER             PIC 9(05)V99 VALUE 9900.
           05  FILLER.
               10  FILLER             PIC 9(05) VALUE 10006.
               10  FILLER             PIC X(15) VALUE 'FERNANDA'.
               10  FILLER             PIC X(01) VALUE 'P'.
               10  FILLER             PIC 9(05)V99 VALUE 4500.
           05  FILLER.
               10  FILLER             PIC 9(05) VALUE 10007.
               10  FILLER             PIC X(15) VALUE 'PAULO'.
               10  FILLER             PIC X(01) VALUE 'C'.
               10  FILLER             PIC 9(05)V99 VALUE 12000.
           05  FILLER.
               10  FILLER             PIC 9(05) VALUE 10008.
               10  FILLER             PIC X(15) VALUE 'MARTA'.
               10  FILLER             PIC X(01) VALUE 'P'.
               10  FILLER             PIC 9(05)V99 VALUE 10000.
           05  FILLER.
               10  FILLER             PIC 9(05) VALUE 10009.
               10  FILLER             PIC X(15) VALUE 'JULIANA'.
               10  FILLER             PIC X(01) VALUE 'C'.
               10  FILLER             PIC 9(05)V99 VALUE 7800.
           05  FILLER.
               10  FILLER             PIC 9(05) VALUE 10010.
               10  FILLER             PIC X(15) VALUE 'ROBERTO'.
               10  FILLER             PIC X(01) VALUE 'C'.
               10  FILLER             PIC 9(05)V99 VALUE 25000.

       01  GDA-ORIGEM-REDEF REDEFINES GDA-ORIGEM-DADOS.
           05  GDA-ORI-LINHA            OCCURS 10 TIMES.
               10  GDA-ORI-CONTA        PIC 9(05).
               10  GDA-ORI-CLIENTE      PIC X(15).
               10  GDA-ORI-TIPO         PIC X(01).
               10  GDA-ORI-SALDO        PIC 9(05)V99.

       01  GDA-QTD-CONTAS               PIC 9(02) VALUE ZERO.
       01  GDA-TAB-CONTAS.
           05  GDA-CONTA                OCCURS 1 TO 50 TIMES
                                         DEPENDING ON GDA-QTD-CONTAS
                                         INDEXED BY GDA-IDX.
               10  GDA-CONTA-NUM        PIC 9(05).
               10  GDA-CONTA-CLIENTE    PIC X(15).
               10  GDA-CONTA-TIPO       PIC X(01).
               10  GDA-CONTA-SALDO      PIC 9(05)V99.

       01  GDA-TIPO-DESC                PIC X(08).
       01  GDA-STATUS                   PIC X(08).

      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------

      **********************
       PROCEDURE DIVISION.
      **********************

      *----------------------------------------------------------
       1000-INICIALIZACAO                  SECTION.
      *----------------------------------------------------------

       1000-INICIO.
           PERFORM 1100-CADASTRAR-CONTAS.

           PERFORM 2000-CLASSIFICAR-E-EMITIR
                   VARYING GDA-IDX FROM 1 BY 1
                   UNTIL GDA-IDX > GDA-QTD-CONTAS.

           GOBACK.

       1000-FIM.
           EXIT.

      *----------------------------------------------------------
       1100-CADASTRAR-CONTAS               SECTION.
      *----------------------------------------------------------

       1100-INICIO.
           PERFORM VARYING GDA-IDX FROM 1 BY 1
                   UNTIL GDA-IDX > 10

               ADD 1 TO GDA-QTD-CONTAS

               MOVE GDA-ORI-CONTA (GDA-IDX)
                 TO GDA-CONTA-NUM (GDA-IDX)

               MOVE GDA-ORI-CLIENTE (GDA-IDX)
                 TO GDA-CONTA-CLIENTE (GDA-IDX)

               MOVE GDA-ORI-TIPO (GDA-IDX)
                 TO GDA-CONTA-TIPO (GDA-IDX)

               MOVE GDA-ORI-SALDO (GDA-IDX)
                 TO GDA-CONTA-SALDO (GDA-IDX)

           END-PERFORM.

       1100-FIM.
           EXIT.

      *----------------------------------------------------------
       2000-CLASSIFICAR-E-EMITIR           SECTION.
      *----------------------------------------------------------

       2000-INICIO.
      *    REGRA DE NEGOCIO - TIPO DA CONTA
           EVALUATE GDA-CONTA-TIPO (GDA-IDX)
               WHEN 'C'
                   MOVE 'CORRENTE' TO GDA-TIPO-DESC
               WHEN 'P'
                   MOVE 'POUPANCA' TO GDA-TIPO-DESC
               WHEN OTHER
                   MOVE 'INDEFIN.' TO GDA-TIPO-DESC
           END-EVALUATE

      *    REGRA DE NEGOCIO - STATUS CONFORME O SALDO
      *    SALDO > 10000  -> VIP
      *    SALDO = 10000  -> ESPECIAL
      *    SALDO < 10000  -> PADRAO
           EVALUATE TRUE
               WHEN GDA-CONTA-SALDO (GDA-IDX) > 10000
                   MOVE 'VIP'      TO GDA-STATUS
               WHEN GDA-CONTA-SALDO (GDA-IDX) = 10000
                   MOVE 'ESPECIAL' TO GDA-STATUS
               WHEN GDA-CONTA-SALDO (GDA-IDX) < 10000
                   MOVE 'PADRAO'   TO GDA-STATUS
           END-EVALUATE

           CALL 'BHCS0001' USING
               GDA-CONTA-CLIENTE (GDA-IDX)
               GDA-TIPO-DESC
               GDA-CONTA-SALDO (GDA-IDX)
               GDA-STATUS
           END-CALL.

       2000-FIM.
           EXIT.
      **********************