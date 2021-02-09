{% macro get_user_email_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "email", "datatype": dbt_utils.type_string()},
    {"name": "user_id", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
