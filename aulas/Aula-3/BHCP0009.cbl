      **********************
      * SIGLA.....: BHC – BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCP0009
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 30/06/2026
      * OBJETIVO..: CADASTRAR FUNCIONARIOS EM ARRAY FIXO, CLASSIFICAR
      *             PELO SALARIO E EMITIR RELATORIO RESUMIDO.
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

       PROGRAM-ID. BHCP0009.

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

       01  GDA-TAB-FUNCIONARIOS.
           05  GDA-FUNCIONARIO        OCCURS 10 TIMES
                                       INDEXED BY GDA-IDX.
               10  GDA-FUNC-COD       PIC 9(04).
               10  GDA-FUNC-NOME      PIC X(15).
               10  GDA-FUNC-SALARIO   PIC 9(05)V99.
               10  FILLER             PIC X(05).

       01  GDA-DADOS-CARGA.
           05  FILLER.
               10  FILLER             PIC 9(04) VALUE 1001.
               10  FILLER             PIC X(15) VALUE 'JOAO'.
               10  FILLER             PIC 9(05)V99 VALUE 3200.
           05  FILLER.
               10  FILLER             PIC 9(04) VALUE 1002.
               10  FILLER             PIC X(15) VALUE 'MARIA'.
               10  FILLER             PIC 9(05)V99 VALUE 5000.
           05  FILLER.
               10  FILLER             PIC 9(04) VALUE 1003.
               10  FILLER             PIC X(15) VALUE 'CARLOS'.
               10  FILLER             PIC 9(05)V99 VALUE 8200.
           05  FILLER.
               10  FILLER             PIC 9(04) VALUE 1004.
               10  FILLER             PIC X(15) VALUE 'ANA'.
               10  FILLER             PIC 9(05)V99 VALUE 4100.
           05  FILLER.
               10  FILLER             PIC 9(04) VALUE 1005.
               10  FILLER             PIC X(15) VALUE 'PEDRO'.
               10  FILLER             PIC 9(05)V99 VALUE 5100.
           05  FILLER.
               10  FILLER             PIC 9(04) VALUE 1006.
               10  FILLER             PIC X(15) VALUE 'LUCAS'.
               10  FILLER             PIC 9(05)V99 VALUE 2800.
           05  FILLER.
               10  FILLER             PIC 9(04) VALUE 1007.
               10  FILLER             PIC X(15) VALUE 'FERNANDA'.
               10  FILLER             PIC 9(05)V99 VALUE 5000.
           05  FILLER.
               10  FILLER             PIC 9(04) VALUE 1008.
               10  FILLER             PIC X(15) VALUE 'PAULO'.
               10  FILLER             PIC 9(05)V99 VALUE 9100.
           05  FILLER.
               10  FILLER             PIC 9(04) VALUE 1009.
               10  FILLER             PIC X(15) VALUE 'MARTA'.
               10  FILLER             PIC 9(05)V99 VALUE 3900.
           05  FILLER.
               10  FILLER             PIC 9(04) VALUE 1010.
               10  FILLER             PIC X(15) VALUE 'JULIANA'.
               10  FILLER             PIC 9(05)V99 VALUE 6000.

       01  GDA-DADOS-CARGA-REDEF REDEFINES GDA-DADOS-CARGA.
           05  GDA-CARGA-LINHA        OCCURS 10 TIMES.
               10  GDA-CARGA-COD      PIC 9(04).
               10  GDA-CARGA-NOME     PIC X(15).
               10  GDA-CARGA-SALARIO  PIC 9(05)V99.

       01  GDA-SALARIO-EDICAO          PIC ZZZZ9,99.

       01  GDA-CLASSIFICACAO          PIC X(07).

       01  GDA-LINHA-RELATORIO        PIC X(60).

       01  GDA-CONTADORES.
           05  GDA-QTDE-FUNC          PIC 9(02) VALUE 10.

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
           PERFORM 1100-CADASTRAR-FUNCIONARIOS.

           PERFORM 2000-PROCESSAR-RELATORIO.
           
           PERFORM 3000-FINALIZAR.

           EXIT.

      *----------------------------------------------------------
       1100-CADASTRAR-FUNCIONARIOS         SECTION.
      *----------------------------------------------------------

       1100-INICIO.
           PERFORM VARYING GDA-IDX FROM 1 BY 1
               UNTIL GDA-IDX > GDA-QTDE-FUNC

               MOVE GDA-CARGA-COD (GDA-IDX)
                 TO GDA-FUNC-COD (GDA-IDX)

               MOVE GDA-CARGA-NOME (GDA-IDX)
                 TO GDA-FUNC-NOME (GDA-IDX)

               MOVE GDA-CARGA-SALARIO (GDA-IDX)
                 TO GDA-FUNC-SALARIO (GDA-IDX)
           END-PERFORM.

       1100-FIM.
           EXIT.

      *----------------------------------------------------------
       2000-PROCESSAR-RELATORIO            SECTION.
      *----------------------------------------------------------

       2000-INICIO.
           DISPLAY 'RELATORIO DE FUNCIONARIOS'.
           DISPLAY ' '.

           PERFORM VARYING GDA-IDX FROM 1 BY 1
               UNTIL GDA-IDX > GDA-QTDE-FUNC
               PERFORM 2100-CLASSIFICAR-SALARIO
               PERFORM 2200-MONTAR-LINHA
               PERFORM 2300-EXIBIR-LINHA
           END-PERFORM.

       2000-FIM.
           EXIT.

      *----------------------------------------------------------
       2100-CLASSIFICAR-SALARIO            SECTION.
      *----------------------------------------------------------

       2100-INICIO.
      *    REGRAS DE NEGOCIO:
      *    SALARIO > 5000  -> ALTO
      *    SALARIO = 5000  -> LIMITE
      *    SALARIO < 5000  -> NORMAL
           IF GDA-FUNC-SALARIO (GDA-IDX) > 5000
               MOVE 'ALTO'    TO GDA-CLASSIFICACAO
           ELSE
               IF GDA-FUNC-SALARIO (GDA-IDX) = 5000
                   MOVE 'LIMITE'  TO GDA-CLASSIFICACAO
               ELSE
                   IF GDA-FUNC-SALARIO (GDA-IDX) < 5000
                       MOVE 'NORMAL'  TO GDA-CLASSIFICACAO
                   END-IF
               END-IF
           END-IF.

       2100-FIM.
           EXIT.

      *----------------------------------------------------------
       2200-MONTAR-LINHA                   SECTION.
      *----------------------------------------------------------

       2200-INICIO.
           MOVE GDA-FUNC-SALARIO (GDA-IDX) TO GDA-SALARIO-EDICAO

           MOVE SPACES TO GDA-LINHA-RELATORIO

           STRING
               GDA-FUNC-COD (GDA-IDX)             DELIMITED BY SIZE
               ' '                                DELIMITED BY SIZE
               GDA-FUNC-NOME (GDA-IDX)            DELIMITED BY SPACE
               ' '                                DELIMITED BY SIZE
               FUNCTION TRIM (GDA-SALARIO-EDICAO) DELIMITED BY SIZE
               ' '                                DELIMITED BY SIZE
               GDA-CLASSIFICACAO                  DELIMITED BY SPACE
               INTO GDA-LINHA-RELATORIO
           END-STRING.

       2200-FIM.
           EXIT.

      *----------------------------------------------------------
       2300-EXIBIR-LINHA                   SECTION.
      *----------------------------------------------------------

       2300-INICIO.
           DISPLAY GDA-LINHA-RELATORIO.

       2300-FIM.
           EXIT.

      *----------------------------------------------------------
       3000-FINALIZAR                      SECTION.
      *----------------------------------------------------------

       3000-INICIO.
           DISPLAY 'FIM DO RELATORIO DE FUNCIONARIOS'.

       3000-FIM.
           EXIT.

           GOBACK.
      **********************