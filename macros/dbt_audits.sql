{% macro audit_log(run_activity) %}

{% set audit_schema = 'utilities' %}
{% set audit_table = 'dbt_audit' %}

{% set audit_query %}

{% if this.name %}
insert into {{target.database}}.{{audit_schema}}.{{audit_table}}
values ('{{ invocation_id }}', '{{ this.name }}', '{{ run_activity }}', current_timestamp());

{% else %}
insert into {{target.database}}.{{audit_schema}}.{{audit_table}}
values ('{{ invocation_id }}', 'N/A', '{{ run_activity }}', current_timestamp());

{% endif %}

{% endset %}

{% do run_query (audit_query) %}

{% endmacro %}




{% macro audit_prep() %}

{% set audit_schema = 'utilities' %}
{% set audit_table = 'dbt_audit' %}

{% set audit_prep_query %}
create table if not exists analytics_015.{{audit_schema}}.{{audit_table}}
(
    run_id text,
    run_object text,
    run_activity text,
    created_at timestamp_ntz
);
{% endset %}

{% do run_query (audit_prep_query) %}

{% endmacro %}