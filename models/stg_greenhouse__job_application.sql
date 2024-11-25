
with base as (

    select * 
    from {{ ref('stg_greenhouse__job_application_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__job_application_tmp')),
                staging_columns=get_job_application_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        cast(application_id as {{ dbt.type_string() }}) as application_id,
        cast(job_id as {{ dbt.type_string() }}) as job_id
    from fields
)

select * from final
