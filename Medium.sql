/*
Show unique birth years from patients and order them by ascending.
*/

SELECT DISTINCT YEAR(birth_date)
FROM patients
ORDER BY YEAR(birth_date) ASC;

/*
Show unique first names from the patients table which only occurs once in the list.
For example, if two or more people are named 'John' in the first_name column then 
don't include their name in the output list. If only 1 person is named 'Leo' then 
include them in the output.
*/

SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

/*
Show patient_id and first_name from patients where their first_name start and ends with 
's' and is at least 6 characters long.
*/

SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's____%s';

/*
Show patient_id, first_name, last_name from patients whos primary_diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table.
*/

SELECT P.patient_id, P.first_name, P.last_name
FROM patients P
JOIN admissions A ON P.patient_id = A.patient_id
WHERE primary_diagnosis = 'Dementia';

/*
Display every patient's first_name.
Order the list by the length of each name and then by alphbetically
*/

SELECT first_name
FROM patients
ORDER BY len(first_name),first_name;

/*
Show the total amount of male patients and the total amount of female 
patients in the patients table.
Display the two results in the same row.
*/

SELECT
(SELECT COUNT(gender) FROM patients WHERE gender = 'M') AS Male,
(SELECT COUNT(gender) FROM patients WHERE gender = 'F') AS Female;

/*
Show first and last name, allergies from patients which have allergies to either 
'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by 
first_name then by last_name.
*/

SELECT first_name, last_name, allergies
FROM patients
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY allergies ASC, first_name ASC, last_name ASC;

/*
Show patient_id, primary_diagnosis from admissions. Find patients admitted multiple 
times for the same primary_diagnosis.
*/

SELECT patient_id, primary_diagnosis
FROM admissions
GROUP BY patient_id, primary_diagnosis
HAVING COUNT (*) > 1;

/*
Show the city and the total number of patients in the city in the order from most to 
least patients.
*/

SELECT city, COUNT (*) AS num_patients
FROM patients
GROUP BY city
ORDER BY num_patients DESC;

/*
Show first name, last name and role of every person that is either patient or physician.
The roles are either "Patient" or "Physician"
*/

SELECT first_name, last_name, "Patient" AS "Role" FROM patients
UNION
SELECT first_name, last_name, "Physician" FROM physicians;

/*
Show all allergies ordered by popularity. Remove 'NKA' and NULL values from query.
*/

SELECT allergies,COUNT(*) AS total_diagnosis
FROM patients
WHERE NOT allergies = 'NKA'AND allergies NOT NULL
GROUP BY allergies
ORDER BY total_diagnosis DESC

