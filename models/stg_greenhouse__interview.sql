
with base as (

    select * 
    from {{ ref('stg_greenhouse__interview_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__interview_tmp')),
                staging_columns=get_interview_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        cast(id as {{ dbt.type_string() }}) as interview_id,
        interview_kit_content,
        cast(job_stage_id as {{ dbt.type_string() }}) as job_stage_id,
        name
        
    from fields
)

select * from final
