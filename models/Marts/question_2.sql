/*
Tema: Distribución de horas de estudio/trabajo según presión
Pregunta: ¿Cómo se distribuyen las horas de estudio/trabajo según la presión académica y laboral?
*/

{{
  config(
    materialized='view',
    schema='luchoproject'
  )
}}

SELECT 
    AcademicPressure,
    WorkPressure,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY WorkStudyHours) AS Median_WorkStudyHours,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY WorkStudyHours) AS Q3_WorkStudyHours,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY WorkStudyHours) AS Q1_WorkStudyHours
FROM {{ ref('staging') }}
GROUP BY 
    AcademicPressure,
    WorkPressure
