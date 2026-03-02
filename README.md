
# 📊 Customer Analytics Modern Pipeline  
### BigQuery + dbt | Analytics Engineering Project

## 📌 Overview

Este projeto simula a construção de um pipeline moderno de Analytics Engineering para análise integrada de:

- Clientes
- Pedidos
- NPS (Net Promoter Score)
- Receita

A arquitetura foi construída utilizando **dbt + BigQuery**, seguindo boas práticas de modelagem em camadas (raw → staging → marts → metrics).

O objetivo é demonstrar a estruturação de um Data Warehouse orientado a Customer Analytics, conectando experiência do cliente (NPS) a métricas financeiras como receita e comportamento de compra.

---

## 🏗️ Arquitetura do Projeto


---

## 📂 Estrutura das Camadas

### 🔹 Raw (Seeds)
Simulação de fontes de dados:
- `raw_customers`
- `raw_orders`
- `raw_nps_responses`

---

### 🔹 Staging (Views)

Camada de padronização técnica:
- Cast de tipos
- Normalização de texto
- Preparação para modelagem

Models:
- `stg_customers`
- `stg_orders`
- `stg_nps_responses`

---

### 🔹 Marts – Core (Modelagem Dimensional)

#### 🧍 `dim_customers`
- 1 linha por cliente
- Primeira e última compra
- Receita total
- Total de pedidos
- Flag de cliente ativo (últimos 60 dias)

#### 🛒 `fact_orders`
- 1 linha por pedido entregue
- Receita bruta e líquida
- Canal
- Mês do pedido
- Tenure do cliente

#### ⭐ `fact_nps`
- 1 linha por resposta NPS
- Conexão com pedido e cliente
- Receita associada
- Canal da pesquisa

---

### 🔹 Metrics Layer

#### 📈 `nps_monthly`
- NPS por mês e canal
- Promoters, Neutrals, Detractors
- Fórmula:NPS = (Promoters - Detractors) / Total Responses * 100


#### 💰 `revenue_by_nps_label`
- Receita total por tipo de NPS
- Receita média por resposta
- Análise do impacto financeiro da satisfação

---

## 🧠 Conceitos Aplicados

- Modelagem dimensional (Fato/Dimensão)
- Separação clara entre transformação técnica e regra de negócio
- Métricas calculadas na camada final
- Uso de `ref()` para dependências explícitas
- Estrutura modular e escalável

---

## 🚀 Tecnologias Utilizadas

- **dbt Core**
- **Google BigQuery**
- SQL (BigQuery dialect)
- Git / GitHub para versionamento

---

## 📊 Casos de Uso Analíticos

Este pipeline permite responder perguntas como:

- Qual o NPS mensal por canal?
- Clientes promotores geram mais receita?
- Qual o comportamento de compra por região?
- Clientes ativos possuem maior LTV?
- Qual o impacto financeiro de detratores?

---

## 📎 Próximos Passos (Evolução do Projeto)

- Implementação de testes de qualidade (dbt tests)
- Implementação de incremental models
- Construção de métricas de churn e LTV
- Integração com ferramenta de BI
- Orquestração com Airflow

---

## 👤 Autor

Projeto desenvolvido como exercício prático de Analytics Engineering focado em Customer & Business Analytics.


