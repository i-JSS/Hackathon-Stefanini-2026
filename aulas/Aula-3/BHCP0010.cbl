      **********************
      * SIGLA.....: BHC – BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCP0010
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 30/06/2026
      * OBJETIVO..: CADASTRAR PRODUTOS EM ARRAY DINAMICO (OCCURS
      *             DEPENDING ON) E CLASSIFICAR PELO PRECO USANDO
      *             EVALUATE COM OPERADORES RELACIONAIS NEGATIVOS.
      * EXECUCAO..: COBOL - BATCH
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL     DESCRICAO DA VERSAO
      * --- -------- --------------- ----------------------------------
      * 001 30.06.26 JOAO CARVALHO   IMPLANTACAO
      * ----------------------------------------------------------------
      **********************

      **********************
       IDENTIFICATION DIVISION.
      **********************

       PROGRAM-ID. BHCP0010.

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

      *----------------------------------------------------------
      * ORIGEM DOS DADOS SUGERIDOS (TABELA FIXA, SOMENTE PARA
      * ALIMENTAR O ARRAY DINAMICO ABAIXO). CADA CAMPO TEM SEU
      * PROPRIO PIC/VALUE PARA O COMPILADOR AJUSTAR O TAMANHO.
      *----------------------------------------------------------
       01  GDA-ORIGEM-DADOS.
           05  FILLER.
               10  FILLER             PIC 9(03) VALUE 101.
               10  FILLER             PIC X(15) VALUE 'MOUSE'.
               10  FILLER             PIC 9(05)V99 VALUE 80.
           05  FILLER.
               10  FILLER             PIC 9(03) VALUE 102.
               10  FILLER             PIC X(15) VALUE 'MONITOR'.
               10  FILLER             PIC 9(05)V99 VALUE 900.
           05  FILLER.
               10  FILLER             PIC 9(03) VALUE 103.
               10  FILLER             PIC X(15) VALUE 'TECLADO'.
               10  FILLER             PIC 9(05)V99 VALUE 150.
           05  FILLER.
               10  FILLER             PIC 9(03) VALUE 104.
               10  FILLER             PIC X(15) VALUE 'NOTEBOOK'.
               10  FILLER             PIC 9(05)V99 VALUE 4200.
           05  FILLER.
               10  FILLER             PIC 9(03) VALUE 105.
               10  FILLER             PIC X(15) VALUE 'HEADSET'.
               10  FILLER             PIC 9(05)V99 VALUE 280.
           05  FILLER.
               10  FILLER             PIC 9(03) VALUE 106.
               10  FILLER             PIC X(15) VALUE 'WEBCAM'.
               10  FILLER             PIC 9(05)V99 VALUE 320.
           05  FILLER.
               10  FILLER             PIC 9(03) VALUE 107.
               10  FILLER             PIC X(15) VALUE 'SSD'.
               10  FILLER             PIC 9(05)V99 VALUE 550.
           05  FILLER.
               10  FILLER             PIC 9(03) VALUE 108.
               10  FILLER             PIC X(15) VALUE 'PENDRIVE'.
               10  FILLER             PIC 9(05)V99 VALUE 60.
           05  FILLER.
               10  FILLER             PIC 9(03) VALUE 109.
               10  FILLER             PIC X(15) VALUE 'HD EXTERNO'.
               10  FILLER             PIC 9(05)V99 VALUE 480.
           05  FILLER.
               10  FILLER             PIC 9(03) VALUE 110.
               10  FILLER             PIC X(15) VALUE 'IMPRESSORA'.
               10  FILLER             PIC 9(05)V99 VALUE 1100.

       01  GDA-ORIGEM-REDEF REDEFINES GDA-ORIGEM-DADOS.
           05  GDA-ORI-LINHA           OCCURS 10 TIMES.
               10  GDA-ORI-COD         PIC 9(03).
               10  GDA-ORI-DESC        PIC X(15).
               10  GDA-ORI-PRECO       PIC 9(05)V99.

      *----------------------------------------------------------
      * CONTADOR QUE CONTROLA O TAMANHO ATUAL DO ARRAY DINAMICO.
      * A QUANTIDADE DE PRODUTOS VARIA DIARIAMENTE, POR ISSO O
      * ARRAY CRESCE CONFORME O CADASTRO (OCCURS DEPENDING ON).
      *----------------------------------------------------------
       01  GDA-QTD-PRODUTOS            PIC 9(03) VALUE ZERO.

      *----------------------------------------------------------
      * ARRAY DINAMICO DE PRODUTOS - ATE 100 POSICOES
      *----------------------------------------------------------
       01  GDA-TAB-PRODUTOS.
           05  GDA-PRODUTO             OCCURS 1 TO 100 TIMES
                                        DEPENDING ON GDA-QTD-PRODUTOS
                                        INDEXED BY GDA-IDX.
               10  GDA-PROD-COD        PIC 9(03).
               10  GDA-PROD-DESC       PIC X(15).
               10  GDA-PROD-PRECO      PIC 9(05)V99.

      *----------------------------------------------------------
      * VARIAVEIS AUXILIARES DE CLASSIFICACAO E RELATORIO
      *----------------------------------------------------------
       01  GDA-CLASSIFICACAO           PIC X(07).

       01  GDA-LINHA-RELATORIO         PIC X(40).

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
           PERFORM 1100-CADASTRAR-PRODUTOS.

           PERFORM 2000-CLASSIFICAR-E-EMITIR
                   VARYING GDA-IDX FROM 1 BY 1
                   UNTIL GDA-IDX > GDA-QTD-PRODUTOS.

           GOBACK.

       1000-FIM.
           EXIT.

      *----------------------------------------------------------
       1100-CADASTRAR-PRODUTOS             SECTION.
      *----------------------------------------------------------

       1100-INICIO.
           PERFORM VARYING GDA-IDX FROM 1 BY 1
                   UNTIL GDA-IDX > 10

               ADD 1 TO GDA-QTD-PRODUTOS

               MOVE GDA-ORI-COD (GDA-IDX)
                 TO GDA-PROD-COD (GDA-IDX)

               MOVE GDA-ORI-DESC (GDA-IDX)
                 TO GDA-PROD-DESC (GDA-IDX)

               MOVE GDA-ORI-PRECO (GDA-IDX)
                 TO GDA-PROD-PRECO (GDA-IDX)

           END-PERFORM.

       1100-FIM.
           EXIT.

      *----------------------------------------------------------
       2000-CLASSIFICAR-E-EMITIR           SECTION.
      *----------------------------------------------------------

       2000-INICIO.
      *    REGRAS DE NEGOCIO (EVALUATE TRUE COM OPERADORES
      *    RELACIONAIS NEGATIVOS):
      *    PRECO < 100        -> BARATO
      *    PRECO ENTRE 100-500 -> NORMAL
      *    PRECO > 500        -> CARO
           EVALUATE TRUE
               WHEN GDA-PROD-PRECO (GDA-IDX) NOT GREATER THAN 99,99
                   MOVE 'BARATO' TO GDA-CLASSIFICACAO

               WHEN GDA-PROD-PRECO (GDA-IDX) NOT LESS THAN 100
                AND GDA-PROD-PRECO (GDA-IDX) NOT GREATER THAN 500
                   MOVE 'NORMAL' TO GDA-CLASSIFICACAO

               WHEN OTHER
                   MOVE 'CARO' TO GDA-CLASSIFICACAO
           END-EVALUATE

      *    VALIDA SE A CATEGORIA FOI REALMENTE PREENCHIDA
           IF GDA-CLASSIFICACAO NOT EQUAL SPACES
               MOVE SPACES TO GDA-LINHA-RELATORIO

               STRING
                   GDA-PROD-COD (GDA-IDX)     DELIMITED BY SIZE
                   ' '                        DELIMITED BY SIZE
                   GDA-PROD-DESC (GDA-IDX)    DELIMITED BY SPACE
                   ' '                        DELIMITED BY SIZE
                   GDA-CLASSIFICACAO          DELIMITED BY SPACE
                   INTO GDA-LINHA-RELATORIO
               END-STRING

               DISPLAY GDA-LINHA-RELATORIO
           END-IF.

       2000-FIM.
           EXIT.
      **********************