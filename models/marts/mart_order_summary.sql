WITH orders_enriched AS (

    SELECT *
    FROM {{ ref('int_orders_enriched') }}

),

order_summary AS (

    SELECT

        order_key,
        customer_key,
        order_date,
        order_status,
        order_priority,

        COUNT(*) AS total_line_items,

        SUM(quantity) AS total_quantity,

        SUM(extended_price) AS total_extended_price,

        SUM(effective_revenue) AS total_effective_revenue,

        SUM(extended_price - effective_revenue) AS total_discount_amount,

        AVG(discount) AS avg_discount_pct,

        BOOLOR_AGG(is_returned) AS has_returned_items

    FROM orders_enriched

    GROUP BY

        order_key,
        customer_key,
        order_date,
        order_status,
        order_priority

)

SELECT *
FROM order_summary