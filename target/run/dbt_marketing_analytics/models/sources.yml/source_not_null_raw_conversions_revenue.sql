
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select revenue
from "dw_analytics"."raw"."conversions"
where revenue is null



  
  
      
    ) dbt_internal_test