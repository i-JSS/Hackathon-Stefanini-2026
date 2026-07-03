      **********************
      * SIGLA.....: BHC – BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCP0015
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 02/07/2026
      * OBJETIVO..: PROCESSAR LANCAMENTOS DE UMA CONTA FICTICIA,
      *             VALIDANDO OS DADOS, ATUALIZANDO TOTALIZADORES
      *             E CALCULANDO O SALDO FINAL DA CONTA.
      * EXECUCAO..: COBOL - BATCH
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL     DESCRICAO DA VERSAO
      * --- -------- --------------- ----------------------------------
      * 001 02.07.26 JOAO CARVALHO   IMPLANTACAO
      * ----------------------------------------------------------------
      **********************

      **********************
       IDENTIFICATION DIVISION.
      **********************

       PROGRAM-ID. BHCP0015.

      **********************
       ENVIRONMENT DIVISION.
      **********************

      *----------------------------------------
       CONFIGURATION                   SECTION.
      *----------------------------------------
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

      *----------------------------------------
       INPUT-OUTPUT                    SECTION.
      *----------------------------------------
       FILE-CONTROL.
           SELECT BHCF015E ASSIGN TO "BHCF015E"
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE  IS SEQUENTIAL
               FILE STATUS  IS WS-FS-BHCF015E.

           SELECT BHCF015S ASSIGN TO "BHCF015S"
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE  IS SEQUENTIAL
               FILE STATUS  IS WS-FS-BHCF015S.

           SELECT BHCF015L ASSIGN TO "BHCF015L"
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE  IS SEQUENTIAL
               FILE STATUS  IS WS-FS-BHCF015L.

      **********************
       DATA DIVISION.
      **********************

      *----------------------------------------
       FILE                             SECTION.
      *----------------------------------------
       FD  BHCF015E
           RECORDING MODE IS F.
       01  REG-BHCF015E.
           05 IN-COD-CONTA             PIC 9(005).
           05 IN-DATA-LANC             PIC 9(008).
           05 IN-TIPO-LANC             PIC X(001).
           05 IN-VALOR-LANC            PIC 9(007)V99.
           05 IN-HISTORICO             PIC X(030).

       FD  BHCF015S
           RECORDING MODE IS F.
       01  REG-BHCF015S.
           05 OUT-COD-CONTA            PIC 9(005).
           05 OUT-DATA-LANC            PIC 9(008).
           05 OUT-TIPO-LANC            PIC X(001).
           05 OUT-VALOR-LANC           PIC 9(007)V99.
           05 OUT-HISTORICO            PIC X(030).
           05 OUT-SALDO-APOS           PIC 9(007)V99.

       FD  BHCF015L
           RECORDING MODE IS F.
       01  REG-BHCF015L.
           05 LOG-COD-CONTA            PIC 9(005).
           05 LOG-DATA-LANC            PIC 9(008).
           05 LOG-TIPO-LANC            PIC X(001).
           05 LOG-VALOR-LANC           PIC 9(007)V99.
           05 LOG-COD-ERRO             PIC X(004).
           05 LOG-MENSAGEM             PIC X(040).

      *----------------------------------------
       WORKING-STORAGE                 SECTION.
      *----------------------------------------
       01  GDA-SALDO-INICIAL           PIC 9(007)V99 VALUE 1000,00.
       01  GDA-SALDO-ATUAL             PIC 9(007)V99 VALUE ZEROS.

       01  GDA-SALDO-INICIAL-DISP      PIC 9(010)V99 VALUE ZEROS.
       01  GDA-SALDO-FINAL-DISP        PIC 9(010)V99 VALUE ZEROS.

       01  GDA-CONTADORES.
           05 GDA-QTD-LIDOS            PIC 9(005) VALUE ZEROS.
           05 GDA-QTD-VALIDOS          PIC 9(005) VALUE ZEROS.
           05 GDA-QTD-REJEITADOS       PIC 9(005) VALUE ZEROS.
           05 GDA-QTD-DEPOSITOS        PIC 9(005) VALUE ZEROS.
           05 GDA-QTD-SAQUES           PIC 9(005) VALUE ZEROS.
           05 GDA-QTD-TRANSFER         PIC 9(005) VALUE ZEROS.
           05 GDA-QTD-ERROS-ARQUIVO    PIC 9(005) VALUE ZEROS.

       01  GDA-VALORES.
           05 GDA-VLR-DEPOSITOS        PIC 9(009)V99 VALUE ZEROS.
           05 GDA-VLR-SAQUES           PIC 9(009)V99 VALUE ZEROS.
           05 GDA-VLR-TRANSFER         PIC 9(009)V99 VALUE ZEROS.

       01  GDA-FLAG-FIM-ARQUIVO        PIC X(001) VALUE 'N'.
           88 GDA-FIM-ARQUIVO                      VALUE 'S'.

       01  GDA-FLAG-REG-VALIDO         PIC X(001) VALUE 'S'.
           88 GDA-REGISTRO-VALIDO                  VALUE 'S'.

       01  GDA-COD-ERRO                PIC X(004) VALUE SPACES.
       01  GDA-MSG-ERRO                PIC X(040) VALUE SPACES.

       01  WS-FS-BHCF015E              PIC X(002) VALUE SPACES.
       01  WS-FS-BHCF015S              PIC X(002) VALUE SPACES.
       01  WS-FS-BHCF015L              PIC X(002) VALUE SPACES.

      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------

      **********************
       PROCEDURE DIVISION.
      **********************

       0000-PRINCIPAL.
           PERFORM 1000-INICIALIZAR
           PERFORM 2000-ABRIR-ARQUIVOS
           PERFORM 3000-PROCESSAR-ARQUIVO
           PERFORM 8000-FECHAR-ARQUIVOS
           PERFORM 9000-EXIBIR-RESUMO
           PERFORM 9999-FINALIZAR.

       1000-INICIALIZAR.
           MOVE GDA-SALDO-INICIAL TO GDA-SALDO-ATUAL.

       2000-ABRIR-ARQUIVOS.
           OPEN INPUT  BHCF015E
           IF WS-FS-BHCF015E NOT = '00'
               ADD 1 TO GDA-QTD-ERROS-ARQUIVO
               DISPLAY 'ERRO AO ABRIR BHCF015E - STATUS: '
                        WS-FS-BHCF015E
           END-IF

           OPEN OUTPUT BHCF015S
           IF WS-FS-BHCF015S NOT = '00'
               ADD 1 TO GDA-QTD-ERROS-ARQUIVO
               DISPLAY 'ERRO AO ABRIR BHCF015S - STATUS: '
                        WS-FS-BHCF015S
           END-IF

           OPEN OUTPUT BHCF015L
           IF WS-FS-BHCF015L NOT = '00'
               ADD 1 TO GDA-QTD-ERROS-ARQUIVO
               DISPLAY 'ERRO AO ABRIR BHCF015L - STATUS: '
                        WS-FS-BHCF015L
           END-IF.

       3000-PROCESSAR-ARQUIVO.
           PERFORM 3100-LER-ENTRADA
           PERFORM UNTIL GDA-FIM-ARQUIVO
               ADD 1 TO GDA-QTD-LIDOS
               PERFORM 3200-VALIDAR-LANCAMENTO
               IF GDA-REGISTRO-VALIDO
                   PERFORM 3300-PROCESSAR-LANCAMENTO
                   PERFORM 3400-GRAVAR-SAIDA
                   ADD 1 TO GDA-QTD-VALIDOS
               ELSE
                   PERFORM 3500-GRAVAR-LOG
                   ADD 1 TO GDA-QTD-REJEITADOS
               END-IF
               PERFORM 3100-LER-ENTRADA
           END-PERFORM.

       3100-LER-ENTRADA.
           READ BHCF015E
               AT END
                   SET GDA-FIM-ARQUIVO TO TRUE
           END-READ.

       3200-VALIDAR-LANCAMENTO.
           SET GDA-REGISTRO-VALIDO TO TRUE
           MOVE SPACES TO GDA-COD-ERRO
           MOVE SPACES TO GDA-MSG-ERRO

           EVALUATE TRUE
               WHEN IN-COD-CONTA = ZEROS
                   MOVE 'N'    TO GDA-FLAG-REG-VALIDO
                   MOVE 'E001' TO GDA-COD-ERRO
                   MOVE 'CODIGO DA CONTA INVALIDO'
                        TO GDA-MSG-ERRO

               WHEN IN-DATA-LANC = ZEROS
                   MOVE 'N'    TO GDA-FLAG-REG-VALIDO
                   MOVE 'E002' TO GDA-COD-ERRO
                   MOVE 'DATA DO LANCAMENTO INVALIDA'
                        TO GDA-MSG-ERRO

               WHEN IN-TIPO-LANC NOT = 'D' AND
                    IN-TIPO-LANC NOT = 'S' AND
                    IN-TIPO-LANC NOT = 'T'
                   MOVE 'N'    TO GDA-FLAG-REG-VALIDO
                   MOVE 'E003' TO GDA-COD-ERRO
                   MOVE 'TIPO DE OPERACAO INVALIDO'
                        TO GDA-MSG-ERRO

               WHEN IN-VALOR-LANC = ZEROS
                   MOVE 'N'    TO GDA-FLAG-REG-VALIDO
                   MOVE 'E004' TO GDA-COD-ERRO
                   MOVE 'VALOR DO LANCAMENTO INVALIDO'
                        TO GDA-MSG-ERRO

               WHEN IN-HISTORICO = SPACES
                   MOVE 'N'    TO GDA-FLAG-REG-VALIDO
                   MOVE 'E005' TO GDA-COD-ERRO
                   MOVE 'HISTORICO NAO PREENCHIDO'
                        TO GDA-MSG-ERRO

               WHEN (IN-TIPO-LANC = 'S' OR IN-TIPO-LANC = 'T')
                    AND IN-VALOR-LANC > GDA-SALDO-ATUAL
                   MOVE 'N'    TO GDA-FLAG-REG-VALIDO
                   MOVE 'E006' TO GDA-COD-ERRO
                   MOVE 'SALDO INSUFICIENTE PARA OPERACAO'
                        TO GDA-MSG-ERRO
           END-EVALUATE.

       3300-PROCESSAR-LANCAMENTO.
           EVALUATE IN-TIPO-LANC
               WHEN 'D'
                   ADD IN-VALOR-LANC TO GDA-SALDO-ATUAL
                   ADD 1             TO GDA-QTD-DEPOSITOS
                   ADD IN-VALOR-LANC TO GDA-VLR-DEPOSITOS

               WHEN 'S'
                   SUBTRACT IN-VALOR-LANC FROM GDA-SALDO-ATUAL
                   ADD 1             TO GDA-QTD-SAQUES
                   ADD IN-VALOR-LANC TO GDA-VLR-SAQUES

               WHEN 'T'
                   SUBTRACT IN-VALOR-LANC FROM GDA-SALDO-ATUAL
                   ADD 1             TO GDA-QTD-TRANSFER
                   ADD IN-VALOR-LANC TO GDA-VLR-TRANSFER
           END-EVALUATE.

       3400-GRAVAR-SAIDA.
           MOVE IN-COD-CONTA    TO OUT-COD-CONTA
           MOVE IN-DATA-LANC    TO OUT-DATA-LANC
           MOVE IN-TIPO-LANC    TO OUT-TIPO-LANC
           MOVE IN-VALOR-LANC   TO OUT-VALOR-LANC
           MOVE IN-HISTORICO    TO OUT-HISTORICO
           MOVE GDA-SALDO-ATUAL TO OUT-SALDO-APOS
           WRITE REG-BHCF015S
           IF WS-FS-BHCF015S NOT = '00'
               ADD 1 TO GDA-QTD-ERROS-ARQUIVO
           END-IF.

       3500-GRAVAR-LOG.
           MOVE IN-COD-CONTA  TO LOG-COD-CONTA
           MOVE IN-DATA-LANC  TO LOG-DATA-LANC
           MOVE IN-TIPO-LANC  TO LOG-TIPO-LANC
           MOVE IN-VALOR-LANC TO LOG-VALOR-LANC
           MOVE GDA-COD-ERRO  TO LOG-COD-ERRO
           MOVE GDA-MSG-ERRO  TO LOG-MENSAGEM
           WRITE REG-BHCF015L
           IF WS-FS-BHCF015L NOT = '00'
               ADD 1 TO GDA-QTD-ERROS-ARQUIVO
           END-IF.

       8000-FECHAR-ARQUIVOS.
           CLOSE BHCF015E
           CLOSE BHCF015S
           CLOSE BHCF015L.

       9000-EXIBIR-RESUMO.
           MOVE GDA-SALDO-INICIAL TO GDA-SALDO-INICIAL-DISP
           MOVE GDA-SALDO-ATUAL   TO GDA-SALDO-FINAL-DISP

           DISPLAY 'BHCP0015 - PROCESSAMENTO DE LANCAMENTOS'
           DISPLAY '---------------------------------------'
           DISPLAY 'TOTAL DE REGISTROS LIDOS........: '
                    GDA-QTD-LIDOS
           DISPLAY 'TOTAL DE REGISTROS VALIDOS......: '
                    GDA-QTD-VALIDOS
           DISPLAY 'TOTAL DE REGISTROS REJEITADOS...: '
                    GDA-QTD-REJEITADOS
           DISPLAY 'TOTAL DE DEPOSITOS..............: '
                    GDA-QTD-DEPOSITOS
           DISPLAY 'TOTAL DE SAQUES.................: '
                    GDA-QTD-SAQUES
           DISPLAY 'TOTAL DE TRANSFERENCIAS.........: '
                    GDA-QTD-TRANSFER
           DISPLAY 'VALOR TOTAL DEPOSITOS...........: '
                    GDA-VLR-DEPOSITOS
           DISPLAY 'VALOR TOTAL SAQUES..............: '
                    GDA-VLR-SAQUES
           DISPLAY 'VALOR TOTAL TRANSFERENCIAS......: '
                    GDA-VLR-TRANSFER
           DISPLAY 'SALDO INICIAL...................: '
                    GDA-SALDO-INICIAL-DISP
           DISPLAY 'SALDO FINAL.....................: '
                    GDA-SALDO-FINAL-DISP
           DISPLAY 'TOTAL DE ERROS DE ARQUIVO.......: '
                    GDA-QTD-ERROS-ARQUIVO
           DISPLAY '---------------------------------------'
           DISPLAY 'BHCP0015 - FIM DO PROCESSAMENTO'.

       9999-FINALIZAR.
           GOBACK.
           
      **********************