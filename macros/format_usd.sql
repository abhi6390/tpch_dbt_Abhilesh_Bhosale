{% macro format_usd(column_name) %}

    TO_CHAR(
        {{ column_name }},
        '$999,999,999,999.00'
    )

{% endmacro %}