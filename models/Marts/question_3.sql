/*
Tema: Relación entre hábitos alimenticios y depresión
Pregunta: ¿Existe una relación entre hábitos alimenticios y depresión?
*/

{{
  config(
    materialized='view',
    schema='luchoproject'
  )
}}

SELECT 
    DietaryHabits,
    AVG(Depression) AS Avg_DepressionScore
FROM {{ ref('staging') }}
GROUP BY 
    DietaryHabits
HAVING AVG(Depression) > 0
