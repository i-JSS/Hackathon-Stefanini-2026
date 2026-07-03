      **********************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCP0007
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 29/06/2026
      * OBJETIVO..: INFORMAR A DESCRICAO DO TIPO DE CONTA PELO CODIGO
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

       PROGRAM-ID. BHCP0007.

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

       01 GDA-CD-TIPO-CONTA            PIC 9(1) VALUE 2.

       01 GDA-TX-DESCRICAO             PIC X(20) VALUE SPACES.

      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------

      **********************
       PROCEDURE DIVISION.
      **********************

       2000-CLASSIFICAR.
           EVALUATE GDA-CD-TIPO-CONTA
               WHEN 1
                   MOVE 'CONTA CORRENTE'    TO GDA-TX-DESCRICAO
               WHEN 2
                   MOVE 'CONTA POUPANCA'    TO GDA-TX-DESCRICAO
               WHEN 3
                   MOVE 'CONTA SALARIO'     TO GDA-TX-DESCRICAO
               WHEN 4
                   MOVE 'CONTA EMPRESARIAL' TO GDA-TX-DESCRICAO
               WHEN OTHER
                   MOVE 'TIPO INVALIDO'     TO GDA-TX-DESCRICAO
           END-EVALUATE.

       3000-EXIBIR.
           DISPLAY 'CODIGO DO TIPO: ' GDA-CD-TIPO-CONTA.

           DISPLAY 'DESCRICAO: '      GDA-TX-DESCRICAO.

           GOBACK.
      **********************   