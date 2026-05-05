
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        canal as value_field,
        count(*) as n_records

    from "dw_analytics"."raw"."campaigns"
    group by canal

)

select *
from all_values
where value_field not in (
    'google','meta','linkedin'
)



  
  
      
    ) dbt_internal_test