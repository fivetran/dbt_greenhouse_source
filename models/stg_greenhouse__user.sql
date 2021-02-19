
with base as (

    select * 
    from {{ ref('stg_greenhouse__user_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__user_tmp')),
                staging_columns=get_user_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        created_at,
        disabled as is_disabled,
        employee_id, -- external
        first_name || ' ' || last_name as full_name,
        id as user_id,
        site_admin as is_site_admin,
        updated_at as last_updated_at

    from fields

)

select * from final
