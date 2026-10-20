# Auditoria Logística e Modelagem Dimensional com SQL

Este projeto apresenta a resolução de um problema de negócio real no setor de logística e transportes, focado na auditoria de faturamento, saneamento de dados duplicados e inteligência de tempo para cálculo de acordos de nível de serviço (SLA).

## 📌 Problema de Negócio (Cenário Fictício)
O fechamento mensal automatizado de uma grande operação logística de transporte indicava uma volumetria de **40.671 operações** e um faturamento total de **R\$ 12,9 Milhões**. No entanto, a métrica de peso físico bruto indicava um acumulado distorcido de **10,6 Milhões de kg** devido a falhas de agrupamento por documentos em trânsito (CT-e), gerando erros de cálculo de custos operacionais por quilo.

## 🛠️ Solução Técnica Aplicada
Utilizei a linguagem **SQL (SQLite)** para realizar o tratamento, limpeza e unificação da base de dados (massa de dados volumosa com mais de 44 mil registros):
- **Tratamento de Strings e Conversão:** Tratamento de inconsistências de formatação regional de texto e pontos em valores numéricos utilizando `REPLACE` e `CAST`.
- **Deduplicação de Registros:** Uso de funções de agrupamento (`GROUP BY`) e consolidação para sanear as métricas de peso bruto real e faturamento, eliminando registros duplicados indesejados.
- **Modelagem Dimensional de Tempo (Calendário):** Criação e alimentação de uma tabela dimensão de calendário (`dim_calendario`) e aplicação de filtros condicionais (`WHERE`) para isolar exclusivamente dias úteis operacionais (Segunda a Sexta-feira), desconsiderando finais de semana para métricas de conformidade de prazos (SLA).

## 📄 Scripts SQL Utilizados
Os códigos estruturados deste projeto estão documentados e disponíveis para consulta nesta pasta.

---

# 🚚 Módulo 2: Gerenciamento Avançado de Fretes (CRUD, Views & Inteligência de Tempo)

Nesta segunda etapa do projeto, expandi o escopo para incluir a gestão completa do ciclo de vida dos dados (CRUD) de motoristas e faturamento, além do tratamento de anomalias regionais de datas no SQLite para estruturação de modelos analíticos integrados ao Power BI.

### 🛠️ Novas Competências Aplicadas:
* **Gerenciamento de Entidades (CRUD em Tabelas):** Criação de tabelas com integridade referencial (`PRIMARY KEY`, `FOREIGN KEY`), regras de consistência (`NOT NULL`, `UNIQUE`) e manutenção de dados via `INSERT`, `UPDATE` e `DELETE`.
* **Carga Automatizada em Lote (`INSERT SELECT`):** Migração eficiente de dados de fornecedores e remetentes a partir da massa de dados bruta, eliminando duplicidades via `DISTINCT` e tratando exceções via `INSERT OR IGNORE`.
* **Subqueries & Análise de Concentração:** Implementação de subconsultas dinâmicas no SQL para calcular a representatividade percentual (%) de custo por prestador de serviço (Mapeamento de Pareto / Gargalos).
* **Engenharia de Tempo Avançada (`SUBSTR`):** Tratamento cirúrgico de strings de datas brasileiras (`DD/MM/AAAA`) para viabilizar agrupamentos cronológicos mensais de faturamento de frete no SQLite.

### 📊 Scripts SQL Desenvolvidos neste Módulo:

```sql
-- [Adicione aqui os seus códigos favoritos que fizemos hoje, como a View final ou o INSERT SELECT!]
```

-- COLE O SEU CODIGO SQL BEM AQUI EMBAIXO DA LINHA 35/36
SELECT
    (SUBSTR(data_emiss_o, 7, 4) || '-' || SUBSTR(data_emiss_o, 4, 2)) AS "Mês / Ano",
    COUNT(*) AS "Total de Viagens no Mês",
    ROUND(SUM(CAST(REPLACE(total_frete, ',', '.') AS REAL)), 2) AS "Faturamento Mensal"
FROM 
    relatoriocte
GROUP BY 
    SUBSTR(data_emiss_o, 7, 4), 
    SUBSTR(data_emiss_o, 4, 2)
ORDER BY 
    "Mês / Ano" DESC;
