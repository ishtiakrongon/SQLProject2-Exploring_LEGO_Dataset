-- EXPLORING LEGO DATASET

-- Joining two datasets sets and themes for the analysis purposes

SELECT s.set_num, s.name AS set_name, s.year, s.theme_id,
       CAST(s.num_parts AS numeric), t.name AS theme_name, t.parent_id,
       p.name AS parent_theme_name,
	   CASE WHEN s.year BETWEEN 1901 AND 2000 THEN '20th Century'
	   		WHEN s.year BETWEEN 2001 AND 2100 THEN '21st Century'
			END AS century
INTO analytics_main
FROM sets AS s
LEFT JOIN themes AS t
    ON s.theme_id = t.id
LEFT JOIN themes AS p
    ON p.parent_id = p.id;
	

-- 1. What is the total number of parts per theme?

SELECT theme_name, sum(num_parts) AS total_num_parts
FROM analytics_main
WHERE parent_theme_name IS NOT NULL
GROUP BY theme_name
ORDER BY total_num_parts DESC;

-------------------------------------------------------------------

-- 2. What is the total number of parts per year?

SELECT year, sum(num_parts) AS total_num_parts
FROM analytics_main
WHERE parent_theme_name IS NOT NULL
GROUP BY year
ORDER BY total_num_parts DESC;


--------------------------------------------------------------------

-- 3. How many sets were created in each century in the dataset?

SELECT century, COUNT(set_num) as total_set_num
FROM analytics_main
WHERE parent_theme_name IS NOT NULL
GROUP BY century;


---------------------------------------------------------------------

-- 4. --- What percentage of sets ever released in the 21st century were trains themed? 

WITH cte AS 
(
	SELECT century, theme_name, COUNT(set_num) total_set_num
	FROM analytics_main
	WHERE century = '21st Century'
	GROUP BY century, theme_name
)
SELECT SUM(total_set_num), SUM(percentage)
FROM(
	SELECT Century, theme_name, total_set_num, SUM(total_set_num) OVER() AS total,  cast(1.00 * total_set_num / sum(total_set_num) OVER() AS decimal(5,4))*100 Percentage
	FROM cte	
	--order by 3 desc
	)m
WHERE theme_name LIKE '%Star wars%';



-----------------------------------------------------------------------







