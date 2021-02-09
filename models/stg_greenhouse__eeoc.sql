{{ config(enabled=var('greenhouse_using_eeoc', True)) }}

with base as (

    select * 
    from {{ ref('stg_greenhouse__eeoc_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__eeoc_tmp')),
                staging_columns=get_eeoc_columns()
            )
        }}
        
    from base
),

final as (
    
    select *

    from fields
)

select * from final
