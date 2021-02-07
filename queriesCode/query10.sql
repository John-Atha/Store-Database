-- POSOSTO POU EMPISTEUONTAI ETIKETES SE KATHE CATEGORY

	SELECT `Labels`.`Category_id`, (`Labels`.`Counter1` / `All`.`Counter2`) as `labels trust`
    FROM
    (SELECT `Category_id`, COUNT(`Contains`.`Pieces`) as `Counter1`
	FROM `Contains`, `Products`
	WHERE `Contains`.`Barcode` = `Products`.`Barcode`
	  and `Products`.`Brand_name` = True
    GROUP BY `Products`.`Category_id`) as `Labels`,
    (SELECT `Category_id`, COUNT(`Contains`.`Pieces`) as `Counter2`
	FROM `Contains`, `Products`
	WHERE `Contains`.`Barcode` = `Products`.`Barcode`
    GROUP BY `Products`.`Category_id`) as `All`

	WHERE `Labels`.`Category_id` = `All`.`Category_id`
    ORDER BY `Labels`.`Category_id`
    
 