# HR-SQL-absenteeism-and-health-SQL-analysis
This provides a data driven approach to determine how to provide a bonus and incentive to healthy employees. You will also develop a database, SQL queries to answer questions and build a dashboard which meets a wireframe specification
# Here's a breakdown of the steps involved,
1. Data Acquisition and Preparation:
   ````
   a.  Import employee data into a SQL Server database.
   b.  Clean and transform the data to ensure consistency and accuracy.
   c.  Join multiple tables to create a comprehensive dataset.
   ````
  ```sql
   -- create a join table
SELECT * FROM [HR_db].[dbo].[Absenteeism_at_work] AB
LEFT JOIN [HR_db].[dbo].[compensation]  C
ON AB.ID = C.ID
LEFT JOIN  [HR_db].[dbo].[Reasons] R
ON AB.Reason_for_absence = R.Number
``` 
2. Data Analysis and Querying:
   ````
   Write SQL queries to:
    a. Identify healthy employees based on criteria like BMI, smoking, and drinking habits.
    b. Calculate the total wage increase for non-smokers.
    c. Analyze absenteeism trends by month, day of the week, and season.
    d. Explore correlations between factors like workload, transportation expenses, and absenteeism.
    ````
    ```sql
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
   ```
    
3. Data Visualization:
   ````
      a. Create a dashboard in Power BI to visualize the analysis results.
      b. Design a clear and intuitive dashboard layout, following a wireframe.
      c. Utilize various visualizations, including:
      d. KPIs to highlight key metrics (e.g., average absenteeism)
      e. Charts to show trends and distributions (e.g., line charts, bar charts, pie charts)
      f. Tables to display detailed data
      g. Interactive elements to allow users to filter and explore data
      ````

  ![image](https://github.com/user-attachments/assets/2f2cc332-ddaf-4fbb-9add-bba3f2360b64)
## 5. Insights and Recommendations:
  1. Present actionable insights to HR based on the analysis.
  2. Suggest strategies to improve employee health and reduce absenteeism.
  3. Provide recommendations for future data analysis and dashboard enhancements.
# Tools and Technologies Used:
  1.   SQL Server
  2. Power BI
  3. Microsoft SQL Server Studio
# Key Learnings:
  1. End-to-end data analysis process, from data acquisition to visualization.
  SQL query writing and optimization techniques.
  Data cleaning and transformation best practices.
  Effective data visualization techniques to communicate insights.
  Use of Power BI's features to create interactive and informative dashboards.
Future Improvements:
 a. Explore advanced data analysis techniques, such as machine learning, to predict future trends.
 b. Incorporate additional data sources to gain deeper insights.
 c. Enhance the dashboard with more interactive features and visualizations.
 d. Automate the data pipeline to streamline the analysis process.
