WITH order_summary AS (

    SELECT *
    FROM {{ ref('mart_order_summary') }}

),

customers AS (

    SELECT *
    FROM {{ ref('stg_customers') }}

),

customer_metrics AS (

    SELECT

        c.customer_key,
        c.customer_name,
        c.market_segment,
        c.acct_balance,

        COUNT(o.order_key) AS total_orders,

        COALESCE(SUM(o.total_effective_revenue), 0) AS total_revenue,

        COALESCE(AVG(o.total_effective_revenue), 0) AS avg_order_value,

        MIN(o.order_date) AS first_order_date,

        MAX(o.order_date) AS last_order_date,

        DATEDIFF(
            'day',
            MIN(o.order_date),
            MAX(o.order_date)
        ) AS days_as_customer,

        CASE
            WHEN COALESCE(SUM(o.total_effective_revenue), 0) > 2000000 THEN 'PLATINUM'
            WHEN COALESCE(SUM(o.total_effective_revenue), 0) > 1000000 THEN 'GOLD'
            WHEN COALESCE(SUM(o.total_effective_revenue), 0) > 500000 THEN 'SILVER'
            ELSE 'BRONZE'
        END AS spend_tier

    FROM customers c

    LEFT JOIN order_summary o
        ON c.customer_key = o.customer_key

    GROUP BY

        c.customer_key,
        c.customer_name,
        c.market_segment,
        c.acct_balance

)

SELECT *
FROM customer_metrics