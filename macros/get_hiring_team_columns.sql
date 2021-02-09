{% macro get_hiring_team_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "job_id", "datatype": dbt_utils.type_int()},
    {"name": "role", "datatype": dbt_utils.type_string()},
    {"name": "user_id", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
