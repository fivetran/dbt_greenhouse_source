
with base as (

    select * 
    from {{ ref('stg_greenhouse__hiring_team_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__hiring_team_tmp')),
                staging_columns=get_hiring_team_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        cast(job_id as {{ dbt.type_string() }}) as job_id,
        role,
        cast(user_id as {{ dbt.type_string() }}) as user_id
        
    from fields
)

select * from final
