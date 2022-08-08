-- EXPLORING LEGO DATASET

-- Joining two datasets sets and themes for the analysis purposes

SELECT s.set_num, s.name AS set_name, s.year, s.theme_id,
       CAST(s.num_parts AS numeric), t.name AS theme_name, t.parent_id,
       p.name AS parent_theme_name
INTO analytics_main
FROM sets AS s
LEFT JOIN themes AS t
    ON s.theme_id = t.id
LEFT JOIN themes AS p
    ON p.parent_id = p.id;

-- What is the total number of parts per theme



