      **********************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCS0014
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 01/07/2026
      * OBJETIVO..: VALIDAR OS CAMPOS OBRIGATORIOS DE UM PARTICIPANTE
      *             RECEBIDO POR PARAMETRO E RETORNAR STATUS, CODIGO
      *             DE ERRO E MENSAGEM
      * EXECUCAO..: COBOL - SUBPROGRAMA (CALLED)
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL     DESCRICAO DA VERSAO
      * --- -------- --------------- ----------------------------------
      * 001 01.07.26 JOAO CARVALHO   IMPLANTACAO
      * ----------------------------------------------------------------
      **********************

      **********************
       IDENTIFICATION DIVISION.
      **********************

       PROGRAM-ID. BHCS0014.

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
       01  WS-CONSTANTES.
           05  WS-STATUS-VALIDO           PIC X(001) VALUE 'V'.
           05  WS-STATUS-REJEITADO        PIC X(001) VALUE 'R'.

      *----------------------------------------
       LINKAGE                         SECTION.
      *----------------------------------------
       01  LK-AREA-COMUNICACAO.
           05  LK-COM-CODIGO              PIC 9(005).
           05  LK-COM-NOME                PIC X(030).
           05  LK-COM-UF                  PIC X(002).
           05  LK-COM-TRILHA              PIC X(010).
           05  LK-COM-SITUACAO            PIC X(010).
           05  LK-COM-DATA                PIC 9(008).
           05  LK-COM-STATUS              PIC X(001).
           05  LK-COM-COD-ERRO            PIC X(004).
           05  LK-COM-MENSAGEM            PIC X(040).

      **********************
       PROCEDURE DIVISION USING LK-AREA-COMUNICACAO.
      **********************

       000000-ROTINA-PRINCIPAL.
           PERFORM 100000-INICIALIZAR
           PERFORM 200000-VALIDAR
           GOBACK.

       100000-INICIALIZAR.
           MOVE WS-STATUS-VALIDO TO LK-COM-STATUS
           MOVE '0000' TO LK-COM-COD-ERRO
           MOVE 'REGISTRO VALIDO' TO LK-COM-MENSAGEM.

       200000-VALIDAR.
           IF LK-COM-CODIGO = ZEROS
               MOVE WS-STATUS-REJEITADO TO LK-COM-STATUS
               MOVE 'E001' TO LK-COM-COD-ERRO
               MOVE 'CODIGO NAO INFORMADO' TO LK-COM-MENSAGEM
           ELSE
               IF LK-COM-NOME = SPACES
                   MOVE WS-STATUS-REJEITADO TO LK-COM-STATUS
                   MOVE 'E002' TO LK-COM-COD-ERRO
                   MOVE 'NOME NAO INFORMADO' TO LK-COM-MENSAGEM
               ELSE
                   IF LK-COM-UF = SPACES
                       MOVE WS-STATUS-REJEITADO TO LK-COM-STATUS
                       MOVE 'E003' TO LK-COM-COD-ERRO
                       MOVE 'UF NAO INFORMADA' TO LK-COM-MENSAGEM
                   ELSE
                       IF LK-COM-TRILHA = SPACES
                           MOVE WS-STATUS-REJEITADO TO LK-COM-STATUS
                           MOVE 'E004' TO LK-COM-COD-ERRO
                           MOVE 'TRILHA NAO INFORMADA'
                               TO LK-COM-MENSAGEM
                       ELSE
                           IF LK-COM-SITUACAO = SPACES
                               MOVE WS-STATUS-REJEITADO TO LK-COM-STATUS
                               MOVE 'E005' TO LK-COM-COD-ERRO
                               MOVE 'SITUACAO NAO INFORMADA'
                                   TO LK-COM-MENSAGEM
                           ELSE
                               IF LK-COM-DATA = ZEROS
                                   MOVE WS-STATUS-REJEITADO
                                       TO LK-COM-STATUS
                                   MOVE 'E006' TO LK-COM-COD-ERRO
                                   MOVE 'DATA NAO INFORMADA'
                                       TO LK-COM-MENSAGEM
                               END-IF
                           END-IF
                       END-IF
                   END-IF
               END-IF
           END-IF.
           
      **********************