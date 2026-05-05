
    
    

with all_values as (

    select
        campaign_id as value_field,
        count(*) as n_records

    from "dw_analytics"."raw"."leads"
    group by campaign_id

)

select *
from all_values
where value_field not in (
    'google','meta','linkedin'
)


