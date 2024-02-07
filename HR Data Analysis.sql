-- --  HR1 AND HR2 TABLES DATA IS USED TO DRAW FOLLOWING RESULT --

-- -- KEY PERFORMANCE INDICATORS --
-- -- TOTAL EMPLOYEES --

SELECT Count(EmployeeCount) AS Total_Employees
FROM hr1;
    
-- -- ACTIVE EMPLOYEES --

SELECT count(*) 
FROM hr1
WHERE attrition = "No";

-- -- ATTRION COUNT--

SELECT count(*) 
FROM hr1
WHERE attrition = "No";
    

-- -- COUNT OF FEMALE EMPLOYEES --
SELECT Count( * )AS Female_EmployeeCount
FROM hr1
WHERE Attrition = "Yes" and Gender = "Female";

-- -- Count of male Employees --
SELECT Count( * ) AS Male_EmployeeCount
FROM hr1
WHERE Attrition = "Yes" AND Gender = "male";

-- -- ATTRITION RATE --
SELECT CONCAT(ROUND(SUM(CASE WHEN attrition = "yes" THEN 1 ELSE 0 end)/ COUNT(EmployeeCount)*100,2),'%') AS AttritionRate
FROM hr1;

-- -- Employee Average Age --
SELECT ROUND(AVG(age)) AS Average_Age FROM hr1;
-- --Avg Salary --
SELECT ROUND(AVG(Salary)) AS Average_Age FROM hr1;
Select * from hr2;
-- -- Avg_EnvironmentSatisfaction --

SELECT ROUND(AVG(EnvironmentSatisfaction),3) AS Avg_Environment_Satisfaction FROM hr1;


-- -- Avg JobSatisfaction --

SELECT ROUND(AVG(JobSatisfaction),3) AS Avg_Job_Satisfaction_Rate FROM hr1;

-- -- Avg Performance Rating --

SELECT ROUND(AVG(PerformanceRating),3) AS Performance_Rating FROM hr2;

-- --  Avg Work Life Balance -- 

SELECT ROUND(AVG(WorkLifeBalance),3) AS AvgWorkLifeBalance FROM hr2;


-- -- AVERAGE ATTRITION RATE FOR ALL DEPARTMENTS --

SELECT Department, 
CONCAT((ROUND(SUM(CASE WHEN attrition = "Yes" THEN 1 ELSE 0 END)/ count(employeenumber)*100,2)),' %') AS Attrition_Rate
FROM hr1
GROUP BY Department;

-- --AVERAGE HOURLY RATE OF MALE RESEARCH SCIENTIST --

SELECT JobRole,Gender, CONCAT(ROUND(AVG(HourlyRate),2),' %') AS Avg_HourlyRate 
FROM hr1
WHERE JobRole = "research scientist" && gender = "male"
GROUP BY JobRole;

-- -- Attrition rate Vs AvgMonthly income stats --

SELECT hr1.Department,
CONCAT(ROUND(SUM(CASE WHEN attrition = "yes" THEN 1 ELSE 0 END)/ COUNT(employeenumber)*100,2),'%') AS Attrition_Rate,
ROUND(AVG(hr2.MonthlyIncome)) AS Avg_MonthlyIncome
FROM hr1 INNER JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
GROUP BY 1;

-- -- AVERAGE WORKING YEARS FOR EACH DEPARTMENT --

SELECT hr1.Department, ROUND(AVG(hr2.TotalWorkingYears),2) AS Avg_Working_Years
FROM hr1 JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
GROUP BY hr1.Department;


-- -- Job Role Vs Work life balance --
 /*

select * from hr2;
with WLBS as
(
	select distinct( hr1.JobRole) as JobRole,
    hr1.Department as Department,
    (case when hr2.WorkLifeBalance = 1 then "Poor"
		  when hr2.WorkLifeBalance = 2 then "Average"
          when hr2.WorkLifeBalance = 3 then "Good"
          else "Excelent"
          end) as Wrk_Lif_Bal_Stats,
          count(WorkLifeBalance) as Count_WorkLifeBalance
	from hr1 inner join hr2
    on hr1.EmployeeNumber = hr2.EmployeeID
    group by Department
) 
	select JobRole,count(Wrk_Lif_Bal_Stats) as Wrk_Lif_Bal_Stats, Count_WorkLifeBalance
    from wlbs ;
   -- order by JobRole;
    */
SELECT DISTINCT(hr1.JobRole),(CASE
WHEN hr2.WorkLifeBalance = 1 THEN "1.Poor" 
WHEN hr2.WorkLifeBalance = 2 THEN "2.Average" 
WHEN hr2.WorkLifeBalance = 3 THEN "3.Good" 
ELSE "4.excellent"END) 
AS worklifebal_status,
COUNT(hr2.WorkLifeBalance) 
as count_worklifebalance from hr1 inner join hr2
on hr1.EmployeeNumber = hr2.Employeeid
group by 1 ,2
order by worklifebal_status asc,count_worklifebalance desc; 

-- -- ATTRITIONRATE VS YEARSINCE LAST PROMOTION --

SELECT hr1.Department,CONCAT(ROUND(SUM(CASE WHEN attrition = "Yes" THEN 1 ELSE 0 END )/COUNT(hr1.employeeCount)*100,2),'%') AS Atr_Rate, 
ROUND(AVG(hr2.YearsSinceLastPromotion),2) AS avg_YearsSinceLastPromotion
FROM hr1 INNER JOIN hr2
ON hr1.EmployeeNumber = hr2.EmployeeID
GROUP BY 1;

-- -- EXTRA KPI'S --