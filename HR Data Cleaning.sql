/*creating database*/
CREATE DATABASE projects;
USE projects;

/*checking the data*/
SELECT * FROM hr;

SELECT count(*) FROM hr;

/*changing the column id name*/
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

/*checking the datatype of all columns*/
DESCRIBE hr;

SELECT birthdate FROM hr;

SET sql_safe_updates = 0;


/*changing the format of column birthdate data*/
UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

/*changing the datatype of birthdate column*/
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

SELECT birthdate FROM hr;

/*changing the format of column hire_date data*/
UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

/*changing the datatype of birthdate column*/
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT hire_date FROM hr;

/*changing the format and data of termdate column*/
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate FROM hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

/*changing the datatype of column termdate*/
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

/*Adding new column age*/
ALTER TABLE hr 
ADD COLUMN age INT;

SELECT * FROM hr;

/*calculating age and adding it to age column*/
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM hr;

SELECT
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

/*checking how many employees are less than age 18 in the dataset. These are not correct values*/
SELECT count(*) FROM hr WHERE age < 18;

/*Checking no of employees whose term end date in future*/
SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

/*Checking no of employees who is currently working */
SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';

SELECT location FROM hr;