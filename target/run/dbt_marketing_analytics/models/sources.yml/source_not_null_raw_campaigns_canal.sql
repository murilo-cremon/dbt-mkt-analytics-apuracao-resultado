
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select canal
from "dw_analytics"."raw"."campaigns"
where canal is null



  
  
      
    ) dbt_internal_test