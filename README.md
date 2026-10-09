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
