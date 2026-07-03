      **********************
      * SIGLA.....: BHC – BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BCHP0003
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 29/06/2026
      * OBJETIVO..: EXIBIR NOME DO ALUNO, NOME DO CURSO E MENSAGEM FIXA
      * EXECUCAO..: COBOL - BATCH
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL     DESCRICAO DA VERSAO
      * --- -------- --------------- ----------------------------------
      * 001 29.06.26 JOAO CARVALHO        IMPLANTACAO
      * ----------------------------------------------------------------
      **********************

      **********************
       IDENTIFICATION DIVISION.
      **********************

       PROGRAM-ID. BCHP0003.

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

       01  GDA-NM-ALUNO   PIC X(80) VALUE 'JOAO ANTONIO GINUINO CARVALHO
      - ' DA SILVA PEREIRA DOS SANTOS NASCIMENTO TESTE EXEMPLO'.

       01  GDA-NM-CURSO                PIC X(30) VALUE 'BOOTCAMP COBOL'.

      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------

      **********************
       PROCEDURE DIVISION.
      **********************
           DISPLAY 'ALUNO: ' FUNCTION TRIM(GDA-NM-ALUNO).

           DISPLAY 'CURSO: ' FUNCTION TRIM(GDA-NM-CURSO).

           DISPLAY 'MEU PROGRAMA COBOL'.

           GOBACK.
      **********************