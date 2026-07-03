      **********************
      * SIGLA.....: BHC – BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BHCP0001
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 25/06/2026
      * OBJETIVO..: PRINTAR HELO, COBOL
      * EXECUCAO..: COBOL - BATCH
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL     DESCRICAO DA VERSAO
      * --- -------- --------------- -----------------------------------
      * 001 25.06.26 JOAO CARVALHO   IMPLANTACAO
      * ----------------------------------------------------------------
      **********************
 
      **********************
       IDENTIFICATION DIVISION.
      **********************
 
       PROGRAM-ID. BHCP0001.
 
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
 
      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------
 
      **********************
       PROCEDURE DIVISION.
      **********************

           DISPLAY 'HELO, COBOL!'.
 
           GOBACK.
      **********************