{% macro get_application_qna_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "answer", "datatype": dbt_utils.type_string()},
    {"name": "application_id", "datatype": dbt_utils.type_int()},
    {"name": "index", "datatype": dbt_utils.type_int()},
    {"name": "question", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
