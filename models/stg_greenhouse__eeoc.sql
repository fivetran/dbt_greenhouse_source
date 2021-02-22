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
    
    select 
        _fivetran_synced,
        application_id,
        disability_status_description,
        disability_status_id,
        gender_description,
        gender_id,
        race_description,
        race_id,
        submitted_at,
        veteran_status_description,
        veteran_status_id,
        veteran_status_message
        
    from fields
)

select * from final
