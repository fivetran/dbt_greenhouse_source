
with base as (

    select * 
    from {{ ref('stg_greenhouse__candidate_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_greenhouse__candidate_tmp')),
                staging_columns=get_candidate_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        _fivetran_synced,
        company as current_company,
        coordinator_id as coordinator_user_id,
        created_at,
        first_name,
        id as candidate_id,
        is_private,
        last_activity as last_activity_at,
        last_name,
        new_candidate_id,
        photo_url,
        recruiter_id as recruiter_user_id,
        title as current_title,
        updated_at as last_updated_at

        {% if var('greenhouse_candidate_custom_columns') %}
        ,
        {{ var('greenhouse_candidate_custom_columns', [] )  | join(', ') }}
        {% endif %}

    from fields

    where not coalesce(_fivetran_deleted, false)
)

select * from final
