with

invoices as (

    select * from {{ source('accounting_app', 'invoices') }}

),

final as (

    select
        id as invoice_id,
        create_date as invoiced_at,
        customer_id,
        amount_due as amount_due_in_usd,
        payment_terms,
        due_date

    from invoices

)

select * from final