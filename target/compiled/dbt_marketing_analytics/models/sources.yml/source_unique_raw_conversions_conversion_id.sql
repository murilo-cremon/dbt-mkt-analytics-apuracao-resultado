
    
    

select
    conversion_id as unique_field,
    count(*) as n_records

from "dw_analytics"."raw"."conversions"
where conversion_id is not null
group by conversion_id
having count(*) > 1


