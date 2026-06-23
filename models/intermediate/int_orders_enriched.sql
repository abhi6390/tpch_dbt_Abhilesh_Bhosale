WITH orders AS (

    SELECT *
    FROM {{ ref('stg_orders') }}

),

lineitems AS (

    SELECT *
    FROM {{ ref('stg_lineitems') }}

),

parts AS (

    SELECT *
    FROM {{ ref('stg_parts') }}

),

joined AS (

    SELECT

        -- Order
        o.order_key,
        o.customer_key,
        o.order_date,
        o.order_status,
        o.order_priority,
        o.order_year,

        -- Line Item
        l.line_number,
        l.part_key,
        l.quantity,
        l.extended_price,
        l.discount,
        l.tax,
        l.effective_revenue,
        l.tax_amount,
        l.return_flag,
        l.is_returned,
        l.ship_mode,
        l.days_to_ship,

        -- Part
        p.part_name,
        p.part_type,
        p.brand,
        p.manufacturer,
        p.retail_price

    FROM orders o

    INNER JOIN lineitems l
        ON o.order_key = l.order_key

    INNER JOIN parts p
        ON l.part_key = p.part_key

)

SELECT *
FROM joined