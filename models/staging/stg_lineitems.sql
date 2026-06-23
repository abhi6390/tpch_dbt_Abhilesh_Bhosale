WITH source AS (

    SELECT *
    FROM {{ source('raw', 'LINEITEM') }}

),

renamed AS (

    SELECT

        L_ORDERKEY      AS order_key,
        L_PARTKEY       AS part_key,
        L_SUPPKEY       AS supplier_key,
        L_LINENUMBER    AS line_number,
        L_QUANTITY      AS quantity,
        L_EXTENDEDPRICE AS extended_price,
        L_DISCOUNT      AS discount,
        L_TAX           AS tax,
        L_RETURNFLAG    AS return_flag,
        L_LINESTATUS    AS line_status,
        L_SHIPDATE      AS ship_date,
        L_COMMITDATE    AS commit_date,
        L_RECEIPTDATE   AS receipt_date,
        L_SHIPINSTRUCT  AS ship_instruction,
        L_SHIPMODE      AS ship_mode,
        L_COMMENT       AS comment,

        -- Derived columns
        L_EXTENDEDPRICE * (1 - L_DISCOUNT) AS effective_revenue,

        L_EXTENDEDPRICE * L_TAX AS tax_amount,

        CASE
            WHEN L_RETURNFLAG = 'R' THEN TRUE
            ELSE FALSE
        END AS is_returned,

        DATEDIFF(
            'day',
            L_SHIPDATE,
            L_RECEIPTDATE
        ) AS days_to_ship

    FROM source

)

SELECT *
FROM renamed