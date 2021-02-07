-- top 5 dhmofilh proionta se kathe polh kai poses fores exei agorastei to kathena ekei

(SELECT `Stores`.`Store_City`, `Contains`.`Barcode`, SUM(`Contains`.`Pieces`) as `counter`
				FROM  `Contains`, `Transaction`, `Stores`
				WHERE `Contains`.`DateTime` = `Transaction`.`DateTime`
				and   `Contains`.`Card#` = `Transaction`.`Card#`
                and   `Stores`.`Store_id` = `Transaction`.`Store_id`
                and   `Stores`.`Store_City` = 'Suncity'
				group by `Contains`.`Barcode`
                order by  `counter` desc limit 5)
union

(SELECT `Stores`.`Store_City`, `Contains`.`Barcode`, SUM(`Contains`.`Pieces`) as `counter`
				FROM  `Contains`, `Transaction`, `Stores`
				WHERE `Contains`.`DateTime` = `Transaction`.`DateTime`
				and   `Contains`.`Card#` = `Transaction`.`Card#`
                and   `Stores`.`Store_id` = `Transaction`.`Store_id`
                and   `Stores`.`Store_City` = 'Lagonhsi'
				group by `Contains`.`Barcode`
                order by  `counter` desc limit 5)
                
union

(SELECT `Stores`.`Store_City`, `Contains`.`Barcode`, SUM(`Contains`.`Pieces`) as `counter`
				FROM  `Contains`, `Transaction`, `Stores`
				WHERE `Contains`.`DateTime` = `Transaction`.`DateTime`
				and   `Contains`.`Card#` = `Transaction`.`Card#`
                and   `Stores`.`Store_id` = `Transaction`.`Store_id`
                and   `Stores`.`Store_City` = 'Dafni'
				group by `Contains`.`Barcode`
                order by  `counter` desc limit 5)

