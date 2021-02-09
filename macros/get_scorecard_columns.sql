{% macro get_scorecard_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "application_id", "datatype": dbt_utils.type_int()},
    {"name": "candidate_id", "datatype": dbt_utils.type_int()},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "interview", "datatype": dbt_utils.type_string()},
    {"name": "interviewed_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "overall_recommendation", "datatype": dbt_utils.type_string()},
    {"name": "submitted_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "submitted_by_user_id", "datatype": dbt_utils.type_int()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}
