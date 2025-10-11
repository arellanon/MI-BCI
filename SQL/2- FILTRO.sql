-- 🔸 Definir parámetros
SET @dataset_param := 'D1';
SET @canales_param := '15CH';

-- 🔸 Por sujeto-sesión
SELECT  
    CONCAT(sujeto, '- ', sesion) AS sujeto_sesion,
    AVG(CASE WHEN Filtro = 'FI' THEN mean_test_accuracy END) AS FI_mean,
    STDDEV(CASE WHEN Filtro = 'FI' THEN mean_test_accuracy END) AS FI_std,
    AVG(CASE WHEN Filtro = 'NF' THEN mean_test_accuracy END) AS NF_mean,
    STDDEV(CASE WHEN Filtro = 'NF' THEN mean_test_accuracy END) AS NF_std
FROM DATASET
WHERE dataset = @dataset_param
  AND canales = @canales_param
GROUP BY sujeto, sesion

UNION

-- 🔸 Total global
SELECT  
    'Total' AS sujeto_sesion,
    AVG(CASE WHEN Filtro = 'FI' THEN mean_test_accuracy END) AS FI_mean,
    STDDEV(CASE WHEN Filtro = 'FI' THEN mean_test_accuracy END) AS FI_std,
    AVG(CASE WHEN Filtro = 'NF' THEN mean_test_accuracy END) AS NF_mean,
    STDDEV(CASE WHEN Filtro = 'NF' THEN mean_test_accuracy END) AS NF_std
FROM DATASET
WHERE dataset = @dataset_param
  AND canales = @canales_param
ORDER BY sujeto_sesion;
