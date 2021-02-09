
with base as (

    select * 
    from {{ ref('stg_greenhouse__close_reason_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__close_reason_tmp')),
                staging_columns=get_close_reason_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        id as close_reason_id,
        name as close_reason_name,
        _fivetran_synced
        
    from fields

    where not coalesce(_fivetran_deleted, false)
)

select * from final
