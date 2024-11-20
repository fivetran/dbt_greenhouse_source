
with base as (

    select * 
    from {{ ref('stg_greenhouse__application_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__application_tmp')),
                staging_columns=get_application_columns()
            )
        }}
    
        {% if var('greenhouse_application_custom_columns', []) != [] %}
        ,
        {{ var('greenhouse_application_custom_columns', [] )  | join(', ') }}
        {% endif %}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        cast(applied_at as {{ dbt.type_timestamp() }}) as applied_at,
        cast(candidate_id as {{ dbt.type_string() }}) as candidate_id,
        cast(credited_to_user_id as {{ dbt.type_string() }}) as credited_to_user_id,
        cast(current_stage_id as {{ dbt.type_string() }}) as current_stage_id,
        cast(id as {{ dbt.type_string() }}) as application_id,
        cast(last_activity_at as {{ dbt.type_timestamp() }}) as last_activity_at,
        location_address,
        prospect as is_prospect,
        cast(prospect_owner_id as {{ dbt.type_string() }}) as prospect_owner_user_id,
        cast(prospect_pool_id as {{ dbt.type_string() }}) as prospect_pool_id,
        cast(prospect_stage_id as {{ dbt.type_string() }}) as prospect_stage_id,
        cast(rejected_at as {{ dbt.type_timestamp() }}) as rejected_at,
        cast(rejected_reason_id as {{ dbt.type_string() }}) as rejected_reason_id,
        cast(source_id as {{ dbt.type_string() }}) as source_id,
        status

        {% if var('greenhouse_application_custom_columns', []) != [] %}
        ,
        {{ var('greenhouse_application_custom_columns', [] )  | join(', ') }}
        {% endif %}

    from fields

    where not coalesce(_fivetran_deleted, false)
)

select * from final
