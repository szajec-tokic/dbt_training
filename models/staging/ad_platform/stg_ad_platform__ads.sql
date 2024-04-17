with

ads as (

    select * from {{ ref('ads_snapshot') }}

),

final as (

    select
        id,
        ad_id,
        ad_title,
        ad_status,
        ad_objective,
        created_at,
        updated_at,
        dbt_scd_id,
        dbt_updated_at,
        dbt_valid_from,
        dbt_valid_to

    from ads

    where dbt_valid_to is null

)

select * from final