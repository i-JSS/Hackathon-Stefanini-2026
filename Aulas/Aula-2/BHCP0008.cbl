      **********************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCP0008
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 29/06/2026
      * OBJETIVO..: SIMULAR O PROCESSAMENTO DE 5 VENDAS
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

       PROGRAM-ID. BHCP0008.

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
       01 GDA-VL-VENDA-1               PIC 9(4) VALUE 100.
       01 GDA-VL-VENDA-2               PIC 9(4) VALUE 200.
       01 GDA-VL-VENDA-3               PIC 9(4) VALUE 150.
       01 GDA-VL-VENDA-4               PIC 9(4) VALUE 300.
       01 GDA-VL-VENDA-5               PIC 9(4) VALUE 400.

       01 GDA-QT-VENDAS                PIC 9(1) VALUE ZEROS.
       01 GDA-VL-TOTAL                 PIC 9(4) VALUE ZEROS.
       01 GDA-VL-MEDIA                 PIC 9(4) VALUE ZEROS.
       01 GDA-TX-SITUACAO              PIC X(16) VALUE SPACES.

       01 GDA-VL-TOTAL-FMT             PIC Z(4).
       01 GDA-VL-MEDIA-FMT             PIC Z(4).

      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------

      **********************
       PROCEDURE DIVISION.
      **********************

       1000-INICIALIZAR.
           PERFORM 2000-PROCESSAR.
           PERFORM 3000-CALCULAR.
           PERFORM 4000-CLASSIFICAR.
           PERFORM 5000-EXIBIR.

       2000-PROCESSAR.
           ADD GDA-VL-VENDA-1          TO GDA-VL-TOTAL.
           ADD GDA-VL-VENDA-2          TO GDA-VL-TOTAL.
           ADD GDA-VL-VENDA-3          TO GDA-VL-TOTAL.
           ADD GDA-VL-VENDA-4          TO GDA-VL-TOTAL.
           ADD GDA-VL-VENDA-5          TO GDA-VL-TOTAL.
           ADD 5                       TO GDA-QT-VENDAS.

       3000-CALCULAR.
           COMPUTE GDA-VL-MEDIA = GDA-VL-TOTAL / GDA-QT-VENDAS.

       4000-CLASSIFICAR.
           IF GDA-VL-TOTAL GREATER THAN OR EQUAL TO 1000
               MOVE 'META ATINGIDA'     TO GDA-TX-SITUACAO
           ELSE
               MOVE 'META NAO ATINGIDA' TO GDA-TX-SITUACAO
           END-IF.

       5000-EXIBIR.
           MOVE GDA-VL-TOTAL  TO GDA-VL-TOTAL-FMT.
           MOVE GDA-VL-MEDIA  TO GDA-VL-MEDIA-FMT.
           DISPLAY 'RESUMO DE VENDAS'.
           DISPLAY 'QUANTIDADE: ' GDA-QT-VENDAS.
           DISPLAY 'TOTAL: '      GDA-VL-TOTAL-FMT.
           DISPLAY 'MEDIA: '      GDA-VL-MEDIA-FMT.
           DISPLAY 'SITUACAO: '   GDA-TX-SITUACAO.

           GOBACK.
      **********************