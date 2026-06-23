WITH source AS (

    SELECT *
    FROM {{ source('raw', 'PART') }}

),

renamed AS (

    SELECT

        P_PARTKEY      AS part_key,
        P_NAME         AS part_name,
        P_MFGR         AS manufacturer,
        P_BRAND        AS brand,
        P_TYPE         AS part_type,
        P_SIZE         AS part_size,
        P_CONTAINER    AS container,
        P_RETAILPRICE  AS retail_price,
        P_COMMENT      AS comment,

        -- Derived columns
        {{ format_usd('P_RETAILPRICE') }} AS price_formatted,

        CASE
            WHEN P_SIZE > 25 THEN TRUE
            ELSE FALSE
        END AS is_large_part

    FROM source

)

SELECT *
FROM renamed