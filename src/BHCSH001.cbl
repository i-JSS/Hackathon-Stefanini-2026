      ******************************************************************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCSH001
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 05/07/2026
      * OBJETIVO..: VALIDAR TRANSACAO FINANCEIRA (SUBPROGRAMA)
      * EXECUCAO..: COBOL - CALL (CHAMADO POR BHCPH001)
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL              DESCRICAO DA VERSAO
      * --- -------- ------------------------ -----------------------
      * 001 05.07.26 JOAO ANTONIO G. CARVALHO IMPLANTACAO
      * ----------------------------------------------------------------
      ******************************************************************

      ******************************************************************
       IDENTIFICATION DIVISION.
      ******************************************************************
      
       PROGRAM-ID. BHCSH001.
      
      ******************************************************************
       ENVIRONMENT DIVISION.
      ******************************************************************
      
      *----------------------------------------
       CONFIGURATION                   SECTION.
      *----------------------------------------
      
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

      ******************************************************************
       DATA DIVISION.
      ******************************************************************

      *----------------------------------------
       WORKING-STORAGE                 SECTION.
      *----------------------------------------

       77  CTE-PGM                      PIC X(008) VALUE 'BHCSH001'.
       77  WS-IDX-CLI                   PIC 9(003) VALUE ZEROS.

       77  GDA-ACHOU-CLI                PIC X(001) VALUE 'N'.
           88 ACHOU-CLI                            VALUE 'S'.
           88 NAO-ACHOU-CLI                        VALUE 'N'.

      *----------------------------------------
       LINKAGE                         SECTION.
      *----------------------------------------

       01  LK-AREA-VALID.
           COPY BHCPARAM.

      ******************************************************************
       PROCEDURE DIVISION USING LK-AREA-VALID.
      ******************************************************************

           PERFORM 100000-INICIALIZAR
           PERFORM 200000-VALIDAR-CLIENTE

           IF GDA-CD-RETORNO = 00
               PERFORM 300000-VALIDAR-ATIVO
           END-IF

           IF GDA-CD-RETORNO = 00
               PERFORM 400000-VALIDAR-TIPO
           END-IF

           IF GDA-CD-RETORNO = 00
               PERFORM 500000-VALIDAR-VALOR
           END-IF

           IF GDA-CD-RETORNO = 00
               PERFORM 600000-VALIDAR-SALDO
           END-IF
           .

           GOBACK.

      *----------------------------------------
       100000-INICIALIZAR              SECTION.
      *----------------------------------------

           MOVE 00                     TO GDA-CD-RETORNO
           MOVE SPACES                 TO GDA-MSG-ERRO
           MOVE ZEROS                  TO GDA-IDX-CLI
           SET NAO-ACHOU-CLI           TO TRUE
           .
       100000-FIM.
           EXIT.

      *----------------------------------------
       200000-VALIDAR-CLIENTE          SECTION.
      *----------------------------------------

           PERFORM VARYING WS-IDX-CLI FROM 1 BY 1
               UNTIL WS-IDX-CLI > GDA-QT-CLI OR ACHOU-CLI
               IF GDA-CLI-CD(WS-IDX-CLI) = GDA-TRA-CD-CLI
                   SET ACHOU-CLI       TO TRUE
                   MOVE WS-IDX-CLI     TO GDA-IDX-CLI
               END-IF
           END-PERFORM

           IF NAO-ACHOU-CLI
               MOVE 01                 TO GDA-CD-RETORNO
               MOVE 'CLIENTE NAO ENCONTRADO' TO GDA-MSG-ERRO
           END-IF
           .
       200000-FIM.
           EXIT.

      *----------------------------------------
       300000-VALIDAR-ATIVO            SECTION.
      *----------------------------------------

           EVALUATE GDA-CLI-ST(GDA-IDX-CLI)
               WHEN 'I'
                   MOVE 02              TO GDA-CD-RETORNO
                   MOVE 'CLIENTE INATIVO' TO GDA-MSG-ERRO
               WHEN 'B'
                   MOVE 03              TO GDA-CD-RETORNO
                   MOVE 'CLIENTE BLOQUEADO' TO GDA-MSG-ERRO
               WHEN OTHER
                   CONTINUE
           END-EVALUATE
           .
       300000-FIM.
           EXIT.

      *----------------------------------------
       400000-VALIDAR-TIPO             SECTION.
      *----------------------------------------

           EVALUATE GDA-TRA-TP
               WHEN 'D'
                   CONTINUE
               WHEN 'S'
                   CONTINUE
               WHEN 'P'
                   CONTINUE
               WHEN OTHER
                   MOVE 04              TO GDA-CD-RETORNO
                   MOVE 'TIPO DE TRANSACAO INVALIDO' TO GDA-MSG-ERRO
           END-EVALUATE
           .
       400000-FIM.
           EXIT.

      *----------------------------------------
       500000-VALIDAR-VALOR            SECTION.
      *----------------------------------------

           IF GDA-TRA-VLR = ZEROS
               MOVE 05                 TO GDA-CD-RETORNO
               MOVE 'VALOR INVALIDO'   TO GDA-MSG-ERRO
           END-IF
           .
       500000-FIM.
           EXIT.

      *----------------------------------------
       600000-VALIDAR-SALDO            SECTION.
      *----------------------------------------
      
           IF GDA-TRA-TP = 'S' OR GDA-TRA-TP = 'P'
               IF GDA-TRA-VLR > GDA-CLI-SDO(GDA-IDX-CLI)
                   MOVE 06              TO GDA-CD-RETORNO
                   MOVE 'SALDO INSUFICIENTE' TO GDA-MSG-ERRO
               END-IF
           END-IF
           .
       600000-FIM.
           EXIT.
           
      ******************************************************************