{% macro get_scheduled_interviewer_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "interviewer_id", "datatype": dbt_utils.type_int()},
    {"name": "scheduled_interview_id", "datatype": dbt_utils.type_int()},
    {"name": "scorecard_id", "datatype": dbt_utils.type_int()}
] %}

{{ return(columns) }}

{% endmacro %}
