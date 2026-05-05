
    
    

with all_values as (

    select
        canal as value_field,
        count(*) as n_records

    from "dw_analytics"."raw"."ad_spend"
    group by canal

)

select *
from all_values
where value_field not in (
    'google','meta','linkedin'
)


