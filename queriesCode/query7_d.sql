-- synallages teleutaias bdomadas gia ton card# = 4

SELECT AVG(`Amounts`.`Total_amount`)
FROM
(SELECT `Transaction`.`Total_amount`
FROM `Transaction`
WHERE DATE(`Transaction`.`DateTime`) BETWEEN DATE(CURDATE()-INTERVAL 7 DAY) AND DATE(CURDATE())) as `Amounts`

