-- emfanizei se xronika diasthmata 1 wras, emfanizw ola ta diasthmata se fthinousa seira me vash ta total_amounts pou jodeuthkan
-- to provlhma einai oti ypologizoume synexws to COUNT(`Transaction`.`Card#`)), giati den to anagnwrizei ws hdh ypologismeno gia na mpei stis diaireseis
-- epeidh einai sto idio select


SELECT (time(`Transaction`.`DateTime`)- interval minute(`Transaction`.`DateTime`) minute - interval second(`Transaction`.`DateTime`) second) as `Starting hour`,
		(TIME(`Transaction`.`DateTime`) + interval 1 hour - interval minute(`Transaction`.`DateTime`) minute - interval second(`Transaction`.`DateTime`) second) as `Ending hour`,
															(SUM(CASE 
																WHEN `Customer`.`Age` BETWEEN 18 AND 30 
																THEN 1 
																ELSE 0 
																END ) /  COUNT(`Transaction`.`Card#`))
															as `18-30 y.o.`, 
															(SUM(CASE 
																WHEN `Customer`.`Age` BETWEEN 31 AND 50 
																THEN 1 
																ELSE 0 
																END) /  COUNT(`Transaction`.`Card#`))
                                                            as `31-50 y.o.`, 
															(SUM(CASE 
																WHEN `Customer`.`Age` BETWEEN 51 AND 70 
																THEN 1 
																ELSE 0 
																END) /  COUNT(`Transaction`.`Card#`))
                                                            as `51-70 y.o.`,
															(SUM(CASE 
																WHEN `Customer`.`Age` > 70 
																THEN 1 
																ELSE 0 
																END) /  COUNT(`Transaction`.`Card#`))
                                                            as `70+ y.o.`
FROM `Transaction`, `Customer`
WHERE `Transaction`.`Card#` = `Customer`.`Card#`

GROUP BY HOUR(`Transaction`.`DateTime`)
order by `Starting hour` ASC
	

	