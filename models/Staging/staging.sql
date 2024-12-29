/** 
 * Author:          Luis Castro
 * Date:            28/12/2024            
 * Description:     Cleaning of Mental healt dataset                              
 *             
*/

{{
  config(
    materialized='table',
    schema = 'luchoproject',
    transient = true
  )
}}

SELECT
    id,
    -- Limpiar y normalizar el género
    CASE 
        WHEN LOWER(Gender) IN ('male', 'm', 'man') THEN 'Male'
        WHEN LOWER(Gender) IN ('female', 'f', 'woman') THEN 'Female'
        ELSE 'Other'
    END AS Gender,
    
    -- Filtrar edades válidas (por ejemplo, entre 10 y 100 años)
    CASE 
        WHEN Age BETWEEN 10 AND 100 THEN Age 
        ELSE NULL 
    END AS Age,
    
    -- Limpiar texto de la ciudad (quitando espacios en blanco extra)
    TRIM(City) AS City,
    
    -- Limpiar texto de la profesión y normalizar mayúsculas
    INITCAP(TRIM(Profession)) AS Profession,
    
    -- Asegurarse de que la presión académica y laboral tenga valores válidos (0-10)
    CASE 
        WHEN AcademicPressure BETWEEN 0 AND 10 THEN AcademicPressure 
        ELSE NULL 
    END AS AcademicPressure,
    CASE 
        WHEN WorkPressure BETWEEN 0 AND 10 THEN WorkPressure 
        ELSE NULL 
    END AS WorkPressure,
    
    -- Asegurarse de que CGPA esté en el rango esperado (0.0 - 4.0)
    CASE 
        WHEN CGPA BETWEEN 0.0 AND 4.0 THEN CGPA 
        ELSE NULL 
    END AS CGPA,
    
    -- Validar satisfacción de estudio y trabajo (0-10)
    CASE 
        WHEN StudySatisfaction BETWEEN 0 AND 10 THEN StudySatisfaction 
        ELSE NULL 
    END AS StudySatisfaction,
    CASE 
        WHEN JobSatisfaction BETWEEN 0 AND 10 THEN JobSatisfaction 
        ELSE NULL 
    END AS JobSatisfaction,
    
    -- Normalizar duración del sueño a un formato estándar
    CASE 
        WHEN LOWER(SleepDuration) LIKE '%<4%' THEN 'Less than 4 hours'
        WHEN LOWER(SleepDuration) LIKE '%4-6%' THEN '4-6 hours'
        WHEN LOWER(SleepDuration) LIKE '%6-8%' THEN '6-8 hours'
        WHEN LOWER(SleepDuration) LIKE '%>8%' THEN 'More than 8 hours'
        ELSE 'Unknown'
    END AS SleepDuration,
    
    -- Limpiar hábitos dietéticos (normalizar texto)
    INITCAP(TRIM(DietaryHabits)) AS DietaryHabits,
    
    -- Normalizar el título académico
    INITCAP(TRIM(Degree)) AS Degree,
    
    -- Validar horas de trabajo/estudio (por ejemplo, entre 0 y 24 horas diarias)
    CASE 
        WHEN WorkStudyHours BETWEEN 0 AND 24 THEN WorkStudyHours 
        ELSE NULL 
    END AS WorkStudyHours,
    
    -- Validar nivel de estrés financiero (0-10)
    CASE 
        WHEN FinancialStress BETWEEN 0 AND 10 THEN FinancialStress 
        ELSE NULL 
    END AS FinancialStress,
    
    -- Dejar los valores booleanos como están (asumen ser consistentes)
    "Have you ever had suicidal thoughts ?" AS SuicidalThoughts,
    FamilyHistoryOfMentalIllness,
    
    -- Validar nivel de depresión (0-10)
    CASE 
        WHEN Depression BETWEEN 0 AND 10 THEN Depression 
        ELSE NULL 
    END AS Depression
FROM 
    {{ source('luchoproject', 'MentalHealthSurvey') }}
    -- Note: no poner ; al final del codigo porque saldrá posiblemente un error de compilación
