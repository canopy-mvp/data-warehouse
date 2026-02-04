SELECT
  id,
  merchant_id,
  amount,
  status,
  created_at
FROM {{ source('canopy', 'transactions') }}
