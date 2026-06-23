SELECT *
FROM {{ ref('mart_order_summary') }}
WHERE total_effective_revenue <= 0