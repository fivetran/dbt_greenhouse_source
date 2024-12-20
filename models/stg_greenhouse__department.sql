{{ config(enabled=var('greenhouse_using_job_department', True)) }}

with base as (

    select * 
    from {{ ref('stg_greenhouse__department_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__department_tmp')),
                staging_columns=get_department_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        cast(external_id as {{ dbt.type_string() }}) as external_department_id,
        cast(id as {{ dbt.type_string() }}) as department_id,
        name,
        cast(parent_id as {{ dbt.type_string() }}) as parent_department_id

    from fields

    where not coalesce(_fivetran_deleted, false)
)

select * from final