{% macro get_social_media_address_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "candidate_id", "datatype": dbt_utils.type_int()},
    {"name": "index", "datatype": dbt_utils.type_int()},
    {"name": "value", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
