-- EXPLORING LEGO DATASET

-- What is the total number of parts per theme

SELECT s.set_num, s.name, s.year, s.theme_id,
       s.num_parts, t.name AS theme_name, t.parent_id,
       p.name AS parent_theme_name
FROM sets AS s
LEFT JOIN themes AS t
    ON s.theme_id = t.id
LEFT JOIN themes AS p
    ON p.parent_id = p.id
