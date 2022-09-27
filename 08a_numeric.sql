-- 1

SELECT A_STRONGLY_AGREE
  FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science';

-- 2

SELECT institution, subject
  FROM nss
 WHERE question='Q15'
   AND score >= 100;

-- 3

SELECT institution, score
  FROM nss
 WHERE question='Q15'
   AND score < 50
   AND subject='(8) Computer Science';

-- 4

SELECT subject, SUM(response) AS total_responses
  FROM nss
 WHERE question= 'Q22'
   AND (subject= '(8) Computer Science'
   OR subject = '(H) Creative Arts and Design')
GROUP BY subject;

-- 5 Show the subject and total number of students who A_STRONGLY_AGREE to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.

SELECT subject, SUM(A_STRONGLY_AGREE * response / 100)
  FROM nss
 WHERE question='Q22'
   AND (subject =  '(H) Creative Arts and Design'
   OR subject='(8) Computer Science')
GROUP BY subject;

-- 6 Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject '(8) Computer Science' show the same figure for the subject '(H) Creative Arts and Design'. Use the ROUND function to show the percentage without decimal places.

SELECT subject, ROUND(SUM(response * A_STRONGLY_AGREE / 100) / SUM(response) * 100, 0) AS percentage
  FROM nss
 WHERE question='Q22'
   AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;


-- 7

SELECT institution, ROUND(SUM(response * score / 100) / SUM(response) * 100, 0) AS percentage
  FROM nss
 WHERE question='Q22'
   AND (institution LIKE '%Manchester%')
GROUP BY institution;

-- 8 Show the institution, the total sample size and the number of computing students for institutions in Manchester for 'Q01'. 

SELECT institution, SUM(sample) AS total_sample, 
  (SELECT sample FROM nss AS y
  WHERE subject = '(8) Computer Science'
  AND x.institution = y.institution
  AND question = 'Q01') AS comp_stud
  FROM nss AS x
 WHERE question='Q01'
   AND institution LIKE '%Manchester%'
GROUP BY institution; 