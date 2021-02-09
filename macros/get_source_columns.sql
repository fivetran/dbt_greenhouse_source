{% macro get_source_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "source_type_id", "datatype": dbt_utils.type_int()},
    {"name": "source_type_name", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
