WITH source AS (

    SELECT *
    FROM {{ source('raw', 'CUSTOMER') }}

),

renamed AS (

    SELECT

        C_CUSTKEY      AS customer_key,
        C_NAME         AS customer_name,
        C_ADDRESS      AS address,
        C_NATIONKEY    AS nation_key,
        C_PHONE        AS phone,
        C_ACCTBAL      AS acct_balance,
        C_MKTSEGMENT   AS market_segment,
        C_COMMENT      AS comment,

        CASE
            WHEN C_ACCTBAL > 0 THEN TRUE
            ELSE FALSE
        END AS is_positive_balance

    FROM source

)

SELECT *
FROM renamed