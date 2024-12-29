/*
Tema: Satisfacción académica y laboral por género y ciudad
Pregunta: ¿Cuál es el promedio de satisfacción académica y laboral por género y ciudad?
*/

{{
  config(
    materialized='view',
    schema='luchoproject'
  )
}}

SELECT 
    Gender,
    City,
    AVG(StudySatisfaction) AS Avg_StudySatisfaction,
    AVG(JobSatisfaction) AS Avg_JobSatisfaction
FROM {{ ref('staging') }}
GROUP BY 
    Gender,
    City

