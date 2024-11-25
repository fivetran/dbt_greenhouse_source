{{ config(enabled=var('greenhouse_using_job_office', True)) }}

with base as (

    select * 
    from {{ ref('stg_greenhouse__office_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__office_tmp')),
                staging_columns=get_office_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        cast(external_id as {{ dbt.type_string() }}) as external_office_id,
        cast(id as {{ dbt.type_string() }}) as office_id,
        location_name,
        name as office_name,
        cast(parent_id as {{ dbt.type_string() }}) as parent_office_id,
        cast(primary_contact_user_id as {{ dbt.type_string() }}) as primary_contact_user_id
        
    from fields

    where not coalesce(_fivetran_deleted, false)
)

select * from final
