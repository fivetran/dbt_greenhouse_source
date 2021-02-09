{% macro get_user_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "disabled", "datatype": "boolean"},
    {"name": "employee_id", "datatype": dbt_utils.type_string()},
    {"name": "first_name", "datatype": dbt_utils.type_string()},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "last_name", "datatype": dbt_utils.type_string()},
    {"name": "site_admin", "datatype": "boolean"},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}
