SELECT *
FROM {{ ref('stg_lineitems') }}
WHERE effective_revenue > extended_price