<div align="center">

# Hackathon Stefanini 2026 - Bootcamp COBOL

**Coleção de programas COBOL desenvolvidos durante o Bootcamp Hackathon COBOL Stefanini 2026**

[![Language](https://img.shields.io/badge/language-COBOL-1a5276?style=for-the-badge&logo=cobol&logoColor=white)](https://github.com/i-JSS/Hackathon-Stefanini-2026)
[![Compiler](https://img.shields.io/badge/compiler-GnuCOBOL-2e86c1?style=for-the-badge)](https://gnucobol.sourceforge.io/)
[![Format](https://img.shields.io/badge/format-FIXED-8e44ad?style=for-the-badge)](#-padrão-de-codificação)
[![Programs](https://img.shields.io/badge/programas-16-27ae60?style=for-the-badge)](#-mapa-dos-programas)
[![License](https://img.shields.io/badge/license-MIT-f39c12?style=for-the-badge)](LICENSE)

</div>

---

## Sobre o projeto

Este repositório reúne os exercícios práticos do **Bootcamp Hackathon COBOL Stefanini 2026**,
organizados por aula. O objetivo é consolidar, de forma progressiva, os fundamentos da
linguagem COBOL, do `DISPLAY` mais simples até um **mini sistema batch completo**, com
geração de arquivo, validação de dados, sub-rotinas (`CALL`) e exportação para JSON.

Todos os programas seguem **um único padrão de escrita** (formato fixo, cabeçalho
padronizado, nomenclatura de variáveis e encerramento por `GOBACK`), definido e aplicado
de forma consistente ao longo de todas as aulas.

---

## Estrutura do repositório

```text
Hackathon-Stefanini-2026/
├── Aulas/
│   ├── Aula-1/                 # Fundamentos: DISPLAY, MOVE, ADD
│   │   ├── BHCP0001.cbl
│   │   └── BHCP0002.cbl
│   │
│   ├── Aula-2/                 # Estruturas de decisão e cadastros simples
│   │   ├── BHCP0003.cbl
│   │   ├── BHCP0004.cbl
│   │   ├── BHCP0005.cbl
│   │   ├── BHCP0006.cbl
│   │   ├── BHCP0007.cbl
│   │   └── BHCP0008.cbl
│   │
│   ├── Aula-3/                 # Arrays (OCCURS / OCCURS DEPENDING ON)
│   │   ├── BHCP0009.cbl
│   │   ├── BHCP0010.cbl
│   │   └── BHCP0011.cbl
│   │
│   ├── Aula-4/                 # Mini sistema batch: arquivos + sub-programas
│   │   ├── BHCP0012.cbl        # Geração do arquivo mestre BHCF012S
│   │   ├── BHCP0013.cbl        # Leitura + validação inline + log
│   │   ├── BHCP0014.cbl        # Leitura + validação via CALL (BHCS0014)
│   │   ├── BHCS0014.cbl        # Sub-programa de validação (LINKAGE SECTION)
│   │   ├── BHCF012S.txt        # Massa de entrada (participantes)
│   │   ├── BHCF013L.txt        # Log de rejeições (saída do BHCP0013)
│   │   ├── BHCF014S.txt        # Participantes válidos (saída do BHCP0014)
│   │   └── BHCF014L.txt        # Participantes rejeitados (saída do BHCP0014)
│   │
│   ├── Aula-5/                 # Processamento de lançamentos e totalizadores
│   │   ├── BHCP0015.cbl
│   │   ├── BHCF015E              # Entrada de lançamentos
│   │   ├── BHCF015S              # Saída processada
│   │   └── BHCF015L              # Log de lançamentos
│   │
│   └── Aula-6/                 # Integração com formatos modernos
│       ├── BHCP0016.cbl        # Geração manual de JSON a partir do BHCF012S
│       ├── BHCF012S.txt        # Reaproveita a massa gerada na Aula 4
│       └── BHCF016J.json       # Saída: JSON de participantes
│
└── LICENSE
```


---

## Padrão de codificação

Todos os programas seguem o **padrão fixo do bootcamp**, aplicado uniformemente do
`BHCP0001` ao `BHCP0016`:

- **Formato fixo** (não `-free`): `DIVISION`/`SECTION` na Área A (colunas 8–11), sentenças
  na Área B (colunas 12–72).
- **Cabeçalho padronizado** em todo `.cbl`, com `SIGLA`, `PROGRAMA`, `ANALISTA`, `AUTOR`,
  `DATA`, `OBJETIVO`, `EXECUCAO` e histórico de versões.
- **`PROGRAM-ID`** com até 8 caracteres, igual ao nome do arquivo (`BHCPxxxx` para
  programas, `BHCSxxxx` para sub-programas).
- **Encerramento sempre com `GOBACK`** — o uso de `STOP RUN` é proibido no bootcamp.
- **`DECIMAL-POINT IS COMMA`** fixado na `CONFIGURATION SECTION`.
- **Convenção de nomes**: `GDA-` (áreas de guarda/globais), `LK-` (LINKAGE SECTION),
  `1000-`/`2000-`/`3000-`/`9000-` (parágrafos de inicialização, processamento,
  finalização e tratamento de erro).

---

## Como compilar e executar

Pré-requisito: [GnuCOBOL](https://gnucobol.sourceforge.io/) instalado (`cobc`).

```bash
# Exemplo com o programa da Aula 6
cd Aulas/Aula-6
cobc -x -o BHCP0016 BHCP0016.cbl
./BHCP0016
```

Para programas com sub-programa (`CALL`), compile o sub-programa como módulo antes do
principal:

```bash
# Exemplo: Aula 4 — BHCP0014 chama BHCS0014
cd Aulas/Aula-4
cobc -m BHCS0014.cbl          # gera BHCS0014.so / .dll (módulo dinâmico)
cobc -x -o BHCP0014 BHCP0014.cbl
./BHCP0014
```
---

## Créditos

| Papel | Nome |
|---|---|
| Analista | José Hilario Veras Leite Junior |
| Autor / Desenvolvedor | João Antonio Ginuino Carvalho |

---

<div align="center">

**Bootcamp Hackathon COBOL Stefanini 2026**

</div>
