WITH source AS (

    SELECT *
    FROM {{ source('raw', 'ORDERS') }}

),

renamed AS (

    SELECT

        O_ORDERKEY       AS order_key,
        O_CUSTKEY        AS customer_key,
        O_ORDERSTATUS    AS order_status,
        O_TOTALPRICE     AS total_price,
        O_ORDERDATE      AS order_date,
        O_ORDERPRIORITY  AS order_priority,
        O_CLERK          AS clerk,
        O_SHIPPRIORITY   AS ship_priority,
        O_COMMENT        AS comment,

        -- Derived date columns
        EXTRACT(YEAR FROM O_ORDERDATE) AS order_year,
        EXTRACT(MONTH FROM O_ORDERDATE) AS order_month,
        TO_CHAR(O_ORDERDATE, 'Month') AS order_month_name,
        TO_CHAR(O_ORDERDATE, 'Day') AS order_day_of_week

    FROM source

)

SELECT *
FROM renamed