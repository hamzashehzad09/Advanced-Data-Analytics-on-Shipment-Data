select * from pricing_tool_testing;


WITH CTE_nan_Null_Custom_Rate AS 

			(SELECT * FROM pricing_tool_testing
					 WHERE custom_rate_reference <> "" 
  )
        
        


SELECT *,


		AVG(CASE WHEN (groups_ = 1 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_) as avg_margin_group_1,
        
        AVG(CASE WHEN (groups_ = 2 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_) as avg_margin_group_2,
        
        AVG(CASE WHEN (groups_ = 3 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_) as avg_margin_group_3,
        
        AVG(CASE WHEN (groups_ = 4 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_) as avg_margin_group_4,
        
        AVG(CASE WHEN (groups_ = 5 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_) as avg_margin_group_5,
        
        AVG(CASE WHEN (groups_ = 6 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_) as avg_margin_group_6,
        
        AVG(CASE WHEN (groups_ = 7 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_) as avg_margin_group_7,
        
        AVG(CASE WHEN (groups_ = 8 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_) as avg_margin_group_8,
        
        AVG(CASE WHEN (groups_ = 9 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_) as avg_margin_group_9,
        
        AVG(CASE WHEN (groups_ = 10 and 	Cost <> 0) then ((Revenue - Cost)/(Revenue))*100 end)
        OVER (PARTITION BY custom_rate_reference, groups_) as avg_margin_group_10
        
	FROM
    
    (
        




 SELECT * ,
 
 -- IF(coefficient_of_variation < 0.2 or Cofficent_of_variation_pricing_amount < 0.2 , "NOT CONFIRMED", "YES") AS Surcharge_Possibility,
 -- (case when (coefficient_of_variation < 0.2 or Cofficent_of_variation_pricing_amount < 0.2) then "NOT CONFIRMED" else "Yes" end) AS Surcharge_Possibility_,
 (case when (ranking_ >= 20 and ranking_ < 70 ) then 1 
  when (ranking_ >= 70 and ranking_ < 120 ) then 2 
  when (ranking_ >= 120 and ranking_ < 170 ) then 3 
  when (ranking_ >= 170 and ranking_ < 220 ) then 4 
 when (ranking_ >= 220 and ranking_ < 270 ) then 5 
 when (ranking_ >= 270 and ranking_ < 320 ) then 6 
 when (ranking_ >= 320 and ranking_ < 370 ) then 7 
 when (ranking_ >= 370 and ranking_ < 420 ) then 8 
 when (ranking_ >= 420 and ranking_ < 470 ) then 9 
 when (ranking_ >= 470 and ranking_ < 520 ) then 10 END ) groups_
 -- SUM(CASE WHEN (Revenue - Cost)  < 0 THEN 1 ELSE 0 END)
 -- OVER (PARTITION BY custom_rate_reference, ranking_) as frequency_first_fifty
 
	
 
 
 FROM (
 
SELECT											 
	   -- shipment_reference, 
	
       custom_rate_reference, 
       ranking_,
       first_stop_requested_to_date,
       -- (STR_TO_DATE(first_stop_requested_to_date, '%yyyy-%mm-%dd')) as date_format_date,
       cast(first_stop_requested_to_date as date) as date_cast,
       left(first_stop_requested_to_date,4) AS Year,
       right(first_stop_requested_to_date,2) AS Date,
       -- RIGHT(first_stop_requested_to_date,2) AS Month,
        SUBSTRING(first_stop_requested_to_date, locate("-", first_stop_requested_to_date )+1, 2) AS Month,
       
       -- first_stop_country,
        first_stop_one_digit_code,
       -- first_stop_two_digit_code,
       -- last_stop_country,
 
       -- last_stop_two_digit_code,
       last_stop_one_digit_code,
       shipment_distance,
       Min_distance,
       Max_distance,
       
       transport_pricing_amount AS Revenue,  -- revnue 
       transport_cost_amount AS Cost,
       
       FORMAT(Max_cost/shipment_distance,2) AS Max_Cost_km,
       FORMAT(Min_Cost/shipment_distance,2) AS Min_Cost_km,
       FORMAT(Avg_Cost_/shipment_distance,2) AS Avg_cost_km,
       FORMAT(Avg_Revenue_/shipment_distance,2) AS Avg_Revenue_km,         #ONE DIGIT TO ONE DIGIT 
       FORMAT (Deviation_in_Cost_/shipment_distance,2) AS Deviation_in_Cost_km,
      -- FORMAT((Avg_Cost_ +  Deviation_in_Cost)/shipment_distance,2) AS Max_deviation_km,
	  -- (transport_pricing_amount - transport_cost_amount) AS Profit_or_Margin,
       -- FORMAT(((transport_pricing_amount - transport_cost_amount)/(transport_pricing_amount)) * 100,2) AS Percentage_margin,
       FORMAT((Deviation_in_Cost_ / Avg_Cost_),2) AS coefficient_of_variation,
      -- FORMAT(Deviation_in_Pricing_amount_,2) AS Deviation_in_Pricing_amount,
      -- FORMAT((Deviation_in_Pricing_amount_ / Avg_Revenue_),2) AS Cofficent_of_variation_pricing_amount,
       
      -- CONCAT(first_stop_country, "-" , last_stop_country) AS Country_to_Country_relation,
      -- Format(Deviation_in_Cost_Country_Level_,2) AS Deviation_in_Cost_Country_Level,
       -- FORMAT((Deviation_in_Cost_Country_Level_ / Avg_Cost_Country_Level),2) AS coefficient_of_variation_Country_Level,
       
	   -- first_stop_one_digit_code,
       -- last_stop_one_digit_code,
      
	   (Frequency_Profit + Frequency_Loss + Frequency_Profit_Zero) AS Total_Frequency_lane,
       Frequency_Profit,
       Frequency_Loss,
       Frequency_Profit_Zero,
       FORMAT(Frequency_Profit/(Frequency_Profit + Frequency_Loss ) * 100,2) AS Percentage_Frequency_Profit,
       FORMAT(Frequency_Loss/(Frequency_Profit + Frequency_Loss ) * 100,2) AS Percentage_Frequency_Loss
       

			FROM 
            
			
				(SELECT *,
                
                
	
                ROW_NUMBER () 
                OVER(PARTITION BY custom_rate_reference, first_stop_one_digit_code, last_stop_one_digit_code
                ORDER by (cast(first_stop_requested_to_date as date))) AS ranking_,
                
                
				AVG(CASE WHEN transport_cost_amount <> 0 THEN transport_cost_amount END ) 
					OVER (PARTITION BY first_stop_one_digit_code, last_stop_one_digit_code)
								AS Avg_Cost_, 
                                
				AVG(CASE WHEN transport_cost_amount <> 0 THEN transport_cost_amount END )  -- and  custom_rate_reference <> ""  
					OVER (PARTITION BY  first_stop_country, last_stop_country) -- same as concat(first_stop_country, last_stop_country)
								AS Avg_Cost_Country_Level, 
                                                             
				
			
				STDDEV(transport_cost_amount) 
					OVER(PARTITION BY first_stop_one_digit_code, last_stop_one_digit_code)
								AS Deviation_in_Cost_,
				STDDEV(CASE WHEN transport_cost_amount <> 0 THEN transport_cost_amount END)  -- and  custom_rate_reference <> ""															 
					OVER(PARTITION BY  first_stop_country, last_stop_country)
								AS Deviation_in_Cost_Country_Level_,
                                


				MAX(transport_cost_amount) 
					OVER(PARTITION BY  first_stop_one_digit_code, last_stop_one_digit_code) 
								AS Max_Cost,
				
                MAX(shipment_distance) 
					OVER(PARTITION BY  first_stop_one_digit_code, last_stop_one_digit_code) 
								AS Max_distance,
                                
				MIN(CASE WHEN (transport_cost_amount) <> 0 THEN transport_cost_amount END)
					OVER(PARTITION BY  first_stop_one_digit_code, last_stop_one_digit_code) 
								AS Min_Cost,
				AVG(CASE WHEN (transport_pricing_amount <> 0) THEN transport_pricing_amount END) 
					OVER(PARTITION BY first_stop_one_digit_code, last_stop_one_digit_code) 
								AS Avg_Revenue_,
				MIN(CASE WHEN (shipment_distance) <> 0 THEN transport_cost_amount END)
					OVER(PARTITION BY  first_stop_one_digit_code, last_stop_one_digit_code) 
								AS Min_distance,
				SUM(CASE WHEN (transport_pricing_amount - transport_cost_amount)  > 0 
							THEN 1 ELSE 0 END)
					OVER(PARTITION BY  first_stop_one_digit_code, last_stop_one_digit_code)
								AS Frequency_Profit,
				SUM(CASE WHEN (transport_pricing_amount - transport_cost_amount)  < 0 
							THEN 1 ELSE 0 END)
					OVER(PARTITION BY first_stop_one_digit_code, last_stop_one_digit_code)
									AS Frequency_Loss,
                                    
				SUM(CASE WHEN (transport_pricing_amount - transport_cost_amount) = 0 
							THEN 1 ELSE 0 END)
					OVER(PARTITION BY first_stop_one_digit_code, last_stop_one_digit_code)
									AS Frequency_Profit_Zero,
                                    
				STDDEV(transport_pricing_amount) 
					OVER(PARTITION BY  first_stop_one_digit_code, last_stop_one_digit_code)
								AS Deviation_in_Pricing_amount_ -- shows us that there must be a surcharge
																-- TRNASPORT_PRICING OR TRANSPORT_COST AMOUNT OFFICENT OF DEVIATION < 0.5 THEN SURCHARGE,
                                                                
		
                                
				
				FROM 
						CTE_nan_Null_Custom_Rate) AS Final) AS final_) AS final_o
                       ;                                
                                
-- CR2L319										
                             