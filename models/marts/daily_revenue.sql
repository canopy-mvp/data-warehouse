SELECT
  DATE_TRUNC('day', t.created_at) AS revenue_date,
  COUNT(*) AS transaction_count,
  SUM(t.amount) AS total_revenue
FROM {{ ref('stg_transactions') }} t
WHERE t.status = 'succeeded'
GROUP BY 1
