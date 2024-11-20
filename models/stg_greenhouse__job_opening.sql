
with base as (

    select * 
    from {{ ref('stg_greenhouse__job_opening_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__job_opening_tmp')),
                staging_columns=get_job_opening_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        cast(application_id as {{ dbt.type_string() }}) as application_id,
        cast(close_reason_id as {{ dbt.type_string() }}) as close_reason_id,
        cast(closed_at as {{ dbt.type_timestamp() }}) as closed_at,
        cast(id as {{ dbt.type_string() }})as job_openining_id,
        cast(job_id as {{ dbt.type_string() }}) as job_id,
        cast(opened_at as {{ dbt.type_timestamp() }}) as opened_at,
        cast(opening_id as {{ dbt.type_string() }})as opening_text_id,
        status as current_status

    from fields
)

select * from final
