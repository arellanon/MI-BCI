-- 🔸 Definir parámetros
SET @dataset_param := 'D1';
SET @canales_param := '15CH';

-- 🔸 Por sujeto-sesión
SELECT  
    CONCAT(sujeto, '- ', sesion) AS sujeto_sesion,
    AVG(CASE WHEN classification = 'LDA' THEN mean_test_accuracy END) AS LDA_mean,
    STDDEV(CASE WHEN classification = 'LDA' THEN mean_test_accuracy END) AS LDA_std,
    AVG(CASE WHEN classification = 'SVM' THEN mean_test_accuracy END) AS SVM_mean,
    STDDEV(CASE WHEN classification = 'SVM' THEN mean_test_accuracy END) AS SVM_std,
    AVG(CASE WHEN classification = 'KNN' THEN mean_test_accuracy END) AS KNN_mean,
    STDDEV(CASE WHEN classification = 'KNN' THEN mean_test_accuracy END) AS KNN_std,
    AVG(CASE WHEN classification = 'ANN' THEN mean_test_accuracy END) AS ANN_mean,
    STDDEV(CASE WHEN classification = 'ANN' THEN mean_test_accuracy END) AS ANN_std
FROM DATASET
WHERE dataset = @dataset_param
  AND canales = @canales_param
GROUP BY sujeto, sesion

UNION

-- 🔸 Total global
SELECT  
    'Total' AS sujeto_sesion,
    AVG(CASE WHEN classification = 'LDA' THEN mean_test_accuracy END) AS LDA_mean,
    STDDEV(CASE WHEN classification = 'LDA' THEN mean_test_accuracy END) AS LDA_std,
    AVG(CASE WHEN classification = 'SVM' THEN mean_test_accuracy END) AS SVM_mean,
    STDDEV(CASE WHEN classification = 'SVM' THEN mean_test_accuracy END) AS SVM_std,
    AVG(CASE WHEN classification = 'KNN' THEN mean_test_accuracy END) AS KNN_mean,
    STDDEV(CASE WHEN classification = 'KNN' THEN mean_test_accuracy END) AS KNN_std,
    AVG(CASE WHEN classification = 'ANN' THEN mean_test_accuracy END) AS ANN_mean,
    STDDEV(CASE WHEN classification = 'ANN' THEN mean_test_accuracy END) AS ANN_std
FROM DATASET
WHERE dataset = @dataset_param
  AND canales = @canales_param
ORDER BY sujeto_sesion;
