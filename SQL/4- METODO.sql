-- 🔸 Definir parámetros
SET @dataset_param := 'D1';
SET @canales_param := '15CH';

-- 🔸 Por sujeto-sesión
SELECT  
    CONCAT(sujeto, '- ', sesion) AS sujeto_sesion,
    AVG(CASE WHEN method = 'CSP' THEN mean_test_accuracy END) AS CSP_mean,
    STDDEV(CASE WHEN method = 'CSP' THEN mean_test_accuracy END) AS CSP_std,
    AVG(CASE WHEN method = 'PFBCSP' THEN mean_test_accuracy END) AS PFBCSP_mean,
    STDDEV(CASE WHEN method = 'PFBCSP' THEN mean_test_accuracy END) AS PFBCSP_std,
    AVG(CASE WHEN method = 'PTFBCSP' THEN mean_test_accuracy END) AS PTFBCSP_mean,
    STDDEV(CASE WHEN method = 'PTFBCSP' THEN mean_test_accuracy END) AS PTFBCSP_std
FROM DATASET
WHERE dataset = @dataset_param
  AND canales = @canales_param
GROUP BY sujeto, sesion

UNION

-- 🔸 Total global
SELECT  
    'Total' AS sujeto_sesion,
    AVG(CASE WHEN method = 'CSP' THEN mean_test_accuracy END) AS CSP_mean,
    STDDEV(CASE WHEN method = 'CSP' THEN mean_test_accuracy END) AS CSP_std,
    AVG(CASE WHEN method = 'PFBCSP' THEN mean_test_accuracy END) AS PFBCSP_mean,
    STDDEV(CASE WHEN method = 'PFBCSP' THEN mean_test_accuracy END) AS PFBCSP_std,
    AVG(CASE WHEN method = 'PTFBCSP' THEN mean_test_accuracy END) AS PTFBCSP_mean,
    STDDEV(CASE WHEN method = 'PTFBCSP' THEN mean_test_accuracy END) AS PTFBCSP_std
FROM DATASET
WHERE dataset = @dataset_param
  AND canales = @canales_param
ORDER BY sujeto_sesion;
