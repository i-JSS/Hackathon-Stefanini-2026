      **********************
      * SIGLA.....: BHC – BOOTCAMP HACKATHON COBOL
      * PROGRAMA..: BCHP0004
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 29/06/2026
      * OBJETIVO..: CADASTRAR E EXIBIR UM RESUMO CADASTRAL DE CLIENTE
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

       PROGRAM-ID. BCHP0004.

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
       
       01  GDA-CD-CLIENTE              PIC 9(4).
       
       01  GDA-NM-CLIENTE              PIC X(30).
       
       01  GDA-NR-AGENCIA              PIC 9(4).
       
       01  GDA-NR-CONTA                PIC 9(6).
       
       01  GDA-VL-SALDO                PIC 9(4).

      *----------------------------------------
       LOCAL-STORAGE                   SECTION.
      *----------------------------------------

      **********************
       PROCEDURE DIVISION.
      **********************
           
           MOVE 1001          TO GDA-CD-CLIENTE.
           
           MOVE 'JOAO SILVA'  TO GDA-NM-CLIENTE.
           
           MOVE 1234          TO GDA-NR-AGENCIA.
           
           MOVE 987654        TO GDA-NR-CONTA.
           
           MOVE 1500          TO GDA-VL-SALDO.

           DISPLAY 'CADASTRO DE CLIENTE'.
           
           DISPLAY 'CODIGO: ' GDA-CD-CLIENTE.
           
           DISPLAY 'NOME: ' GDA-NM-CLIENTE.
           
           DISPLAY 'AGENCIA: ' GDA-NR-AGENCIA.
           
           DISPLAY 'CONTA: ' GDA-NR-CONTA.
           
           DISPLAY 'SALDO INICIAL: ' GDA-VL-SALDO.

           GOBACK.
      **********************