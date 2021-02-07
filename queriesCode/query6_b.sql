-- agores sto katasthma 1 kai se xroniko parathyro

SELECT *
FROM `Transaction`
WHERE `Transaction`.`Store_id` = 1
   and `Transaction`.`DateTime` BETWEEN '2000-01-01' AND '2010-03-04'