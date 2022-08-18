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

SELECT PT.patient_id, PT.first_name, PT.last_name, PH.specialty
FROM patients PT
JOIN admissions AD ON PT.patient_id= AD.patient_id 
JOIN physicians PH ON AD.attending_physician_id= PH.physician_id
WHERE primary_diagnosis = 'Dementia' AND PH.first_name = 'Lisa'

/*
All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a 
temporary password after their first admission. Show the patient_id and temp_password.
The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date
*/

SELECT DISTINCT P.patient_id, CONCAT(P.patient_id, LEN(P.last_name), YEAR(P.birth_date)) as "temp_password"
FROM patients P 
JOIN admissions A ON A.patient_id=P.patient_id

/*
Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients 
with an even patient_id have insurance.
Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the 
admission_total cost for each has_insurance group.
*/

SELECT
CASE WHEN patient_id %2 = 0 THEN 'Yes' ELSE 'No' END AS has_insurance,
SUM(CASE WHEN patient_id %2 = 0 THEN 10 ELSE 50 END) AS cost_ater_insurance
FROM admissions
GROUP BY has_insurance

/*
Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
*/

SELECT PR.province_name
FROM patients AS PA
JOIN provinces AS PR ON pa.province_id = PR.province_id
GROUP BY PR.province_name
HAVING COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT( CASE WHEN gender = 'F' THEN 1 END);

/*
We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Halifax'
*/


