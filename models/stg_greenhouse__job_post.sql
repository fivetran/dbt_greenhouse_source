
with base as (

    select * 
    from {{ ref('stg_greenhouse__job_post_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__job_post_tmp')),
                staging_columns=get_job_post_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        content,
        created_at,
        external as is_external,
        id as job_post_id,
        internal as is_internal,
        internal_content,
        job_id,
        live as is_live,
        location_name,
        title,
        updated_at as last_updated_at

    from fields

    where not coalesce(_fivetran_deleted, false)
)

select * from final
