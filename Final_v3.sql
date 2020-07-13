select * from pricing_tool_;


WITH CTE_nan_Null_Custom_Rate AS 

			(SELECT * FROM pricing_tool_
					 WHERE custom_rate_reference <> "" 
  )
        
        
SELECT											 
	   -- shipment_reference, 
       custom_rate_reference, 
       RIGHT(first_stop_requested_to_date,4) AS Year,
       SUBSTRING(first_stop_requested_to_date, locate("-", first_stop_requested_to_date )+1, 3) AS Month,
       
       first_stop_country,
       first_stop_two_digit_code,
       last_stop_country,
 
       last_stop_two_digit_code,
       full_truck_type,
       transport_pricing_amount AS Revenue,  -- revnue 
       transport_cost_amount AS Cost,
       
       Max_Cost,
       FORMAT(Max_cost/shipment_distance,2) AS Max_Cost_km,
       Min_Cost,
       FORMAT(Min_Cost/shipment_distance,2) AS Min_Cost_km,
	   FORMAT(Avg_Cost,2) AS Avg_cost,
       FORMAT(Avg_Cost/shipment_distance,2) AS Avg_cost_km,
       FORMAT(Avg_Revenue/shipment_distance,2) AS Avg_Revenue_km,
       FORMAT (Deviation_in_Cost,2) AS Deviation_in_Cost,
       FORMAT (Deviation_in_Cost/shipment_distance,2) AS Deviation_in_Cost_km,
       FORMAT((Avg_Cost +  Deviation_in_Cost),2) AS Max_deviation,
       FORMAT((Avg_Cost +  Deviation_in_Cost)/shipment_distance,2) AS Max_deviation_km,
	   (transport_pricing_amount - transport_cost_amount) AS Profit_or_Margin,
       FORMAT(((transport_pricing_amount - transport_cost_amount)/(transport_pricing_amount)), 2) * 100 AS Percentage_margin,
       FORMAT((Deviation_in_Cost / Avg_Cost),2) AS coefficient_of_variation,
       
       CONCAT(first_stop_country, "-" , last_stop_country) AS Country_to_Country_relation,
       Format(Deviation_in_Cost_Country_Level_,2) AS Deviation_in_Cost_Country_Level,
       FORMAT((Deviation_in_Cost_Country_Level_ / Avg_Cost_Country_Level),2) AS coefficient_of_variation_Country_Level,
       Format(Avg_coefficient_of_variation_Country_Level_ ,2) AS Avg_coefficient_of_variation_Country_Level,
       
       -- Avg((Deviation_in_Cost_Country_Level_ / Avg_Cost_Country_Level)) as Avg_variant_of_cofficent_Country_Level,
	   first_stop_one_digit_code,
       last_stop_one_digit_code,
       FORMAT(Deviation_in_Cost_DE_DE_Relation_,2) AS Deviation_in_Cost_DE_DE_Relation,
       FORMAT((Deviation_in_Cost_DE_DE_Relation_ / Avg_Cost_DE_DE),2) AS cofficent_of_variation_DE_DE,
       FORMAT(Avg_cofficent_of_variation_DE_DE_,2) AS Avg_cofficent_of_variation_DE_DE,
       
       
       (Frequency_Profit + Frequency_Loss) AS Total_Frequency_lane,
       Frequency_Profit,
       Frequency_Loss,
       Frequency_Profit/(Frequency_Profit + Frequency_Loss ) * 100 AS Percentage_Frequency_Profit,
       Frequency_Loss/(Frequency_Profit + Frequency_Loss ) * 100 AS Percentage_Frequency_Loss
       

			from 
				(
				SELECT *,
                
                
                 -- ((Deviation_in_Cost_Country_Level_ / Avg_Cost_Country_Level)) as Avg_variant_of_cofficent_Country_Level
                
                
                (STDDEV(CASE WHEN transport_cost_amount <> 0 THEN transport_cost_amount END)  -- and  custom_rate_reference <> ""															 
					OVER(PARTITION BY  first_stop_country, last_stop_country)) / (AVG(CASE WHEN transport_cost_amount <> 0 THEN transport_cost_amount END )  -- and  custom_rate_reference <> ""  
																						OVER (PARTITION BY  first_stop_country, last_stop_country)) AS Avg_coefficient_of_variation_Country_Level_,
																															-- same as (PARTITION BY first_country, last_stop_country) 
                                                                                                                            
                                                                                                                            
				(STDDEV(CASE WHEN (concat(first_stop_country, "-" ,last_stop_country) = "DE-DE" AND transport_cost_amount <> 0 ) THEN transport_cost_amount END)
					OVER(PARTITION BY  first_stop_one_digit_code, last_stop_one_digit_code))
                    
														/	
                                                        
																(AVG(CASE WHEN (transport_cost_amount <> 0 AND (concat(first_stop_country, "-" ,last_stop_country) = "DE-DE"))  THEN transport_cost_amount END ) 
																				OVER (PARTITION BY  first_stop_one_digit_code, last_stop_one_digit_code)) AS Avg_cofficent_of_variation_DE_DE_,
                
				AVG(CASE WHEN transport_cost_amount <> 0 THEN transport_cost_amount END ) 
					OVER (PARTITION BY custom_rate_reference, first_stop_one_digit_code, last_stop_one_digit_code, full_truck_type)
								AS Avg_Cost, 
                                
				AVG(CASE WHEN transport_cost_amount <> 0 THEN transport_cost_amount END )  -- and  custom_rate_reference <> ""  
					OVER (PARTITION BY  first_stop_country, last_stop_country) -- same as concat(first_stop_country, last_stop_country)
								AS Avg_Cost_Country_Level, 
                                
                AVG(CASE WHEN (transport_cost_amount <> 0 AND (concat(first_stop_country, "-" ,last_stop_country) = "DE-DE"))  THEN transport_cost_amount END ) 
					OVER (PARTITION BY  first_stop_one_digit_code, last_stop_one_digit_code)
								AS Avg_Cost_DE_DE,
			
				STDDEV(transport_cost_amount) 
					OVER(PARTITION BY custom_rate_reference, first_stop_one_digit_code, last_stop_one_digit_code,full_truck_type)
								AS Deviation_in_Cost,
				STDDEV(CASE WHEN transport_cost_amount <> 0 THEN transport_cost_amount END)  -- and  custom_rate_reference <> ""															 
					OVER(PARTITION BY  first_stop_country, last_stop_country)
								AS Deviation_in_Cost_Country_Level_,
                                
				STDDEV(CASE WHEN (concat(first_stop_country, "-" ,last_stop_country) = "DE-DE" AND transport_cost_amount <> 0 ) THEN transport_cost_amount END)
					OVER(PARTITION BY  first_stop_one_digit_code, last_stop_one_digit_code)
								AS Deviation_in_Cost_DE_DE_Relation_,

				MAX(transport_cost_amount) 
					OVER(PARTITION BY custom_rate_reference, first_stop_one_digit_code, last_stop_one_digit_code,full_truck_type) 
								AS Max_Cost,
				MIN(CASE WHEN (transport_cost_amount) <> 0 THEN transport_cost_amount END)
					OVER(PARTITION BY custom_rate_reference, first_stop_one_digit_code, last_stop_one_digit_code,full_truck_type) 
								AS Min_Cost,
				AVG(CASE WHEN (transport_pricing_amount <> 0) THEN transport_pricing_amount END) 
					OVER(PARTITION BY custom_rate_reference, first_stop_one_digit_code, last_stop_one_digit_code,full_truck_type) 
								AS Avg_Revenue,
				SUM(CASE WHEN (transport_pricing_amount - transport_cost_amount)  >=0 
							THEN 1 ELSE 0 END)
					OVER(PARTITION BY custom_rate_reference, first_stop_one_digit_code, last_stop_one_digit_code,full_truck_type)
								AS Frequency_Profit,
				SUM(CASE WHEN (transport_pricing_amount - transport_cost_amount)  < 0 
							THEN 1 ELSE 0 END)
					OVER(PARTITION BY custom_rate_reference, first_stop_one_digit_code, last_stop_one_digit_code,full_truck_type)
									AS Frequency_Loss
		
				FROM 
						CTE_nan_Null_Custom_Rate) as Final ;
                                
                                
										
                             