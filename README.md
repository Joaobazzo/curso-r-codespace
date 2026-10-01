# Curso R Transportes: ambiente na nuvem (protótipo)

[![Abrir no GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/Joaobazzo/curso-r-codespace?quickstart=1)

Protótipo de um ambiente sem instalação para o curso
[Análise de Dados com R Aplicada ao Planejamento de Transportes](https://github.com/Joaobazzo/curso-r-transportes).
O aluno clica no botão acima e recebe um RStudio no navegador, com R, pacotes e dados prontos.

Por enquanto contém só o começo do Módulo 1. O conteúdo de referência continua sendo o site.

## Como funciona

| Arquivo | Papel |
|:--|:--|
| `.devcontainer/devcontainer.json` | Define a máquina: imagem `rocker/geospatial:4.6` (R + sf + terra + GDAL), RStudio Server na porta 8787, 4 núcleos / 16 GB |
| `.devcontainer/preparar.R` | Roda uma vez na criação: instala os pacotes do Módulo 1, baixa `dados_modulo1.zip` da Release do repositório do curso e configura o RStudio |
| `COMECE-AQUI.md` | Abre automaticamente para o aluno: como chegar ao RStudio |
| `modulo1/*.qmd` | Os capítulos, como cadernos executáveis bloco a bloco |
| `_quarto.yml` | Faz os blocos rodarem a partir da raiz do projeto, onde está `dados/` |

As versões ficam fixas porque a imagem do Rocker aponta o CRAN para um *snapshot* datado do
Posit Package Manager: todos os alunos recebem as mesmas versões de todos os pacotes.

## Para publicar

1. Crie o repositório `Joaobazzo/curso-r-codespace` no GitHub (público) e envie esta pasta.
2. Abra um Codespace pelo botão e confira se o RStudio sobe e se os blocos rodam.
3. **Recomendado:** em *Settings > Codespaces > Prebuild configurations*, crie um *prebuild*
   para a branch `main`. Sem ele, cada aluno espera alguns minutos na primeira abertura; com
   ele, o Codespace abre em segundos.

## Custos e limites

- Contas pessoais do GitHub têm uma cota gratuita mensal de horas de Codespaces. Uma máquina
  de 4 núcleos consome essa cota duas vezes mais rápido que uma de 2 núcleos, então para os
  Módulos 1 a 3 dá para reduzir `hostRequirements` para 2 núcleos / 8 GB.
- O Codespace para sozinho após 30 minutos sem uso e é apagado após 30 dias parado.

## Próximos módulos

- Módulos 2 e 3: `sf` e `terra` já vêm na imagem. Basta acrescentar os pacotes novos em
  `preparar.R` e o download de `dados_modulo2.zip` etc.
- Módulo 4 (`r5r`): descomentar a *feature* de Java 21 em `devcontainer.json`.
