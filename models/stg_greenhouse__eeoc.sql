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
        cast(application_id as {{ dbt.type_string() }}) as application_id,
        disability_status_description,
        cast(disability_status_id as {{ dbt.type_string() }}) as disability_status_id,
        gender_description,
        cast(gender_id as {{ dbt.type_string() }}) as gender_id,
        race_description,
        cast(race_id as {{ dbt.type_string() }}) as race_id,
        cast(submitted_at as {{ dbt.type_timestamp() }}) as submitted_at,
        veteran_status_description,
        cast(veteran_status_id as {{ dbt.type_string() }}) as veteran_status_id
        
    from fields
)

select * from final
