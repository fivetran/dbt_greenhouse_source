{% macro get_scorecard_attribute_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "index", "datatype": dbt_utils.type_int()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "note", "datatype": dbt_utils.type_string()},
    {"name": "rating", "datatype": dbt_utils.type_string()},
    {"name": "scorecard_id", "datatype": dbt_utils.type_int()},
    {"name": "type", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
