---Exploratory Data Analysis (EDA)--

SELECT * FROM college_wage;
----Count the number of records in the dataset,
SELECT COUNT (*) FROM college_wage;
----Checking for missing values
SELECT COUNT (*) AS total_missing_value
FROM college_wage 
WHERE year IS NULL OR high_school IS NULL OR bachelors_degree IS NULL OR men_high_school IS NULL OR women_bachelors_degree IS NULL OR women_high_school IS NULL OR men_bachelors_degree IS NULL;
--find records with non-missing values in all columns 
SELECT COUNT (*) AS total_non_missing_value
FROM college_wage
WHERE [year] IS NOT NULL OR high_school IS NOT NULL OR bachelors_degree IS NOT NULL OR men_bachelors_degree IS NOT NULL OR men_high_school IS NOT NULL OR women_bachelors_degree IS NOT NULL OR women_high_school IS NOT NULL;
--Inspect the data types of columns in the table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'college_wage';
--Remove duplicate records from the dataset
SELECT DISTINCT * FROM college_wage;
--comparison by education level (College graduates Vs. High school)

SELECT 'high_school' AS education_level,
       AVG(high_school) AS average_median_wage
FROM college_wage
UNION
SELECT 'bachelors_degree' AS education_level,
       AVG(bachelors_degree) AS average_median_wage
FROM college_wage;
--comparison by gender
SELECT 'men_high_school' AS Gender_education_level,
        AVG(men_high_school) AS average_median_wage
FROM college_wage
UNION ALL
SELECT 'women_high_school' AS Gender_education_level,
        AVG(women_high_school) AS average_median_level
FROM college_wage
UNION ALL
SELECT 'men_bachelors_degree' AS  Gender_education_level,
        AVG(men_bachelors_degree) AS average_median_level
FROM college_wage
UNION ALL
SELECT 'women_bachelors_degree' AS GENDER_education_level,
         AVG(women_bachelors_degree) AS average_median_level
FROM college_wage;
--comparison by year
SELECT year AS YEAR,
        AVG(high_school) AS avg_high_school
FROM college_wage 
GROUP BY [year]
ORDER BY [year];


--**DATA INSIGHTS**
--Trend in wage differences between college and high school graduates over the years?
SELECT year AS Year, 
        AVG(bachelors_degree) - AVG(high_school) AS Wage_gap
FROM college_wage
GROUP BY year 
ORDER BY year;


--Trend in wage differences between men college and men high school graduates over the years?

SELECT year AS Year,
        AVG(men_bachelors_degree) - AVG(men_high_school) AS Men_Wage_gap
FROM college_wage
GROUP BY year 
ORDER BY year; 

--Trend in wage differences between women college and high school graduates over the years?
SELECT year AS Year,
        AVG(women_bachelors_degree) - AVG(women_high_school) AS WoMen_Wage_gap
FROM college_wage
GROUP BY year 
ORDER BY year; 


--Investigate whether the wage gap has been narrowing or widening for different genders.
--Wage Gap between Men Bachelor degree and women bachelor degree
SELECT year AS Year,
               AVG(men_bachelors_degree) - AVG(women_bachelors_degree) AS wage_gap
FROM college_wage
GROUP BY [year]
ORDER BY [year];
--Trend metrics
--Annual Growth Rate and Percentage Change
SELECT
    year AS year,
    AVG(men_bachelors_degree) - AVG(women_bachelors_degree) AS wage_gap,
    LAG(AVG(men_bachelors_degree) - AVG(women_bachelors_degree)) OVER (ORDER BY year) AS previous_wage_gap,
    ((AVG(men_bachelors_degree) - AVG(women_bachelors_degree)) - LAG(AVG(men_bachelors_degree) - AVG(women_bachelors_degree)) OVER (ORDER BY year)) / LAG(AVG(men_bachelors_degree) - AVG(women_bachelors_degree)) OVER (ORDER BY year) AS annual_growth_rate,
    ((AVG(men_bachelors_degree) - AVG(women_bachelors_degree)) - LAG(AVG(men_bachelors_degree) - AVG(women_bachelors_degree)) OVER (ORDER BY year)) / LAG(AVG(men_bachelors_degree) - AVG(women_bachelors_degree)) OVER (ORDER BY year) * 100 AS percentage_change

FROM college_wage
GROUP BY year
ORDER BY year;


--Determine the year(s) when the wage gap was at its lowest and highest points.
--Finding the lowest wage gap between bachelors degree and high school graduates
SELECT TOP 1 year AS year,
       AVG(bachelors_degree) - AVG(high_school) AS wage_gap
FROM college_wage
GROUP BY year
ORDER BY wage_gap ASC;
--Finding the highest wage gap between bachelors degree and high school graduates
SELECT TOP 1 year AS year,
       AVG(bachelors_degree) - AVG(high_school) AS wage_gap
FROM college_wage
GROUP BY year
ORDER BY wage_gap DESC;

--Finding the lowest wage gap between men bachelors degree and men high school graduates
SELECT TOP 1 year AS year,
       AVG(men_bachelors_degree) - AVG(men_high_school) AS wage_gap
FROM college_wage
GROUP BY year
ORDER BY wage_gap ASC;

--Finding the highest wage gap between men bachelors degree and men high school graduates
SELECT TOP 1 year AS year,
       AVG(men_bachelors_degree) - AVG(men_high_school) AS wage_gap
FROM college_wage
GROUP BY year
ORDER BY wage_gap DESC;

--Finding the lowest wage gap between women bachelors degree and women high school graduates
SELECT TOP 1 year AS year,
       AVG(women_bachelors_degree) - AVG(women_high_school) AS wage_gap
FROM college_wage
GROUP BY year
ORDER BY wage_gap ASC;

--Finding the highest wage gap between women bachelors degree and women high school graduates
SELECT TOP 1 year AS year,
       AVG(women_bachelors_degree) - AVG(women_high_school) AS wage_gap
FROM college_wage
GROUP BY year
ORDER BY wage_gap DESC;

--Identifying the demographic group(s) that have experienced the largest increase in wages over time.


SELECT SUM(wage_increase) AS total_wage_increase_men_high_school,
       SUM(wage_increase_bachelors) AS total_wage_increase_men_bachelors,
     SUM(women_wage_increase) AS total_wage_increase_women_high_school,
    SUM(women_wage_increase_bachelors) AS total_wage_increase_women_bachelors

FROM (
    SELECT year,
           men_high_school,
           men_bachelors_degree,
           women_high_school,
           women_bachelors_degree,
           men_high_school - LAG(men_high_school) OVER (ORDER BY year ASC) AS wage_increase,
           men_bachelors_degree - LAG(men_bachelors_degree) OVER (ORDER BY year ASC) AS wage_increase_bachelors,
        women_bachelors_degree - LAG(women_bachelors_degree) OVER (ORDER BY year ASC) AS women_wage_increase_bachelors,
        women_high_school - LAG(women_high_school) OVER (ORDER BY year ASC) AS women_wage_increase

 FROM college_wage
) AS wage_changes;


--Compare the wage gap between men and women within each educational group and analyze how it has changed over the years.

SELECT year AS Year, men_bachelors_degree, women_bachelors_degree,
        AVG(men_bachelors_degree) - AVG(women_bachelors_degree) AS Wage_gap_bachelors
FROM college_wage
GROUP BY year, men_bachelors_degree, women_bachelors_degree
ORDER BY year;

SELECT year AS Year, men_high_school, women_high_school,
        AVG(men_high_school) - AVG(women_high_school) AS Wage_gap_high_school
FROM college_wage
GROUP BY year, men_high_school, women_high_school
ORDER BY year;




