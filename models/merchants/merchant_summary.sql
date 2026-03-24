-- Merchant summary model
WITH merchant_txns AS (
  SELECT
    m.id AS merchant_id,
    m.name AS merchant_name,
    COUNT(t.id) AS total_transactions,
    SUM(t.amount) AS total_volume,
    AVG(t.amount) AS avg_transaction
  FROM {{ ref('stg_merchants') }} m
  LEFT JOIN {{ ref('stg_transactions') }} t ON t.merchant_id = m.id
  GROUP BY m.id, m.name
)

SELECT
  merchant_id,
  merchant_name,
  total_transactions,
  total_volume,
  avg_transaction,
  CASE
    WHEN total_volume > 1000000 THEN 'enterprise'
    WHEN total_volume > 100000 THEN 'growth'
    ELSE 'starter'
  END AS tier
FROM merchant_txns
