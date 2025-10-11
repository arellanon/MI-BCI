-- 🔸 Definir parámetros
SET @dataset_param := 'D1';
SET @canales_param := '15CH';

-- 🔸 Query por sujeto-sesión y total
SELECT  
    CONCAT(sujeto, '- ', sesion) AS sujeto_sesion,
    AVG(CASE WHEN Tiempo = '2S' THEN mean_test_accuracy END) AS `2S_mean`,
    STDDEV(CASE WHEN Tiempo = '2S' THEN mean_test_accuracy END) AS `2S_std`,
    AVG(CASE WHEN Tiempo = '4S' THEN mean_test_accuracy END) AS `4S_mean`,
    STDDEV(CASE WHEN Tiempo = '4S' THEN mean_test_accuracy END) AS `4S_std`
FROM DATASET
WHERE dataset = @dataset_param
  AND canales = @canales_param
GROUP BY sujeto, sesion

UNION

SELECT  
    'Total' AS sujeto_sesion,
    AVG(CASE WHEN Tiempo = '2S' THEN mean_test_accuracy END) AS `2S_mean`,
    STDDEV(CASE WHEN Tiempo = '2S' THEN mean_test_accuracy END) AS `2S_std`,
    AVG(CASE WHEN Tiempo = '4S' THEN mean_test_accuracy END) AS `4S_mean`,
    STDDEV(CASE WHEN Tiempo = '4S' THEN mean_test_accuracy END) AS `4S_std`
FROM DATASET
WHERE dataset = @dataset_param
  AND canales = @canales_param
ORDER BY sujeto_sesion;
