# 📘 Miniguia de Estudos: Análise Multivariada

Este repositório foi desenvolvido como parte de um desafio prático da **DIO (Digital Innovation One)**. O objetivo é utilizar o **Google NotebookLM** como uma ferramenta de aprendizagem ativa, aplicando curadoria de fontes e engenharia de prompts para criar um caderno temático estruturado.

## 🎯 Contexto e Objetivos

* **Tema Escolhido:** Análise Multivariada (Redução de Dimensionalidade, Agrupamentos e Modelagem Latente)
* **Objetivo de Estudo:** Compreender os fundamentos estatísticos e geométricos das técnicas multivariadas para aplicar em projetos de ciência de dados e análise exploratória avançada.

## 📚 Curadoria de Fontes

Para alimentar a inteligência do NotebookLM, selecionei fontes de alta qualidade distribuídas em blocos temáticos:

1. [Aula 1: Introdução e Álgebra Linear](sources/Aula1_Introducao.pdf) - Base matemática e estatísticas descritivas.
2. [Aula 2: Componentes Principais (PCA)](sources/ACP_Introducao.pdf) - Técnicas de redução de dimensionalidade.
3. [Aula 3: Análise Fatorial (AF)](sources/Aula3_AF_Introducao.pdf) - Identificação de variáveis latentes e construtos.
4. [Aula 4: Cluster Analysis](sources/Aula4_Cluster.pdf) - Agrupamento hierárquico e não-hierárquico.
5. [Orientações de Relatório](sources/Relatorio_Analise%20Multivariada_Orientacoes.pdf) - Guia prático para aplicação das técnicas.

## 🧠 Engenharia de Prompts e "Cicatrizes" (Troubleshooting)

Nesta seção, documento o processo de "conversa" com a IA para refinar o conhecimento. Consulte a pasta [prompts/](prompts/prompts_notebooklm.md) para ver o toolkit completo.

### Prompts Testados

* **Prompt 1 (Exploratório):** "Explique Análise Multivariada como se eu fosse um iniciante."
  * *Resultado:* Resposta muito genérica, focando apenas em 'muitas variáveis'.
* **Prompt 2 (Refinado):** "Com base na fonte [ACP_Introducao], explique como os autovetores determinam a direção das componentes principais."
  * *Resultado:* Muito mais técnico e alinhado com a base matemática necessária.

### Desafios Encontrados
>
> *Dica: Inicialmente, o NotebookLM teve dificuldade em distinguir entre modelos de dependência e interdependência. Tive que fornecer o roteiro da disciplina (Aula 1) como fonte âncora para que ele respeitasse a taxonomia correta do curso.*

## 📝 Miniguia de Estudo (Entrega Final)

### 1. Resumo Estruturado

A Análise Multivariada é um pilar da ciência de dados que permite a exploração de fenômenos complexos onde múltiplas variáveis interagem simultaneamente. O estudo foi consolidado nos seguintes tópicos principais:

* **Fundamentos e Álgebra Linear:** Diferente da análise univariada ou bivariada, a análise multivariada lida com vetores de observações. O domínio de matrizes (covariância e correlação), autovalores e autovetores é a base geométrica para essas técnicas.
* **Análise de Componentes Principais (PCA):** Técnica de redução de dimensionalidade que transforma variáveis correlacionadas em um novo conjunto menor de variáveis ortogonais. Utiliza-se o *Scree Plot* ou o Critério de Kaiser para decisão do número de componentes.
* **Análise Fatorial (AF):** Foca em modelar a variância comum através de variáveis latentes (fatores). Essencial para validar estruturas teóricas (Confirmatória) ou descobrir padrões (Exploratória).
* **Análise de Agrupamentos (Cluster Analysis):** Segmentação de dados em grupos homogêneos. Inclui métodos Hierárquicos (dendrogramas), Partição (K-Means/K-Medoids) e Baseados em Densidade (DBSCAN).
* **Distâncias:** O motor por trás das técnicas. Destaque para a **Distância de Mahalanobis**, que corrige a escala e considera a correlação entre variáveis.

### 2. Glossário de Conceitos

* **Autovalores e Autovetores:** Definem a direção e a magnitude da variância explicada no PCA.
* **KMO (Kaiser-Meyer-Olkin):** Estatística de 0 a 1 que indica a adequação dos dados para Análise Fatorial.
* **Dendrograma:** Diagrama em árvore que ilustra as fusões em agrupamentos hierárquicos.
* **Coeficiente de Silhueta:** Métrica que avalia a qualidade da separação e coesão dos clusters.

### 3. Toolkit de Prompts Reutilizáveis

Estes prompts podem ser usados para revisar o conteúdo futuramente:

* "Gere 5 perguntas de múltipla escolha sobre Análise Fatorial para testar meu conhecimento."

* "Baseado nas fontes, crie um passo a passo para decidir entre K-Means e K-Medoids."

## 🛠️ Tecnologias Utilizadas

* **Google NotebookLM** (IA para síntese de conhecimento)
* **Markdown** (Documentação)
* **GitHub** (Versionamento e Portfólio)
* **Linguagem R** (Scripts de prática estatística)

*Este guia foi gerado para fins de estudo e prática de IA Cognitiva.*
