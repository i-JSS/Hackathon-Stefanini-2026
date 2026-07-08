      **********************
      * SIGLA.....: BHC – BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BCHP0002
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 26/06/2026
      * OBJETIVO..: REALIZAR UMA SOMA SIMPLES E EXIBIR O RESULTADO
      * EXECUCAO..: COBOL - BATCH
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL     DESCRICAO DA VERSAO
      * --- -------- --------------- -----------------------------------
      * 001 26.06.26 JOAO CARVALHO   IMPLANTACAO
      * ----------------------------------------------------------------
      **********************

      **********************
       IDENTIFICATION DIVISION.
      **********************

       PROGRAM-ID. BCHP0002.

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
       01  GDA-NR-1                    PIC 9(05).
       
       01  GDA-NR-2                    PIC 9(05).

       01  GDA-TX-RESULTADO            PIC 9(06).
       
      **********************
       PROCEDURE DIVISION.
      **********************
           MOVE 10 TO GDA-NR-1.

           MOVE 25 TO GDA-NR-2.

           ADD GDA-NR-1 GDA-NR-2 GIVING GDA-TX-RESULTADO.

           DISPLAY 'Primeiro numero: ' GDA-NR-1.

           DISPLAY 'Segundo numero : ' GDA-NR-2.

           DISPLAY 'Resultado      : ' GDA-TX-RESULTADO.

           GOBACK.
      **********************