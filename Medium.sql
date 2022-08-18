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

/*
Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
Sort the list starting from the earliest birth_date.
*/

SELECT first_name, last_name, birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC

/*
We want to display each patient's full name in a single column. Their last_name in all upper 
letters must appear first, then first_name in all lower case letters. Separate the last_name and 
first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane
*/

SELECT concat(UPPER(last_name),',',LOWER(first_name)) AS "full_name"
FROM patients
ORDER BY first_name DESC

/*
Show the province_id(s), sum of height; where the total sum of its patient's height is greater than 
or equal to 7,000.
*/

SELECT province_id, SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING sum_height >= 7000

/*
Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
*/

SELECT (MAX(weight)-MIN(weight)) AS "weight_difference"
FROM patients
WHERE last_name = 'Maroni'

/*Show all of the month's day numbers and how many admission_dates occurred on that number. 
Sort by the day with most admissions to least admissions.
*/

SELECT DAY(admission_date) AS "day_number", COUNT(*) AS "number_of_admissions"
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC

/*
Show the patient_id, nursing_unit_id, room, and bed for patient_id 542's most recent admission_date.
*/

SELECT patient_id, nursing_unit_id, room, bed
FROM admissions
WHERE patient_id = 542 
GROUP BY patient_id
HAVING MAX(admission_date)

/*
Show the nursing_unit_id and count of admissions for each nursing_unit_id. Exclude the following 
nursing_unit_ids: 'CCU', 'OR', 'ICU', 'ER'.
*/

SELECT nursing_unit_id, COUNT(patient_id) AS "total_admission"
FROM admissions
WHERE nursing_unit_id NOT IN ('CCU', 'OR', 'ICU', 'ER')
GROUP BY nursing_unit_id

/*
Show patient_id, attending_physician_id, and primary_diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_physician_id is either 1, 5, or 19.
2. attending_physician_id contains a 2 and the length of patient_id is 3 characters.
*/

SELECT patient_id, attending_physician_id, primary_diagnosis
FROM admissions
WHERE (patient_id %2 = 1 AND attending_physician_id IN(1,5,19))
OR (attending_physician_id LIKE '%2%' AND LEN(patient_id) = 3)
