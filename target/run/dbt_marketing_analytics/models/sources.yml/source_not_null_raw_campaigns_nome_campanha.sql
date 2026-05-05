
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select nome_campanha
from "dw_analytics"."raw"."campaigns"
where nome_campanha is null



  
  
      
    ) dbt_internal_test