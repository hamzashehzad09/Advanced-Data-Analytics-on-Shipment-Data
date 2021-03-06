SELECT 
    *
FROM
    pricing_tool_testing;


WITH CTE_nan_Null_Custom_Rate AS 

			(SELECT * FROM pricing_tool_testing
					 WHERE custom_rate_reference <> "" 
  )
       
       
select * from (

select *,

		FORMAT(AVG(CASE WHEN (groups_ = 1 and Cost <> 0 ) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_margin_group_1,
        
		FORMAT(AVG(CASE WHEN (groups_ = 2 and Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_margin_group_2,
        
        FORMAT(AVG(CASE WHEN (groups_ = 3 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_margin_group_3,
        
        FORMAT(AVG(CASE WHEN (groups_ = 4 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_margin_group_4,
        
        FORMAT(AVG(CASE WHEN (groups_ = 5 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_margin_group_5,
        
        FORMAT(AVG(CASE WHEN (groups_ = 6 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_margin_group_6,
        
        FORMAT(AVG(CASE WHEN (groups_ = 7 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_margin_group_7,
        
        FORMAT(AVG(CASE WHEN (groups_ = 8 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_margin_group_8,
        
        FORMAT(AVG(CASE WHEN (groups_ = 9 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_margin_group_9,
        
        FORMAT(AVG(CASE WHEN (groups_ = 10 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_margin_group_10,
        
        FORMAT(AVG(CASE WHEN (groups_ = 11 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_margin_group_11,
        
        FORMAT(AVG(CASE WHEN (groups_ = 1 and 	Cost <> 0) then (Cost) end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_cost_group_1,
        
        FORMAT(AVG(CASE WHEN (groups_ = 2 and 	Cost <> 0) then (Cost) end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_cost_group_2,
        
        FORMAT(AVG(CASE WHEN (groups_ = 3 and 	Cost <> 0) then (Cost) end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_cost_group_3,
        
        FORMAT(AVG(CASE WHEN (groups_ = 4 and 	Cost <> 0) then (Cost) end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_cost_group_4,
        
        FORMAT(AVG(CASE WHEN (groups_ = 5 and 	Cost <> 0) then (Cost) end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_cost_group_5,
        
        FORMAT(AVG(CASE WHEN (groups_ = 6 and 	Cost <> 0) then (Cost) end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_cost_group_6,
        
        FORMAT(AVG(CASE WHEN (groups_ = 7 and 	Cost <> 0) then (Cost) end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_cost_group_7,
        
        FORMAT(AVG(CASE WHEN (groups_ = 8 and 	Cost <> 0) then (Cost) end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_cost_group_8,
        
        FORMAT(AVG(CASE WHEN (groups_ = 9 and 	Cost <> 0) then (Cost) end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_cost_group_9,
        
        FORMAT(AVG(CASE WHEN (groups_ = 10 and 	Cost <> 0) then (Cost) end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_cost_group_10,
        
        FORMAT(AVG(CASE WHEN (groups_ = 11 and 	Cost <> 0) then (Cost) end)
        OVER (PARTITION BY custom_rate_reference, groups_),2) as avg_cost_group_11
        
        
        
        
        -- AVERAGE OF COST 
        
        
	from
    
    (

 SELECT * ,
 
 
 (
 case  
	when (ranking_ >= 1 and ranking_ < 20 ) then  1
	when (ranking_ >= 20 and ranking_ < 70 ) then 2 
	when (ranking_ >= 70 and ranking_ < 120 ) then 3
	when (ranking_ >= 120 and ranking_ < 170 ) then 4 
	when (ranking_ >= 170 and ranking_ < 220 ) then 5 
	when (ranking_ >= 220 and ranking_ < 270 ) then 6 
	when (ranking_ >= 270 and ranking_ < 320 ) then 7 
	when (ranking_ >= 320 and ranking_ < 370 ) then 8 
	when (ranking_ >= 370 and ranking_ < 420 ) then 9
	when (ranking_ >= 420 and ranking_ < 470 ) then 10
	when (ranking_ >= 470 and ranking_ < 520 ) then 11 END ) groups_

 
 from (
 
SELECT										 
       custom_rate_reference, 
       ranking_,
       transport_cost_amount as Cost,
       transport_pricing_amount as Revenue
      
			from 
				(SELECT *,

                ROW_NUMBER () 
                over(PARTITION BY custom_rate_reference
                order by (cast(first_stop_requested_to_date as date))) as ranking_
                
					
				FROM 
						CTE_nan_Null_Custom_Rate) as Final) as final_)final_o) as f_final
                        Group by custom_rate_reference, groups_
                        
                       ;                                
                                
										
          --  CR2L319                  