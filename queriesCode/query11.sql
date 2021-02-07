-- emfanizei se xronika diasthmata 1 wras, emfanizw ola ta diasthmata se fthinousa seira me vash ta total_amounts pou jodeuthkan, TOP 5

SELECT (time(`Transaction`.`DateTime`)- interval minute(`Transaction`.`DateTime`) minute - interval second(`Transaction`.`DateTime`) second) as `Starting hour`,
		(TIME(`Transaction`.`DateTime`) + interval 1 hour - interval minute(`Transaction`.`DateTime`) minute - interval second(`Transaction`.`DateTime`) second) as `Ending hour`,
        SUM(`Transaction`.`Total_amount`) as `Total amount spent`
FROM `Transaction`
GROUP BY HOUR(`Transaction`.`DateTime`)
order by `Total amount spent` DESC LIMIT 5
	