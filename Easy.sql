/*
Show first name, last name, and gender of patients who's gender is 'M'
*/

SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M'

/*
Show first name and last name of patients who does not have allergies (null)
*/

SELECT first_name, last_name
FROM patients
WHERE allergies IS NULL

/*
Show first name of patients that start with the letter 'C'
*/

SELECT first_name
FROM patients
WHERE first_name like 'C%'

/*
Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
*/

SELECT first_name, last_name
FROM patients
WHERE weight between 100 and 120

/*
Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
*/

UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL

/*
Show first name and last name concatinated into one column to show their full name.
*/

SELECT concat (first_name, ' ', last_name)
FROM patients

/*
Show first name, last name, and the full province name of each patient.
Example: 'Ontario' instead of 'ON'
*/

SELECT P.first_name, P.last_name, PV.province_name
FROM patients P
INNER JOIN provinces PV ON PV.province_id = P.province_id

/*
Show how many patients have a birth_date with 2010 as the birth year.
*/

SELECT COUNT (*) as total_patients
FROM patients 	
WHERE YEAR(birth_date) = 2010
INNER JOIN provinces PV ON PV.province_id = P.province_id

/*
Show the first_name, last_name, and height of the patient with the greatest height.
*/

SELECT first_name, last_name, MAX (height)
FROM patients

/*
Show all columns for patients who have one of the following patient_ids:
1,45,534,879,1000
*/

SELECT *
FROM patients 	
WHERE patient_id IN (1, 45, 534, 879, 1000)

/*
Show the total number of admissions
*/

SELECT COUNT (patient_id)
FROM admissions

/*
Show all the columns from admissions where the patient was admitted and discharged on the same day.
*/

SELECT *
FROM admissions
WHERE admission_date = discharge_date

/*
Show the total number of admissions for patient_id 573.
*/

SELECT patient_id, COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id = 573;

/*
Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
*/

SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS'

