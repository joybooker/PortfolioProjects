/* Emergency Room Data Exploration */

-- Split Date/Time Column into two separate columns

SELECT *,
CONVERT(VARCHAR(20), [date], 101) AS DATEPART,
CONVERT(VARCHAR(20), [date], 108) AS TIMEPART
FROM EmergencyRoom

-- Create Age Group Column

ALTER TABLE EmergencyRoom
ADD Age_Group varchar(50)
GO

UPDATE EmergencyRoom
SET Age_Group =   CASE WHEN patient_age <=17 THEN '0-17'
WHEN patient_age BETWEEN 18 AND 24 THEN '18-24'
WHEN patient_age BETWEEN 25 AND 39 THEN '25-39'
WHEN patient_age BETWEEN 40 AND 54 THEN '40-54'
WHEN patient_age BETWEEN 55 AND 64 THEN '55-64'
ELSE '65+'
END

-- Which age group visited the ER more?

SELECT Age_Group,
COUNT (patient_id) AS Total_Age_Group
FROM EmergencyRoom
GROUP BY Age_Group
ORDER BY Total_Age_Group DESC

-- Which race visited the ER more?

SELECT patient_race,
COUNT (patient_id) AS Total_Patients
FROM EmergencyRoom
GROUP BY patient_race
ORDER BY Total_Patients DESC

-- Which gender visited the ER more?

SELECT patient_gender,
COUNT (patient_id) AS Total_Patients_Gender
FROM EmergencyRoom
GROUP BY patient_gender
ORDER BY Total_Patients_Gender DESC

-- Average Wait Time for all Patients

SELECT AVG(patient_waittime) AS AvgWaitTime
FROM EmergencyRoom

-- Average Wait Time by Age Group

SELECT Age_Group,
AVG(patient_waittime) as AvgWait
FROM EmergencyRoom
GROUP BY Age_Group

-- Average Wait Time by Race

SELECT patient_race,
AVG(patient_waittime) as AvgWait
FROM EmergencyRoom
GROUP BY patient_race

-- Average Satisfaction Rating for all Patients

SELECT AVG(patient_sat_score) as AvgSatScore
FROM EmergencyRoom

-- Average Satisfaction Rating by Age Group

SELECT Age_Group,
AVG(patient_sat_score) as AvgSatScore
FROM EmergencyRoom
GROUP BY Age_Group

-- Average Satisfaction Rating by Race

SELECT patient_race,
AVG(patient_sat_score) as AvgSatScore
FROM EmergencyRoom
GROUP BY patient_race

-- Which Deparment Receives the Most Referrals & the Least?

SELECT department_referral,
COUNT (patient_id) AS PatientsPerDepartment
FROM EmergencyRoom
GROUP BY department_referral
ORDER BY PatientsPerDepartment DESC

-- Average Wait Time vs Average Satisfaction Score

SELECT patient_id,
    AVG(patient_waittime) AS average_wait_time,
    AVG(patient_sat_score) AS average_satisfaction_score
    FROM EmergencyRoom
    GROUP BY patient_id
   ORDER BY average_wait_time DESC