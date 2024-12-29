/*
Tema: Satisfacción por profesión
Pregunta: ¿Qué grupo profesional tiene mayores niveles de satisfacción en sus estudios o trabajo?
*/
{{
  config(
    materialized='view',
    schema='luchoproject'
  )
}}

SELECT 
    Profession,
    AVG(StudySatisfaction) AS Avg_StudySatisfaction,
    AVG(JobSatisfaction) AS Avg_JobSatisfaction
FROM {{ ref('staging') }}
GROUP BY 
    Profession
ORDER BY 
    Avg_StudySatisfaction DESC,
    Avg_JobSatisfaction DESC
