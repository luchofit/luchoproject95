/*
Tema: Correlación entre antecedentes familiares y pensamientos suicidas
Pregunta: ¿Qué porcentaje de estudiantes con antecedentes familiares de enfermedades mentales ha tenido pensamientos suicidas?
*/

{{
  config(
    materialized='view',
    schema='luchoproject'
  )
}}

SELECT 
    FamilyHistoryOfMentalIllness,
    100.0 * SUM(CASE WHEN SuicidalThoughts THEN 1 ELSE 0 END) / COUNT(*) AS SuicidalThoughtsPercentage
FROM {{ ref('staging') }}
GROUP BY 
    FamilyHistoryOfMentalIllness
