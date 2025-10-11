-- 🔸 Definir parámetros
SET @dataset_param := 'D1';
SET @canales_param := '15CH';

-- 🔸 Por configuración de datos
SELECT  
    CONCAT(Canales, ' - ', Tiempo, ' - ', Filtro) AS configuracion_datos,
    AVG(CASE WHEN method = 'CSP' AND classification = 'LDA' THEN mean_test_accuracy END) AS CSP_LDA,
    AVG(CASE WHEN method = 'CSP' AND classification = 'SVM' THEN mean_test_accuracy END) AS CSP_SVM,
    AVG(CASE WHEN method = 'CSP' AND classification = 'KNN' THEN mean_test_accuracy END) AS CSP_KNN,
    AVG(CASE WHEN method = 'CSP' AND classification = 'ANN' THEN mean_test_accuracy END) AS CSP_ANN,

    AVG(CASE WHEN method = 'PFBCSP' AND classification = 'LDA' THEN mean_test_accuracy END) AS PFBCSP_LDA,
    AVG(CASE WHEN method = 'PFBCSP' AND classification = 'SVM' THEN mean_test_accuracy END) AS PFBCSP_SVM,
    AVG(CASE WHEN method = 'PFBCSP' AND classification = 'KNN' THEN mean_test_accuracy END) AS PFBCSP_KNN,
    AVG(CASE WHEN method = 'PFBCSP' AND classification = 'ANN' THEN mean_test_accuracy END) AS PFBCSP_ANN,

    AVG(CASE WHEN method = 'PTFBCSP' AND classification = 'LDA' THEN mean_test_accuracy END) AS PTFBCSP_LDA,
    AVG(CASE WHEN method = 'PTFBCSP' AND classification = 'SVM' THEN mean_test_accuracy END) AS PTFBCSP_SVM,
    AVG(CASE WHEN method = 'PTFBCSP' AND classification = 'KNN' THEN mean_test_accuracy END) AS PTFBCSP_KNN,
    AVG(CASE WHEN method = 'PTFBCSP' AND classification = 'ANN' THEN mean_test_accuracy END) AS PTFBCSP_ANN
FROM DATASET
WHERE dataset = @dataset_param
  AND canales = @canales_param
GROUP BY CONCAT(Canales, ' - ', Tiempo, ' - ', Filtro)
ORDER BY configuracion_datos;
