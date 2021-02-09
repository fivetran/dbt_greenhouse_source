{% macro get_job_columns() %}

{% set columns = [
    {"name": "_fivetran_deleted", "datatype": "boolean"},
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "closed_at", "datatype": dbt_utils.type_timestamp()},
    {"name": "confidential", "datatype": "boolean"},
    {"name": "created_at", "datatype": dbt_utils.type_timestamp()},

    {"name": "id", "datatype": dbt_utils.type_int()},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "notes", "datatype": dbt_utils.type_string()},
    {"name": "requisition_id", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "updated_at", "datatype": dbt_utils.type_timestamp()}
] %}

{{ return(columns) }}

{% endmacro %}
