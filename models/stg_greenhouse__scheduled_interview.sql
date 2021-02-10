
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
        application_id,
        created_at,
        {%- if target.type == 'bigquery' %}
        `end` 
        {% elif target.type == 'redshift' %} 
        "end" 
        {% else %}
        end 
        {%- endif -%}
        as end_at,
        id as scheduled_interview_id,
        interview_id,
        location,
        organizer_id as organizer_user_id,

        {%- if target.type == 'snowflake' %}
        "START"
        {% else %}
        start 
        {% endif %}
        as start_at,
        
        status,
        updated_at as last_updated_at
        
    from fields

    where not coalesce(_fivetran_deleted, false)
)

select * from final