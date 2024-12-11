SELECT TOP (1000) [ID]
      ,[Reason_for_absence]
      ,[Month_of_absence]
      ,[Day_of_the_week]
      ,[Seasons]
      ,[Transportation_expense]
      ,[Distance_from_Residence_to_Work]
      ,[Service_time]
      ,[Age]
      ,[Work_load_Average_day]
      ,[Hit_target]
      ,[Disciplinary_failure]
      ,[Education]
      ,[Son]
      ,[Social_drinker]
      ,[Social_smoker]
      ,[Pet]
      ,[Weight]
      ,[Height]
      ,[Body_mass_index]
      ,[Absenteeism_time_in_hours]
  FROM [HR_db].[dbo].[Absenteeism_at_work]

-- create a join table
SELECT * FROM [HR_db].[dbo].[Absenteeism_at_work] AB
LEFT JOIN [HR_db].[dbo].[compensation]  C
ON AB.ID = C.ID
LEFT JOIN  [HR_db].[dbo].[Reasons] R
ON AB.Reason_for_absence = R.Number


---Find the healthiest employees for the bonus
-- Given HR has not provide the definitaion of healthy staff we assume stuff.Assumptions made is that the staff do not smoke or drink
SELECT * FROM [HR_db].[dbo].[Absenteeism_at_work] 
WHERE[Social_smoker] = 0 AND [Social_drinker] = 0 
AND [Body_mass_index] < 25
AND [Absenteeism_time_in_hours] < (SELECT AVG([Absenteeism_time_in_hours]) FROM [HR_db].[dbo].[Absenteeism_at_work])

--- compensation rate increase for non smokers/budget $983,221 so 0.68 per hour or 1414 per year
SELECT count(*) AS nonsmokers FROM [HR_db].[dbo].[Absenteeism_at_work]
WHERE[Social_smoker] = 0

---optimize query
SELECT AB.ID,R.Reason,
CASE WHEN [Month_of_absence]  in (12,1,2) THEN 'Winter'
	 WHEN [Month_of_absence]  in (3,4,5) THEN 'Spring'
	 WHEN [Month_of_absence]  in (6,7,8) THEN 'Summer'
	 WHEN [Month_of_absence]  in (9,10,11) THEN 'Fall'
	 ELSE 'Unknown' END AS Season_names,
CASE WHEN [Body_mass_index]  <18.5  THEN 'underweight'
	 WHEN [Body_mass_index]  BETWEEN 18.5 AND 24.9  THEN 'Healthy'
	 WHEN [Body_mass_index]  BETWEEN 25 AND 30  THEN 'Overweight'
	 WHEN [Body_mass_index]  >30 THEN 'Obese'
	 ELSE 'Unknown' END AS BMI_Category
,[Month_of_absence]
,[Day_of_the_week]
,[Seasons]
,[Transportation_expense]
,[Distance_from_Residence_to_Work]
,[Service_time]
,[Age]
,[Work_load_Average_day]
,[Hit_target]
,[Disciplinary_failure]
,[Education]
,[Son]
,[Social_drinker]
,[Social_smoker]
,[Pet]
,[Weight]
,[Height]
,[Body_mass_index]
,[Absenteeism_time_in_hours]
FROM [HR_db].[dbo].[Absenteeism_at_work] AB
LEFT JOIN [HR_db].[dbo].[compensation]  C
ON AB.ID = C.ID
LEFT JOIN  [HR_db].[dbo].[Reasons] R
ON AB.Reason_for_absence = R.Number
