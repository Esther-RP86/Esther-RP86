-- Highlight : this dataset is not an actual real-life healthcare dataset, it is a syntehtic healthcare dataset

-- Create and using database 
CREATE DATABASE healthcare;

USE healthcare;

-- Viewing unclean/dirty data after importing the healthcare dataset as table into the healthcare database created earlier and naming it as healthcare_dataset
SELECT *
FROM healthcare_dataset;

-- Data Validation & assigning appropriate data types and proper column names
ALTER TABLE healthcare_dataset
CHANGE Name name TEXT,
CHANGE Age age INT,
CHANGE Gender gender TEXT,
CHANGE `Blood Type` blood_type CHAR(3),
CHANGE `Medical Condition` medical_condition TEXT,
CHANGE `Date of Admission` admission_date DATE,
CHANGE Doctor doctor TEXT,
CHANGE Hospital hospital TEXT,
CHANGE `Insurance Provider` insurance_provider VARCHAR(100),
CHANGE `Billing Amount` billing_amount DOUBLE,
CHANGE `Room Number` room_number INT,
CHANGE `Admission Type` admission_type TEXT,
CHANGE `Discharge Date` discharge_date DATE,
CHANGE Medication medication VARCHAR(100),
CHANGE `Test Results` test_results TEXT;

-- Data Cleaning
UPDATE healthcare_dataset
SET name = CONCAT(UPPER(LEFT(name,1)),LOWER(SUBSTRING(name,2,POSITION(' ' IN name)-2)),' ',UPPER(SUBSTRING(name,POSITION(' ' IN name)+1,1)), LOWER(RIGHT(name,(LENGTH(name)-POSITION(' 'IN name)-1)))),
	billing_amount = ROUND(billing_amount, 2);

-- View cleaned dataset   
SELECT *
FROM healthcare_dataset;

-- SECTION 1: Data overview (by data aggregration and summarization) to provide basic insights into the data using data aggregation and summarization as well as basic statistics
-- Finding Mean age 
SELECT FLOOR(AVG(age)) AS mean_age
FROM healthcare_dataset;

-- Finding out the dataset is from which year to which year
SELECT MAX(YEAR(admission_date)), MIN(YEAR(admission_date))
FROM healthcare_dataset;

-- Finding the youngest and oldest patient
SELECT MAX(age) AS oldest, MIN(age) AS youngest
FROM healthcare_dataset;

-- Finding the ratio of male to female patients
WITH male_count AS 
	(SELECT COUNT(gender) AS male
	FROM healthcare_dataset
	WHERE gender = 'Male'),

   female_count AS 
	(SELECT COUNT(gender) AS female
	FROM healthcare_dataset
	WHERE gender = 'Female')
    
SELECT male/female
FROM male_count, female_count;

-- SECTION 2: Retrieve insights about age and medical condition (TO SEE if there is a pattern between age and number of medical conditoin)
-- Grouping cases of medical condition into age categories and finding the number of patients within each age group
SELECT medical_condition, 
		COUNT(CASE WHEN age < 30 THEN age END) AS below_30,
        COUNT(CASE WHEN age >= 30 AND age <= 60 THEN age END) AS from_30_to_60,
        COUNT(CASE WHEN age > 60 THEN age END) above_60
FROM healthcare_dataset
GROUP BY medical_condition;

-- Count of medical condition and mean age for each medical condition
SELECT medical_condition, COUNT(*) AS count_medical_condition, FLOOR(AVG(age)) AS mean_age
FROM healthcare_dataset
GROUP BY medical_condition
ORDER BY count_medical_condition DESC;

-- Finding the correlation between age and the number of medical condition for each age
	-- Step 1: Create a view showcasing age as x variable and number of medical condition as y variable
CREATE VIEW age_vs_medical_condition_record AS
SELECT age AS x, COUNT(*) AS y
FROM healthcare_dataset
GROUP BY age;
		
        -- Alter view to iclude mean age and the average for number of medical condition
ALTER VIEW age_vs_medical_condition_record AS
SELECT age AS x, COUNT(*) AS y, AVG(age)OVER() AS average_x, AVG(COUNT(*))OVER() AS average_y
FROM healthcare_dataset
GROUP BY age;

	-- Step 2: Verify the view
SELECT *
FROM age_vs_medical_condition_record
ORDER BY x;

	-- Step 3: calculate the pearson correlation coefficient
SELECT SUM((x-average_x)*(y-average_y))/SQRT(SUM((x-average_x)*(x-average_x))*SUM((y-average_y)*(y-average_y))) AS corr
FROM age_vs_medical_condition_record;

		-- Findings: result showed a weak positive correlation coefficient, approximately 0.0685


-- SECTION 3: patients inclined towards which insurance provider 
-- Number of Insurance Provider
SELECT COUNT(DISTINCT(insurance_provider))
FROM healthcare_dataset;

-- Highest count of insurance provider
SELECT insurance_provider,COUNT(*) AS count_insurance_provider
FROM healthcare_dataset
GROUP BY insurance_provider
ORDER BY count_insurance_provider DESC;

-- Average, minimum, and maximum billing amount for each insurance provider (excluding negative billing amount which might be due to billing mistakes)
SELECT insurance_provider, ROUND(AVG(billing_amount),2) AS average_billing_amount, MAX(billing_amount), MIN(billing_amount)
FROM healthcare_dataset
WHERE billing_amount > 0
GROUP BY insurance_provider;

-- SECTION 4: Patient care duration and test results as well as follow-up action to patient based on test results
-- Finding the average length of stay in the hospital for each test result outcome
SELECT AVG(DATEDIFF(discharge_date, admission_date)) AS average_length_of_stay, test_results
FROM healthcare_dataset
GROUP BY test_results;

-- Setting a reminder for patients (former and current) with abnormal and inconclusive test results
SELECT name, doctor, hospital,
(CASE WHEN test_results = 'Abnormal' THEN 'Require medical attention'
	WHEN test_results = 'Inconclusive' THEN 'Require further tests' END) AS reminders
FROM healthcare_dataset
WHERE test_results = 'Abnormal' OR test_results = 'Inconclusive';


-- SECTION 5: Yearly admission for each hospital (under performance especially for the urgent, emergency and elective admission type)
-- Number of admitted patients to each hospital (pivoting table using CASE statement) from 2019 to 2024
SELECT hospital,
	 COUNT(CASE WHEN YEAR(admission_date) = 2019 THEN hospital END) AS '2019',
      COUNT(CASE WHEN YEAR(admission_date) = 2020 THEN hospital END) AS '2020',
       COUNT(CASE WHEN YEAR(admission_date) = 2021 THEN hospital END) AS '2021',
        COUNT(CASE WHEN YEAR(admission_date) = 2022 THEN hospital END) AS '2022',
         COUNT(CASE WHEN YEAR(admission_date) = 2023 THEN hospital END) AS '2023',
          COUNT(CASE WHEN YEAR(admission_date) = 2024 THEN hospital END) AS '2024'
FROM healthcare_dataset
GROUP BY hospital;








    






