
with base as (

    select * 
    from {{ ref('stg_greenhouse__scheduled_interviewer_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__scheduled_interviewer_tmp')),
                staging_columns=get_scheduled_interviewer_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        cast(interviewer_id as {{ dbt.type_string() }}) as interviewer_user_id,
        cast(scheduled_interview_id as {{ dbt.type_string() }}) as scheduled_interview_id,
        cast(scorecard_id as {{ dbt.type_string() }}) as scorecard_id

    from fields
)

select * from final
