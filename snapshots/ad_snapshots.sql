{% snapshot ads_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='ad_id',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ source('ad_platform', 'ads') }}

{% endsnapshot %}