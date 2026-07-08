      **********************
      * SIGLA.....: BHC – BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCP0016
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 03/07/2026
      * OBJETIVO..: LER BHCF012S E GERAR ARQUIVO JSON BHCF016J COM A
      *             LISTA DE PARTICIPANTES, MONTANDO O JSON DE FORMA
      *             MANUAL COM COMANDOS TRADICIONAIS DE COBOL
      * EXECUCAO..: COBOL - BATCH
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL     DESCRICAO DA VERSAO
      * --- -------- --------------- ----------------------------------
      * 001 03.07.26 JOAO CARVALHO   IMPLANTACAO
      * ----------------------------------------------------------------
      **********************

      **********************
       IDENTIFICATION DIVISION.
      **********************

       PROGRAM-ID. BHCP0016.

      **********************
       ENVIRONMENT DIVISION.
      **********************

      *----------------------------------------
       CONFIGURATION                   SECTION.
      *----------------------------------------
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT BHCF012S ASSIGN TO "BHCF012S.txt"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-BHCF012S.

           SELECT BHCF016J ASSIGN TO "BHCF016J.json"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS-BHCF016J.

      **********************
       DATA DIVISION.
      **********************

       FILE SECTION.
       FD  BHCF012S
           RECORDING MODE IS F
           RECORD CONTAINS 65 CHARACTERS.
       01  REG-BHCF012S.
           05  IN-CODIGO                  PIC X(005).
           05  IN-NOME                    PIC X(030).
           05  IN-UF                      PIC X(002).
           05  IN-TRILHA                  PIC X(010).
           05  IN-SITUACAO                PIC X(010).
           05  IN-DATA                    PIC X(008).

       FD  BHCF016J.
       01  REG-BHCF016J                   PIC X(200).

      *----------------------------------------
       WORKING-STORAGE                 SECTION.
      *----------------------------------------
       01  WS-FILE-STATUS.
           05  WS-FS-BHCF012S             PIC X(002) VALUE SPACES.
           05  WS-FS-BHCF016J             PIC X(002) VALUE SPACES.

       01  WS-CONSTANTES.
           05  WS-FS-OK                   PIC X(002) VALUE '00'.
           05  WS-FS-EOF                  PIC X(002) VALUE '10'.

       01  WS-JSON-LINE                   PIC X(120) VALUE SPACES.

      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------
       01  GDA-CONTROLES.
           05  GDA-FIM-ARQ                PIC X(001) VALUE 'N'.
               88  GDA-FIM-SIM                        VALUE 'S'.
               88  GDA-FIM-NAO                         VALUE 'N'.

       01  GDA-TOTALIZADORES.
           05  GDA-TOT-LIDOS              PIC 9(005) VALUE ZEROS.
           05  GDA-TOT-JSON               PIC 9(005) VALUE ZEROS.
           05  GDA-TOT-ERROS              PIC 9(005) VALUE ZEROS.

       01  GDA-DATA-HORA.
           05  GDA-CURRENT-DATE           PIC X(021).

      **********************
       PROCEDURE DIVISION.
      **********************

       000000-ROTINA-PRINCIPAL.
           PERFORM 100000-INICIALIZAR
           PERFORM 200000-ABRIR-ARQUIVOS
           PERFORM 300000-GRAVAR-CABECALHO-JSON
           PERFORM 400000-LER-ENTRADA
           PERFORM 500000-PROCESSAR-ARQUIVO UNTIL GDA-FIM-SIM
           PERFORM 800000-GRAVAR-RODAPE-JSON
           PERFORM 900000-FECHAR-ARQUIVOS
           PERFORM 910000-EXIBIR-TOTALIZADORES
           PERFORM 999999-FINALIZAR
           GOBACK.

       100000-INICIALIZAR.
           MOVE ZEROS TO GDA-TOT-LIDOS
                         GDA-TOT-JSON
                         GDA-TOT-ERROS
           SET GDA-FIM-NAO TO TRUE
           MOVE FUNCTION CURRENT-DATE TO GDA-CURRENT-DATE
           DISPLAY 'BHCP0016 - INICIO DO PROCESSAMENTO'
           DISPLAY 'DATA/HORA: ' GDA-CURRENT-DATE.

       200000-ABRIR-ARQUIVOS.
           OPEN INPUT BHCF012S
           IF WS-FS-BHCF012S = WS-FS-OK
               DISPLAY 'ARQUIVO BHCF012S ABERTO COM SUCESSO'
           ELSE
               DISPLAY 'ERRO OPEN INPUT BHCF012S FS=' WS-FS-BHCF012S
               ADD 1 TO GDA-TOT-ERROS
               SET GDA-FIM-SIM TO TRUE
           END-IF

           OPEN OUTPUT BHCF016J
           IF WS-FS-BHCF016J = WS-FS-OK
               DISPLAY 'ARQUIVO BHCF016J ABERTO COM SUCESSO'
           ELSE
               DISPLAY 'ERRO OPEN OUTPUT BHCF016J FS=' WS-FS-BHCF016J
               ADD 1 TO GDA-TOT-ERROS
               SET GDA-FIM-SIM TO TRUE
           END-IF.

       300000-GRAVAR-CABECALHO-JSON.
           MOVE SPACES TO WS-JSON-LINE
           STRING '{' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON

           MOVE SPACES TO WS-JSON-LINE
           STRING ' "participantes": [' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON.

       400000-LER-ENTRADA.
           READ BHCF012S
               AT END
                   SET GDA-FIM-SIM TO TRUE
               NOT AT END
                   ADD 1 TO GDA-TOT-LIDOS
           END-READ

           IF WS-FS-BHCF012S NOT = WS-FS-OK
               AND WS-FS-BHCF012S NOT = WS-FS-EOF
               DISPLAY 'ERRO READ BHCF012S FS=' WS-FS-BHCF012S
               ADD 1 TO GDA-TOT-ERROS
               SET GDA-FIM-SIM TO TRUE
           END-IF.

       500000-PROCESSAR-ARQUIVO.
           IF GDA-TOT-LIDOS > 1
               MOVE SPACES TO WS-JSON-LINE
               STRING ',' DELIMITED BY SIZE
                   INTO WS-JSON-LINE
               END-STRING
               PERFORM 520000-GRAVAR-LINHA-JSON
           END-IF
           PERFORM 510000-GRAVAR-OBJETO-JSON
           PERFORM 400000-LER-ENTRADA.

       510000-GRAVAR-OBJETO-JSON.
           MOVE SPACES TO WS-JSON-LINE
           STRING ' {' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON

           MOVE SPACES TO WS-JSON-LINE
           STRING '  "codigo": "' DELIMITED BY SIZE
               FUNCTION TRIM(IN-CODIGO) DELIMITED BY SIZE
               '",' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON

           MOVE SPACES TO WS-JSON-LINE
           STRING '  "nome": "' DELIMITED BY SIZE
               FUNCTION TRIM(IN-NOME) DELIMITED BY SIZE
               '",' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON

           MOVE SPACES TO WS-JSON-LINE
           STRING '  "uf": "' DELIMITED BY SIZE
               FUNCTION TRIM(IN-UF) DELIMITED BY SIZE
               '",' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON

           MOVE SPACES TO WS-JSON-LINE
           STRING '  "trilha": "' DELIMITED BY SIZE
               FUNCTION TRIM(IN-TRILHA) DELIMITED BY SIZE
               '",' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON

           MOVE SPACES TO WS-JSON-LINE
           STRING '  "situacao": "' DELIMITED BY SIZE
               FUNCTION TRIM(IN-SITUACAO) DELIMITED BY SIZE
               '",' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON

           MOVE SPACES TO WS-JSON-LINE
           STRING '  "data": "' DELIMITED BY SIZE
               FUNCTION TRIM(IN-DATA) DELIMITED BY SIZE
               '"' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON

           MOVE SPACES TO WS-JSON-LINE
           STRING ' }' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON

           ADD 1 TO GDA-TOT-JSON.

       520000-GRAVAR-LINHA-JSON.
           WRITE REG-BHCF016J FROM WS-JSON-LINE
           IF WS-FS-BHCF016J NOT = WS-FS-OK
               DISPLAY 'ERRO WRITE BHCF016J FS=' WS-FS-BHCF016J
               ADD 1 TO GDA-TOT-ERROS
           END-IF.

       800000-GRAVAR-RODAPE-JSON.
           MOVE SPACES TO WS-JSON-LINE
           STRING ' ]' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON

           MOVE SPACES TO WS-JSON-LINE
           STRING '}' DELIMITED BY SIZE
               INTO WS-JSON-LINE
           END-STRING
           PERFORM 520000-GRAVAR-LINHA-JSON.

       900000-FECHAR-ARQUIVOS.
           CLOSE BHCF012S
           CLOSE BHCF016J.

       910000-EXIBIR-TOTALIZADORES.
           DISPLAY 'TOTAL DE REGISTROS LIDOS......: ' GDA-TOT-LIDOS
           DISPLAY 'TOTAL DE OBJETOS JSON GERADOS.: ' GDA-TOT-JSON
           DISPLAY 'TOTAL DE ERROS DE ARQUIVO.....: ' GDA-TOT-ERROS.

       999999-FINALIZAR.
           MOVE FUNCTION CURRENT-DATE TO GDA-CURRENT-DATE
           DISPLAY 'BHCP0016 - FIM DO PROCESSAMENTO'
           DISPLAY 'DATA/HORA: ' GDA-CURRENT-DATE.

      **********************