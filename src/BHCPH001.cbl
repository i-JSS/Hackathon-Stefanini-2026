      ******************************************************************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCPH001
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 05/07/2026
      * OBJETIVO..: SISTEMA FINANCEIRO - FINANCE CORE
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

       PROGRAM-ID. BHCPH001.

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

           SELECT FD-ARQ-EXT ASSIGN TO 'BHCFHEXT.txt'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FS-EXT.

           SELECT FD-ARQ-LOG ASSIGN TO 'BHCFHLOG.txt'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FS-LOG.

           SELECT FD-ARQ-JSN ASSIGN TO 'BHCFHJSN.json'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS FS-JSN.

      ******************************************************************
       DATA DIVISION.
      ******************************************************************

      *----------------------------------------
       FILE                             SECTION.
      *----------------------------------------

       FD  FD-ARQ-CLI.
       01  BHCFHCLI-REG                 PIC X(058).

       FD  FD-ARQ-TRA.
       01  BHCFHTRA-REG                 PIC X(031).

       FD  FD-ARQ-EXT.
       01  BHCFHEXT-REG                 PIC X(059).

       FD  FD-ARQ-LOG.
       01  BHCFHLOG-REG                 PIC X(091).

       FD  FD-ARQ-JSN.
       01  BHCFHJSN-REG                 PIC X(200).

      *----------------------------------------
       WORKING-STORAGE                 SECTION.
      *----------------------------------------

       77  CTE-PGM                      PIC X(008) VALUE 'BHCPH001'.
       77  BHCSH001                     PIC X(008) VALUE 'BHCSH001'.

       77  FS-CLI                       PIC X(002) VALUE SPACES.
       77  FS-TRA                       PIC X(002) VALUE SPACES.
       77  FS-EXT                       PIC X(002) VALUE SPACES.
       77  FS-LOG                       PIC X(002) VALUE SPACES.
       77  FS-JSN                       PIC X(002) VALUE SPACES.

       77  WS-FS-ARQ                    PIC X(008) VALUE SPACES.
       77  WS-FS-OPER                   PIC X(010) VALUE SPACES.
       77  WS-FS-VALOR                  PIC X(002) VALUE SPACES.
       77  WS-FS-DESC                   PIC X(040) VALUE SPACES.

       77  WS-FS-IND                    PIC X(001) VALUE 'N'.
           88 FS-COM-ERRO                          VALUE 'S'.
           88 FS-SEM-ERRO                          VALUE 'N'.

       77  GDA-FIM-CLI                  PIC X(001) VALUE 'N'.
           88 FIM-CLI                              VALUE 'S'.
           88 NAO-FIM-CLI                          VALUE 'N'.

       77  GDA-FIM-TRA                  PIC X(001) VALUE 'N'.
           88 FIM-TRA                              VALUE 'S'.
           88 NAO-FIM-TRA                          VALUE 'N'.

       77  WS-MSG-ERR                   PIC X(080) VALUE SPACES.

       01  WS-DATA-HORA-FULL.
           05 WS-DT-ANO                 PIC 9(004).
           05 WS-DT-MES                 PIC 9(002).
           05 WS-DT-DIA                 PIC 9(002).
           05 WS-HR-HORA                PIC 9(002).
           05 WS-HR-MIN                 PIC 9(002).
           05 WS-HR-SEG                 PIC 9(002).
           05 FILLER                    PIC X(009).

       01  WS-TOTALIZADORES.
           05 WS-TOT-CLI-LIDOS          PIC 9(005) VALUE ZEROS.
           05 WS-TOT-TRA-LIDAS          PIC 9(005) VALUE ZEROS.
           05 WS-TOT-TRA-VALIDAS        PIC 9(005) VALUE ZEROS.
           05 WS-TOT-TRA-REJ            PIC 9(005) VALUE ZEROS.
           05 WS-TOT-EXT-GRV            PIC 9(005) VALUE ZEROS.
           05 WS-TOT-LOG-GRV            PIC 9(005) VALUE ZEROS.
           05 WS-TOT-JSN-GRV            PIC 9(005) VALUE ZEROS.

       01  WS-TB-CLI-AREA.
           05 WS-TB-CLI OCCURS 100 TIMES INDEXED BY WS-IDX-CLI.
              10 WS-CLI-CD              PIC 9(005).
              10 WS-CLI-NM              PIC X(030).
              10 WS-CLI-CPF             PIC 9(011).
              10 WS-CLI-SDO             PIC 9(009)V99.
              10 WS-CLI-ST              PIC X(001).

       01  WS-TB-CLI-FLAT REDEFINES WS-TB-CLI-AREA PIC X(5800).
       77  WS-QT-CLI                    PIC 9(003) VALUE ZEROS.
       01  WS-SDO-ANT                   PIC 9(009)V99 VALUE ZEROS.
       01  WS-SDO-ATU                   PIC 9(009)V99 VALUE ZEROS.

       01  GDA-AREA-VALID.
           COPY BHCPARAM.

       01  WS-AREA-JSON.
           COPY BHCJSONX.

      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------

       01  FD-REG-CLI.
           COPY BHCCLIEN.

       01  FD-REG-TRA.
           COPY BHCTRAXX.

       01  FD-REG-EXT.
           COPY BHCEXTXX.

       01  FD-REG-LOG.
           COPY BHCLOGXX.

      ******************************************************************
       PROCEDURE DIVISION.
      ******************************************************************

           PERFORM 100000-INICIALIZAR
           PERFORM 200000-CARREGAR-CLIENTES
           PERFORM 300000-PROCESSAR-TRANSACOES
           PERFORM 400000-GRAVAR-CABECALHO-JSON
           PERFORM 500000-FINALIZAR
           .

           GOBACK.

      *----------------------------------------
       100000-INICIALIZAR              SECTION.
      *----------------------------------------
      
           MOVE FUNCTION CURRENT-DATE TO WS-DATA-HORA-FULL

           OPEN INPUT  FD-ARQ-CLI
           MOVE 'BHCFHCLI' TO WS-FS-ARQ
           MOVE 'OPEN'     TO WS-FS-OPER
           MOVE FS-CLI     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO ABRIR BHCFHCLI' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           OPEN INPUT  FD-ARQ-TRA
           MOVE 'BHCFHTRA' TO WS-FS-ARQ
           MOVE 'OPEN'     TO WS-FS-OPER
           MOVE FS-TRA     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO ABRIR BHCFHTRA' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           OPEN OUTPUT FD-ARQ-EXT
           MOVE 'BHCFHEXT' TO WS-FS-ARQ
           MOVE 'OPEN'     TO WS-FS-OPER
           MOVE FS-EXT     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO ABRIR BHCFHEXT' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           OPEN OUTPUT FD-ARQ-LOG
           MOVE 'BHCFHLOG' TO WS-FS-ARQ
           MOVE 'OPEN'     TO WS-FS-OPER
           MOVE FS-LOG     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO ABRIR BHCFHLOG' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           OPEN OUTPUT FD-ARQ-JSN
           MOVE 'BHCFHJSN' TO WS-FS-ARQ
           MOVE 'OPEN'     TO WS-FS-OPER
           MOVE FS-JSN     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO ABRIR BHCFHJSN' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           SET NAO-FIM-CLI TO TRUE
           SET NAO-FIM-TRA TO TRUE

           DISPLAY '*************************************************'
           DISPLAY '* SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL'
           DISPLAY '* PROGRAMA..: ' CTE-PGM
           DISPLAY '* ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR'
           DISPLAY '* AUTOR.....: JOAO ANTONIO GINUINO CARVALHO'
           DISPLAY '* DATA/HORA.: ' WS-DT-DIA '/' WS-DT-MES '/'
               WS-DT-ANO ' - ' WS-HR-HORA ':' WS-HR-MIN ':' WS-HR-SEG
           DISPLAY '* OBJETIVO..: SISTEMA FINANCEIRO - FINANCE CORE'
           DISPLAY '* EXECUCAO..: COBOL - BATCH'
           DISPLAY '*************************************************'
           .
       100000-FIM.
           EXIT.

      *----------------------------------------
       200000-CARREGAR-CLIENTES        SECTION.
      *----------------------------------------
      
           PERFORM 210000-LER-CLIENTE
           PERFORM UNTIL FIM-CLI
               SET WS-IDX-CLI TO WS-QT-CLI
               SET WS-IDX-CLI UP BY 1
               MOVE FD-CLI-CD  TO WS-CLI-CD(WS-IDX-CLI)
               MOVE FD-CLI-NM  TO WS-CLI-NM(WS-IDX-CLI)
               MOVE FD-CLI-CPF TO WS-CLI-CPF(WS-IDX-CLI)
               MOVE FD-CLI-SDO TO WS-CLI-SDO(WS-IDX-CLI)
               MOVE FD-CLI-ST  TO WS-CLI-ST(WS-IDX-CLI)
               ADD 1 TO WS-QT-CLI
               PERFORM 210000-LER-CLIENTE
           END-PERFORM
           .
       200000-FIM.
           EXIT.

      *----------------------------------------
       210000-LER-CLIENTE              SECTION.
      *----------------------------------------

           READ FD-ARQ-CLI INTO FD-REG-CLI
               AT END
                   SET FIM-CLI TO TRUE
               NOT AT END
                   ADD 1 TO WS-TOT-CLI-LIDOS
           END-READ

           MOVE 'BHCFHCLI' TO WS-FS-ARQ
           MOVE 'READ'     TO WS-FS-OPER
           MOVE FS-CLI     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO LER BHCFHCLI' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF
           .
       210000-FIM.
           EXIT.

      *----------------------------------------
       300000-PROCESSAR-TRANSACOES     SECTION.
      *----------------------------------------

           PERFORM 310000-LER-TRANSACAO
           PERFORM UNTIL FIM-TRA
               PERFORM 320000-VALIDAR-TRANSACAO
               IF GDA-CD-RETORNO = 00
                   PERFORM 330000-GRAVAR-EXTRATO
               ELSE
                   PERFORM 340000-GRAVAR-LOG
               END-IF
               PERFORM 310000-LER-TRANSACAO
           END-PERFORM
           .
       300000-FIM.
           EXIT.

      *----------------------------------------
       310000-LER-TRANSACAO            SECTION.
      *----------------------------------------

           READ FD-ARQ-TRA INTO FD-REG-TRA
               AT END
                   SET FIM-TRA TO TRUE
               NOT AT END
                   ADD 1 TO WS-TOT-TRA-LIDAS
           END-READ

           MOVE 'BHCFHTRA' TO WS-FS-ARQ
           MOVE 'READ'     TO WS-FS-OPER
           MOVE FS-TRA     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO LER BHCFHTRA' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF
           .
       310000-FIM.
           EXIT.

      *----------------------------------------
       320000-VALIDAR-TRANSACAO        SECTION.
      *----------------------------------------

           MOVE FD-TRA-ID     TO GDA-TRA-ID
           MOVE FD-TRA-CD-CLI TO GDA-TRA-CD-CLI
           MOVE FD-TRA-TP     TO GDA-TRA-TP
           MOVE FD-TRA-VLR    TO GDA-TRA-VLR
           MOVE WS-QT-CLI     TO GDA-QT-CLI
           MOVE WS-TB-CLI-FLAT TO GDA-TB-CLI-FLAT

           CALL BHCSH001 USING GDA-AREA-VALID
           END-CALL

           IF GDA-CD-RETORNO = 00
               ADD 1 TO WS-TOT-TRA-VALIDAS
               SET WS-IDX-CLI TO GDA-IDX-CLI
               MOVE WS-CLI-SDO(WS-IDX-CLI) TO WS-SDO-ANT
               EVALUATE FD-TRA-TP
                   WHEN 'D'
                       ADD FD-TRA-VLR TO WS-CLI-SDO(WS-IDX-CLI)
                   WHEN 'S'
                       SUBTRACT FD-TRA-VLR FROM
                           WS-CLI-SDO(WS-IDX-CLI)
                   WHEN 'P'
                       SUBTRACT FD-TRA-VLR FROM
                           WS-CLI-SDO(WS-IDX-CLI)
               END-EVALUATE
               MOVE WS-CLI-SDO(WS-IDX-CLI) TO WS-SDO-ATU
           ELSE
               ADD 1 TO WS-TOT-TRA-REJ
           END-IF
           .
       320000-FIM.
           EXIT.

      *----------------------------------------
       330000-GRAVAR-EXTRATO           SECTION.
      *----------------------------------------

           MOVE FD-TRA-ID     TO FD-EXT-ID-TRA
           MOVE FD-TRA-CD-CLI TO FD-EXT-CD-CLI
           MOVE FD-TRA-TP     TO FD-EXT-TP-TRA
           MOVE FD-TRA-VLR    TO FD-EXT-VLR-TRA
           MOVE WS-SDO-ANT    TO FD-EXT-SDO-ANT
           MOVE WS-SDO-ATU    TO FD-EXT-SDO-ATU
           MOVE FD-TRA-DT     TO FD-EXT-DT-TRA

           WRITE BHCFHEXT-REG FROM FD-REG-EXT

           MOVE 'BHCFHEXT' TO WS-FS-ARQ
           MOVE 'WRITE'    TO WS-FS-OPER
           MOVE FS-EXT     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO GRAVAR BHCFHEXT' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           ELSE
               ADD 1 TO WS-TOT-EXT-GRV
           END-IF
           .
       330000-FIM.
           EXIT.

      *----------------------------------------
       340000-GRAVAR-LOG                SECTION.
      *----------------------------------------

           MOVE FD-TRA-ID       TO FD-LOG-ID-TRA
           MOVE FD-TRA-CD-CLI   TO FD-LOG-CD-CLI
           MOVE FD-TRA-TP       TO FD-LOG-TP-TRA
           MOVE FD-TRA-VLR      TO FD-LOG-VLR-TRA
           MOVE GDA-CD-RETORNO  TO FD-LOG-CD-ERR
           MOVE GDA-MSG-ERRO    TO FD-LOG-MSG-ERR

           WRITE BHCFHLOG-REG FROM FD-REG-LOG

           MOVE 'BHCFHLOG' TO WS-FS-ARQ
           MOVE 'WRITE'    TO WS-FS-OPER
           MOVE FS-LOG     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO GRAVAR BHCFHLOG' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           ELSE
               ADD 1 TO WS-TOT-LOG-GRV
           END-IF
           .
       340000-FIM.
           EXIT.

      *----------------------------------------
       400000-GRAVAR-CABECALHO-JSON    SECTION.
      *----------------------------------------

           MOVE '{' TO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE SPACES TO JSN-LINHA-JSN
           STRING '  "sistema": "FINANCE CORE",'
               DELIMITED BY SIZE INTO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE SPACES TO JSN-LINHA-JSN
           STRING '  "programa": "' CTE-PGM '",'
               DELIMITED BY SIZE INTO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE '  "totalizadores": {' TO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE WS-TOT-CLI-LIDOS TO JSN-TX-QT
           MOVE SPACES TO JSN-LINHA-JSN
           STRING '    "clientesLidos": '
               FUNCTION TRIM(JSN-TX-QT) ','
               DELIMITED BY SIZE INTO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE WS-TOT-TRA-LIDAS TO JSN-TX-QT
           MOVE SPACES TO JSN-LINHA-JSN
           STRING '    "transacoesLidas": '
               FUNCTION TRIM(JSN-TX-QT) ','
               DELIMITED BY SIZE INTO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE WS-TOT-TRA-VALIDAS TO JSN-TX-QT
           MOVE SPACES TO JSN-LINHA-JSN
           STRING '    "transacoesValidas": '
               FUNCTION TRIM(JSN-TX-QT) ','
               DELIMITED BY SIZE INTO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE WS-TOT-TRA-REJ TO JSN-TX-QT
           MOVE SPACES TO JSN-LINHA-JSN
           STRING '    "transacoesRejeitadas": '
               FUNCTION TRIM(JSN-TX-QT)
               DELIMITED BY SIZE INTO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE '  },' TO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE '  "clientes": [' TO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           PERFORM 410000-GRAVAR-CLIENTES-JSON
           PERFORM 420000-GRAVAR-RODAPE-JSON
           .
       400000-FIM.
           EXIT.

      *----------------------------------------
       410000-GRAVAR-CLIENTES-JSON     SECTION.
      *----------------------------------------
      
           SET WS-IDX-CLI TO 1
           PERFORM UNTIL WS-IDX-CLI > WS-QT-CLI
               PERFORM 411000-GRAVAR-OBJETO-JSON
               SET WS-IDX-CLI UP BY 1
           END-PERFORM
           .
       410000-FIM.
           EXIT.

      *----------------------------------------
       411000-GRAVAR-OBJETO-JSON       SECTION.
      *----------------------------------------
      
           IF WS-IDX-CLI > 1
               MOVE ',' TO JSN-LINHA-JSN
               PERFORM 610000-GRAVAR-LINHA-JSON
           END-IF

           MOVE '    {' TO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE WS-CLI-CD(WS-IDX-CLI) TO JSN-TX-CD-CLI
           MOVE SPACES TO JSN-LINHA-JSN
           STRING '      "codigo": "' JSN-TX-CD-CLI '",'
               DELIMITED BY SIZE INTO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE SPACES TO JSN-LINHA-JSN
           STRING '      "nome": "'
               FUNCTION TRIM(WS-CLI-NM(WS-IDX-CLI)) '",'
               DELIMITED BY SIZE INTO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE WS-CLI-SDO(WS-IDX-CLI) TO JSN-SDO-JSON
           MOVE SPACES TO JSN-LINHA-JSN
           STRING '      "saldoFinal": "' JSN-SDO-JSON-X '",'
               DELIMITED BY SIZE INTO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE SPACES TO JSN-LINHA-JSN
           STRING '      "status": "' WS-CLI-ST(WS-IDX-CLI) '"'
               DELIMITED BY SIZE INTO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE '    }' TO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON
           .
       411000-FIM.
           EXIT.

      *----------------------------------------
       420000-GRAVAR-RODAPE-JSON       SECTION.
      *----------------------------------------

           MOVE '  ]' TO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON

           MOVE '}' TO JSN-LINHA-JSN
           PERFORM 610000-GRAVAR-LINHA-JSON
           .
       420000-FIM.
           EXIT.

      *----------------------------------------
       610000-GRAVAR-LINHA-JSON        SECTION.
      *----------------------------------------

           WRITE BHCFHJSN-REG FROM JSN-LINHA-JSN

           MOVE 'BHCFHJSN' TO WS-FS-ARQ
           MOVE 'WRITE'    TO WS-FS-OPER
           MOVE FS-JSN     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO GRAVAR BHCFHJSN' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           ELSE
               ADD 1 TO WS-TOT-JSN-GRV
           END-IF
           .
       610000-FIM.
           EXIT.

      *----------------------------------------
       500000-FINALIZAR                SECTION.
      *----------------------------------------

           CLOSE FD-ARQ-CLI
           MOVE 'BHCFHCLI' TO WS-FS-ARQ
           MOVE 'CLOSE'    TO WS-FS-OPER
           MOVE FS-CLI     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO FECHAR BHCFHCLI' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           CLOSE FD-ARQ-TRA
           MOVE 'BHCFHTRA' TO WS-FS-ARQ
           MOVE 'CLOSE'    TO WS-FS-OPER
           MOVE FS-TRA     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO FECHAR BHCFHTRA' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           CLOSE FD-ARQ-EXT
           MOVE 'BHCFHEXT' TO WS-FS-ARQ
           MOVE 'CLOSE'    TO WS-FS-OPER
           MOVE FS-EXT     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO FECHAR BHCFHEXT' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           CLOSE FD-ARQ-LOG
           MOVE 'BHCFHLOG' TO WS-FS-ARQ
           MOVE 'CLOSE'    TO WS-FS-OPER
           MOVE FS-LOG     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO FECHAR BHCFHLOG' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           CLOSE FD-ARQ-JSN
           MOVE 'BHCFHJSN' TO WS-FS-ARQ
           MOVE 'CLOSE'    TO WS-FS-OPER
           MOVE FS-JSN     TO WS-FS-VALOR
           PERFORM 810000-VALIDAR-FS
           IF FS-COM-ERRO
               MOVE 'ERRO AO FECHAR BHCFHJSN' TO WS-MSG-ERR
               PERFORM 800000-TRATAR-ERRO
           END-IF

           DISPLAY '----------------------------------------'
           DISPLAY 'TOTAL CLIENTES LIDOS       : ' WS-TOT-CLI-LIDOS
           DISPLAY 'TOTAL TRANSACOES LIDAS     : ' WS-TOT-TRA-LIDAS
           DISPLAY 'TOTAL TRANSACOES VALIDAS   : ' WS-TOT-TRA-VALIDAS
           DISPLAY 'TOTAL TRANSACOES REJEITADAS: ' WS-TOT-TRA-REJ
           DISPLAY 'TOTAL REGISTROS EXTRATO    : ' WS-TOT-EXT-GRV
           DISPLAY 'TOTAL REGISTROS LOG        : ' WS-TOT-LOG-GRV
           DISPLAY 'TOTAL LINHAS JSON          : ' WS-TOT-JSN-GRV
           DISPLAY '----------------------------------------'
           .
       500000-FIM.
           EXIT.

      *----------------------------------------
       800000-TRATAR-ERRO              SECTION.
      *----------------------------------------

           DISPLAY '**** ERRO TECNICO ****'
           DISPLAY 'PROGRAMA...: ' CTE-PGM
           DISPLAY 'ARQUIVO....: ' WS-FS-ARQ
           DISPLAY 'OPERACAO...: ' WS-FS-OPER
           DISPLAY 'FILE STATUS: ' WS-FS-VALOR ' - ' WS-FS-DESC
           DISPLAY 'MENSAGEM...: ' WS-MSG-ERR
           GOBACK
           .
       800000-FIM.
           EXIT.

      *----------------------------------------
       810000-VALIDAR-FS                SECTION.
      *----------------------------------------

           SET FS-SEM-ERRO              TO TRUE

           EVALUATE WS-FS-VALOR
               WHEN '00'
                   MOVE 'OPERACAO REALIZADA COM SUCESSO' TO WS-FS-DESC
               WHEN '10'
                   MOVE 'FIM DE ARQUIVO'                 TO WS-FS-DESC
               WHEN '35'
                   MOVE 'ARQUIVO NAO ENCONTRADO'          TO WS-FS-DESC
                   SET FS-COM-ERRO      TO TRUE
               WHEN '37'
                   MOVE 'MODO DE ABERTURA INCOMPATIVEL'   TO WS-FS-DESC
                   SET FS-COM-ERRO      TO TRUE
               WHEN '39'
                   MOVE 'ATRIBUTOS INCOMPATIVEIS'         TO WS-FS-DESC
                   SET FS-COM-ERRO      TO TRUE
               WHEN '41'
                   MOVE 'ARQUIVO JA ABERTO'               TO WS-FS-DESC
                   SET FS-COM-ERRO      TO TRUE
               WHEN '42'
                   MOVE 'ARQUIVO NAO ABERTO'              TO WS-FS-DESC
                   SET FS-COM-ERRO      TO TRUE
               WHEN '46'
                   MOVE 'READ SEM REGISTRO VALIDO'        TO WS-FS-DESC
                   SET FS-COM-ERRO      TO TRUE
               WHEN '47'
                   MOVE 'READ NAO PERMITIDO'              TO WS-FS-DESC
                   SET FS-COM-ERRO      TO TRUE
               WHEN '48'
                   MOVE 'WRITE NAO PERMITIDO'             TO WS-FS-DESC
                   SET FS-COM-ERRO      TO TRUE
               WHEN '49'
                   MOVE 'REWRITE/DELETE NAO PERMITIDO'    TO WS-FS-DESC
                   SET FS-COM-ERRO      TO TRUE
               WHEN OTHER
                   MOVE 'ERRO NAO MAPEADO'                TO WS-FS-DESC
                   SET FS-COM-ERRO      TO TRUE
           END-EVALUATE
           .
       810000-FIM.
           EXIT.

      ******************************************************************