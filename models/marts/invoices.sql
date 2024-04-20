{{
    config(
        materialized='incremental',
        unique_key='invoice_id',
        on_schema_change='append_new_columns'
    )
}}

with

invoices as (

    select * from {{ ref('stg_accounting_app__invoices') }}

    {% if is_incremental() %}

    -- this filter will only be applied on an incremental run
    where invoiced_at > (select max(invoiced_at) from {{ this }})

    {% endif %}

),

final as (

    select
        invoice_id,
        customer_id,
        amount_due_in_usd,
        invoiced_at,
        due_date,
        payment_terms,
        '{{ invocation_id }}' as batch_id

    from invoices

)

select * from final