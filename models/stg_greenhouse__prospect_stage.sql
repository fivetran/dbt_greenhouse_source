{{ config(enabled=var('greenhouse_using_prospects', True)) }}

with base as (

    select * 
    from {{ ref('stg_greenhouse__prospect_stage_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__prospect_stage_tmp')),
                staging_columns=get_prospect_stage_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        cast(id as {{ dbt.type_string() }}) as prospect_stage_id,
        name as prospect_stage_name,
        cast(prospect_pool_id as {{ dbt.type_string() }}) as prospect_pool_id
        
    from fields

    where not coalesce(_fivetran_deleted, false)
)

select * from final
