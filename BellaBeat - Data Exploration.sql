-- Add day of week column
ALTER TABLE DailyActivity_Merged
ADD Day_Of_Week varchar(50)

-- Extract datename from ActivityDate
UPDATE DailyActivity_Merged
SET Day_Of_Week = DATENAME(DW, ActivityDate)

-- AVG ACTIVE MINUTES & AVG TOTAL CALORIES BY DAY OF THE WEEK

SELECT Day_Of_Week,
  AVG(VeryActiveMinutes) AS AVG_Very_Active_Minutes,
  AVG(Calories) AS AVG_TotalCalories
FROM DailyActivity_Merged
GROUP BY Day_Of_Week
ORDER BY AVG_Very_Active_Minutes DESC

-- Combine columns from SleepDay table to DailyActivity table

ALTER TABLE DailyActivity_Merged
ADD Total_Minutes_Asleep int,
Total_Time_In_Bed int;
GO
UPDATE DailyActivity_Merged
SET Total_Minutes_Asleep = temp2.TotalMinutesAsleep,
Total_Time_In_Bed = temp2.TotalTimeInBed 
From DailyActivity_Merged AS temp1
FULL OUTER JOIN SleepDay_Merged AS temp2
ON temp1.id = temp2.id AND temp1.ActivityDate = temp2.SleepDay;

-- Merge HourlyCalories table and HourlySteps table with HourlyIntensities table

ALTER TABLE HourlyIntensities_Merged
ADD Calories int;
GO
UPDATE HourlyIntensities_Merged
SET Calories = temp2.Calories
FROM HourlyIntensities_Merged AS temp1
FULL OUTER JOIN HourlyCalories_Merged AS temp2
ON temp1.id = temp2.id AND temp1.ActivityDate = temp2.ActivityDate AND temp1.Time = temp2.Time;

ALTER TABLE HourlyIntensities_Merged
ADD StepTotal int;
GO
UPDATE HourlyIntensities_Merged
SET StepTotal = temp2.StepTotal
FROM HourlyIntensities_Merged AS temp1
FULL OUTER JOIN HourlySteps_Merged AS temp2
ON temp1.id = temp2.id AND temp1.ActivityDate = temp2.StepDate AND temp1.Time = temp2.StepTime;

SELECT *
FROM HourlyIntensities_Merged

-- Participant FitBit Usage -- shows a total of 33 participants and how many time they used their FitBit 04/12/16 - 5/12/16

SELECT Id,
COUNT (Id) AS Total_Id
FROM DailyActivity_Merged
GROUP BY Id
ORDER BY Total_Id DESC

-- Breakdown user types by how often they used their FitBit

SELECT Id,
COUNT(Id) AS Total_Uses,
CASE
WHEN COUNT(Id) BETWEEN 21 AND 31 THEN 'Frequent User'
WHEN COUNT(Id) BETWEEN 11 and 20 THEN 'Casual User'
WHEN COUNT(Id) BETWEEN 0 and 10 THEN 'Occasional User'
END Fitbit_User_Type
FROM DailyActivity_Merged
GROUP BY Id
ORDER BY Total_Uses DESC

-- Calculate time spent on activity per day

SELECT DISTINCT Id, SUM(SedentaryMinutes) AS Sedentary_mins,
SUM(LightlyActiveMinutes) AS Lightly_Active_Mins,
SUM(FairlyActiveMinutes) AS Fairly_Active_Mins, 
SUM(VeryActiveMinutes) AS Very_Active_Mins
FROM DailyActivity_Merged
WHERE Total_Time_In_Bed IS NOT NULL
GROUP BY Id

-- Daily Average analysis

SELECT AVG(TotalSteps) AS Avg_Steps,
AVG(TotalDistance) AS Avg_Distance,
AVG(Calories) AS Avg_Calories,
Day_Of_Week
From DailyActivity_Merged
Group By  Day_Of_Week

--Activity duration and colories burned comparison

SELECT Id,
SUM(TotalSteps) AS Total_Steps,
SUM(VeryActiveMinutes) AS Total_Very_Active_Mins,
Sum(FairlyActiveMinutes) AS Total_Fairly_Active_Mins,
SUM(LightlyActiveMinutes) AS Total_Lightly_Active_Mins,
SUM(Calories) AS Total_Calories
From DailyActivity_Merged
Group By Id

-- Calories, Steps & Active Minutes by ID 

SELECT Id, 
SUM(TotalSteps) AS Sum_Total_Steps,
SUM(Calories) AS Sum_Calories, 
SUM (VeryActiveMinutes + FairlyActiveMinutes) AS Sum_Active_Minutes
FROM DailyActivity_Merged
GROUP BY Id

-- Total Steps by Day

SELECT Day_Of_Week,
ROUND (avg(TotalSteps), 2) AS Average_Total_Steps
FROM DailyActivity_Merged
GROUP BY Day_Of_Week
ORDER BY Average_Total_Steps DESC 

-- Total Steps by Hour

SELECT [Time],
SUM(StepTotal) AS Total_Steps_By_Hour
FROM HourlyIntensities_Merged
GROUP BY [Time]
ORDER BY Total_Steps_By_Hour DESC

-- Which date did users sleep the most

SELECT SleepDay,
SUM(TotalMinutesAsleep) AS Total_Minutes_Asleep
FROM SleepDay_Merged
WHERE SleepDay IS NOT NULL
GROUP BY SleepDay 
ORDER BY Total_Minutes_Asleep DESC

--Average Sleep Time per user

SELECT Id, AVG(Total_Minutes_Asleep)/60 AS Avg_Sleep_Time_Hour,
AVG(Total_Time_In_Bed)/60 AS Avg_Time_Bed_Hour,
AVG(Total_Time_In_Bed - Total_Minutes_Asleep) AS Wasted_Timed_In_Bed
FROM DailyActivity_Merged
Group by Id

-- Average minutes slept, total steps, and calories by user ID

SELECT Id,
AVG(TotalSteps) AS AvgTotalSteps,
AVG(Calories) AS AvgCalories,
AVG(Total_Minutes_Asleep) AS AvgTotalMinutesAsleep
FROM DailyActivity_Merged
GROUP BY Id
