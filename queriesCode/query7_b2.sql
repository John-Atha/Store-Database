-- posa episkeptetai

SELECT COUNT(DISTINCT(`Store_id`))
FROM `Transaction`
WHERE `Transaction`.`Card#` = 4