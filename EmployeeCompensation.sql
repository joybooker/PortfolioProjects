/*
Employee Compensation Exploration 
*/

-- Check Dataset

SELECT *
FROM EmployeeCompensation

-- List of Unique Departments

SELECT DISTINCT Department
FROM EmployeeCompensation 

-- Number of Benefit Categories

SELECT COUNT(DISTINCT Benefits_Category) AS #ofCategories
FROM EmployeeCompensation

-- Number of Employees in Each Department

SELECT Department, COUNT(*) AS EmployeeCount
FROM EmployeeCompensation
GROUP BY Department
ORDER BY EmployeeCount DESC

-- Full & Part Time Employee Count

SELECT Full_Part_Time, COUNT(*) as EmployeeCount
FROM EmployeeCompensation
GROUP BY Full_Part_Time

-- Average Hourly Rate for Each Job Title

SELECT Job_Title, AVG(Hourly_Rate) as AvgHourlyPay
FROM EmployeeCompensation
GROUP BY Job_Title

-- 5 Highest Paid Employees 

SELECT Name, Regular_Pay
FROM EmployeeCompensation
ORDER BY Regular_Pay DESC
OFFSET 0 ROWS
FETCH FIRST 5 ROWS ONLY

-- How has the average regular pay changed over the years?

SELECT YEAR(Hire_Date) as HireYear, AVG(Regular_Pay) as AvgRegPay
FROM EmployeeCompensation
GROUP BY YEAR(Hire_Date)
ORDER BY HireYear

-- Which department has the highest overtime pay?

SELECT Department, MAX(Overtime_Pay) AS AvgOT
FROM EmployeeCompensation
GROUP BY Department
ORDER BY AvgOT DESC
OFFSET 0 ROWS
FETCH FIRST 1 ROWS ONLY

-- Calculate the Total Pay for Each Department

SELECT Department, SUM(Regular_Pay) as TotalPay
FROM EmployeeCompensation
GROUP BY Department

-- Sort Regular Pay by Pay Category

SELECT *,
CASE
WHEN Regular_Pay >=80000 THEN 'Senior Level'
WHEN Regular_Pay >=50000 AND Regular_Pay <80000 THEN 'Mid Level'
ELSE 'Low Level'
END AS Pay_Category
FROM EmployeeCompensation 
ORDER BY Pay_Category DESC

-- 2021 New Hires by Quarter

SELECT Name, Department, Job_Title, Hire_Date,
CASE
WHEN Hire_Date BETWEEN '2021-01-01' AND '2021-03-31' THEN 'Q1'
WHEN Hire_Date BETWEEN '2021-04-01' AND '2021-06-30' THEN 'Q2'
WHEN Hire_Date BETWEEN '2021-07-01' AND '2021-09-30' THEN 'Q3'
WHEN Hire_Date BETWEEN '2021-10-01' AND '2021-12-31' THEN 'Q4'
END AS Quarter
FROM EmployeeCompensation
ORDER BY [Quarter] DESC

-- List of Terminated Employees

SELECT *
FROM EmployeeCompensation
WHERE Termination_Date IS NOT NULL

-- Employees Who Exited the Company Within Their First Year

SELECT Name, Termination_Date
FROM EmployeeCompensation
WHERE Termination_Date IS NOT NULL
AND DATEDIFF(MONTH, Hire_Date, Termination_Date) < 12

-- Employees Who Have Left the Company and What is Their Average Tenure

SELECT COUNT(*) as EmployeeCount, AVG(DATEDIFF(MONTH, Hire_Date, Termination_Date)) as AvgTenureMonths
FROM EmployeeCompensation
WHERE Termination_Date IS NOT NULL

-- Employees Who Have Been With the Company for More Than 10 Years

SELECT Name, Hire_Date
FROM EmployeeCompensation
WHERE DATEDIFF(YEAR, Hire_Date, GETDATE()) >= 10
