      ******************************************************************
      * SIGLA.....: BHC - BOOTCAMP HACKATHON COBOL
      * COPYBOOK..: BHCJSONX
      * ANALISTA..: JOSE HILARIO VERAS LEITE JUNIOR
      * AUTOR.....: JOAO ANTONIO GINUINO CARVALHO
      * DATA......: 05/07/2026
      * OBJETIVO..: AREA AUXILIAR DE MONTAGEM MANUAL DO JSON
      * USADO EM..: BHCPH001 (WORKING-STORAGE)
      * OBS.......: BUFFERS DE STRING E CONTADORES USADOS NAS
      *             SECTIONS 400000/410000/411000/420000 (GERACAO JSON)
      * ----------------------------------------------------------------
      * VRS DATA     RESPONSAVEL              DESCRICAO DA VERSAO
      * --- -------- ------------------------ -----------------------
      * 001 05.07.26 JOAO ANTONIO G. CARVALHO IMPLANTACAO
      * ----------------------------------------------------------------
      ******************************************************************

           05  JSN-TX-CD-CLI               PIC X(005).
           05  JSN-SDO-JSON                PIC 9(009)V99.
           05  JSN-SDO-JSON-X         REDEFINES JSN-SDO-JSON PIC X(011).
           05  JSN-TX-QT                   PIC ZZZZ9.
           05  JSN-LINHA-JSN               PIC X(200).