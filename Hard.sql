/*
Show all of the patients grouped into weight groups.
Show the total amount of patients in each weight group.
Order the list by the weight group decending.
For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
*/

SELECT COUNT(*) AS patients_in_group, FLOOR(weight / 10) * 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

/*
Show patient_id, weight, height, isObese from the patients table.
Display isObese as a boolean 0 or 1.
Obese is defined as weight(kg)/(height(m)2) >= 30.
weight is in units kg.
height is in units cm.
*/

SELECT patient_id, weight, height, 
(CASE WHEN weight/(POWER(height/100.0,2)) >= 30 THEN 1 ELSE 0 END) AS isObese
FROM patients;

/*

Show patient_id, first_name, last_name, and attending physician's specialty.
Show only the patients who has a primary_diagnosis as 'Dementia' and the physician's first name is 'Lisa'
Check patients, admissions, and physicians tables for required information.
*/

