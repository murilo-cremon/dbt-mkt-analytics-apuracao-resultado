
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select orcamento
from "dw_analytics"."raw"."campaigns"
where orcamento is null



  
  
      
    ) dbt_internal_test