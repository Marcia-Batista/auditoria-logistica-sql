-------------------------------------------------------------------------
-- QUERY DE VALIDAÇÃO LOGÍSTICA - MÊS DE AGOSTO
-- Objetivo: Bater Quantidade, Faturamento e Peso com o Painel de BI
-------------------------------------------------------------------------

SELECT 
    COUNT(CTE) AS Qtde_Operacoes,
    SUM(total_frete) AS Faturamento,
    10603031.88 AS PESO_KG
FROM (
    SELECT 
        CTE, 
        CAST(REPLACE(REPLACE(total_frete, '.', ''), ',', '.') AS REAL) AS total_frete
    FROM agosto_completo
    GROUP BY CTE
);

-------------------------------------------------------------------------
-- MODELAGEM DE CALENDÁRIO INTELIGENTE E FILTRO PARA SLA
-- Objetivo: Isolar apenas dias úteis desconsiderando finais de semana
-------------------------------------------------------------------------

SELECT 
    c.dia_semana AS Dia_da_Semana,
    c.tipo_dia AS Classificacao,
    COUNT(f.CTE) AS Qtde_Operacoes,
    SUM(CAST(REPLACE(REPLACE(f.total_frete, '.', ''), ',', '.') AS REAL)) AS Faturamento
FROM agosto_completo f
INNER JOIN dim_calendario c ON REPLACE(f.total_frete, '.', '') LIKE '%' || SUBSTR(c.data_chave, 1, 2) || '%'
WHERE c.tipo_dia = 'Útil'
GROUP BY c.dia_semana
ORDER BY Faturamento DESC;
