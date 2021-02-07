-- kai me tropo plhrwmhs

SELECT *
FROM `Transaction`
WHERE `Transaction`.`Store_id` = 4
   and `Transaction`.`DateTime` BETWEEN '2000-01-01' AND '2010-03-04'
   and `Payment_method` = 'Cash'