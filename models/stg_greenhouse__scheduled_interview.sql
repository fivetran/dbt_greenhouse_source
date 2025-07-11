
with base as (

    select * 
    from {{ ref('stg_greenhouse__scheduled_interview_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__scheduled_interview_tmp')),
                staging_columns=get_scheduled_interview_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        cast(application_id as {{ dbt.type_string() }}) as application_id,
        cast(created_at as {{ dbt.type_timestamp() }}) as created_at,
        cast(coalesce(ends,
        {%- if target.type == 'bigquery' %}
        `end` 
        {% elif target.type in ('redshift','postgres') %} 
        "end" 
        {% else %}
        end 
        {% endif %}
        ) as {{ dbt.type_timestamp() }}) as end_at,
        cast(id as {{ dbt.type_string() }}) as scheduled_interview_id,
        cast(interview_id as {{ dbt.type_string() }}) as interview_id,
        location,
        cast(organizer_id as {{ dbt.type_string() }}) as organizer_user_id,

        cast(
        {%- if target.type == 'snowflake' %}
        "START" 
        {% else %}
        start 
        {% endif %}
        as {{ dbt.type_timestamp() }}) as start_at,
        
        status,
        cast(updated_at as {{ dbt.type_timestamp() }}) as last_updated_at
        
    from fields

    where not coalesce(_fivetran_deleted, false)
)

select * from final