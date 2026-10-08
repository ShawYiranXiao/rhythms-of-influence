-- Original query by Yiran Xiao, posted January 22, 2024.
-- Source: https://w2.mat.ucsb.edu/forum/viewtopic.php?f=91&t=388#p2599
-- Query body preserved from the course forum; see docs/data.md for counting semantics.

SELECT 
    CASE
        WHEN spl_2016.subject.subject LIKE '%jazz%' THEN 'jazz'
        WHEN spl_2016.subject.subject LIKE '%rock%' THEN 'rock'
        WHEN
            spl_2016.subject.subject LIKE '%electronic%'
                OR spl_2016.subject.subject LIKE '%electronica%'
        THEN
            'electronic'
        WHEN spl_2016.subject.subject LIKE '%pop%' THEN 'pop'
        WHEN spl_2016.subject.subject LIKE '%country%' THEN 'country'
        WHEN spl_2016.subject.subject LIKE '%folk%' THEN 'folk'
        WHEN spl_2016.subject.subject LIKE '%soul%' THEN 'soul'
        WHEN spl_2016.subject.subject LIKE '%blues%' THEN 'blues'
        WHEN spl_2016.subject.subject LIKE '%funk%' THEN 'funk'
        WHEN
            spl_2016.subject.subject LIKE '%hip hop%'
                OR spl_2016.subject.subject LIKE '%rap music%'
        THEN
            'hip hop'
    END AS genre,
    spl_2016.outraw.title AS Title
FROM
    spl_2016.subject
        JOIN
    spl_2016.outraw ON spl_2016.outraw.bibNumber = spl_2016.subject.bibNumber
WHERE
    (spl_2016.outraw.itemtype LIKE '%cd%')
        AND YEAR(spl_2016.outraw.cout) = 2021
        AND MONTH(spl_2016.outraw.cout) = 7
        AND (spl_2016.subject.subject LIKE '%jazz%'
        OR spl_2016.subject.subject LIKE '%rock%'
        OR spl_2016.subject.subject LIKE '%electronic%'
        OR spl_2016.subject.subject LIKE '%electronica%'
        OR spl_2016.subject.subject LIKE '%pop%'
        OR spl_2016.subject.subject LIKE '%country%'
        OR spl_2016.subject.subject LIKE '%folk%'
        OR spl_2016.subject.subject LIKE '%soul%'
        OR spl_2016.subject.subject LIKE '%blues%'
        OR spl_2016.subject.subject LIKE '%funk%'
        OR spl_2016.subject.subject LIKE '%hip hop%'
        OR spl_2016.subject.subject LIKE '%rap music%')
        AND spl_2016.outraw.deweyClass LIKE '78%'
ORDER BY genre , Title;
