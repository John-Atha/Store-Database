SELECT (time(`Transaction`.`DateTime`)- interval minute(`Transaction`.`DateTime`) minute - interval second(`Transaction`.`DateTime`) second) as `Starting hour`,
(TIME(`Transaction`.`DateTime`) + interval 1 hour - interval minute(`Transaction`.`DateTime`) minute - interval second(`Transaction`.`DateTime`) second) as `Ending hour`,
                          (COUNT(*) )
                          as `Sum 3`
FROM `Transaction`, `Customer`
WHERE `Transaction`.`Card#` = 4 AND `Transaction`.`Store_id` = 3 GROUP BY HOUR(`Transaction`.`DateTime`)
order by `Starting hour` ASC