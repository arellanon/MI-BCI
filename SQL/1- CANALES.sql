-- 🔸 Definir parámetro
SET @dataset_param := 'D1';

-- 🔸 Por sujeto
SELECT  
    sujeto,
    AVG(CASE WHEN Canales = '15CH' THEN mean_test_accuracy END) AS `15CH_mean`,
    STDDEV(CASE WHEN Canales = '15CH' THEN mean_test_accuracy END) AS `15CH_std`,
    AVG(CASE WHEN Canales = '8ACH' THEN mean_test_accuracy END) AS `8ACH_mean`,
    STDDEV(CASE WHEN Canales = '8ACH' THEN mean_test_accuracy END) AS `8ACH_std`,
    AVG(CASE WHEN Canales = '8BCH' THEN mean_test_accuracy END) AS `8BCH_mean`,
    STDDEV(CASE WHEN Canales = '8BCH' THEN mean_test_accuracy END) AS `8BCH_std`
FROM DATASET
WHERE dataset = @dataset_param
GROUP BY sujeto

UNION

-- 🔸 Total global
SELECT  
    'Total' AS sujeto,
    AVG(CASE WHEN Canales = '15CH' THEN mean_test_accuracy END) AS `15CH_mean`,
    STDDEV(CASE WHEN Canales = '15CH' THEN mean_test_accuracy END) AS `15CH_std`,
    AVG(CASE WHEN Canales = '8ACH' THEN mean_test_accuracy END) AS `8ACH_mean`,
    STDDEV(CASE WHEN Canales = '8ACH' THEN mean_test_accuracy END) AS `8ACH_std`,
    AVG(CASE WHEN Canales = '8BCH' THEN mean_test_accuracy END) AS `8BCH_mean`,
    STDDEV(CASE WHEN Canales = '8BCH' THEN mean_test_accuracy END) AS `8BCH_std`
FROM DATASET
WHERE dataset = @dataset_param
ORDER BY sujeto;
