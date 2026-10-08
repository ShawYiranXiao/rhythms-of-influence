-- Original query by Yiran Xiao, posted January 22, 2024.
-- Source: https://w2.mat.ucsb.edu/forum/viewtopic.php?f=91&t=388#p2599
-- Query body preserved from the course forum; see docs/data.md for counting semantics.

SELECT 
    YEAR(cout) AS year,
    MONTH(cout) AS month,
    COUNT(IF(spl_2016.subject.subject LIKE '%jazz%',
        1,
        NULL)) AS 'jazz',
    COUNT(IF(spl_2016.subject.subject LIKE '%rock%',
        1,
        NULL)) AS 'rock',
    COUNT(IF(spl_2016.subject.subject LIKE '%electronic%'
            OR spl_2016.subject.subject LIKE '%electronica%',
        1,
        NULL)) AS 'electronic',
    COUNT(IF(spl_2016.subject.subject LIKE '%pop%',
        1,
        NULL)) AS 'pop',
    COUNT(IF(spl_2016.subject.subject LIKE '%country%',
        1,
        NULL)) AS 'country',
    COUNT(IF(spl_2016.subject.subject LIKE '%folk%',
        1,
        NULL)) AS 'folk',
    COUNT(IF(spl_2016.subject.subject LIKE '%soul%',
        1,
        NULL)) AS 'soul',
    COUNT(IF(spl_2016.subject.subject LIKE '%blues%',
        1,
        NULL)) AS 'blues',
    COUNT(IF(spl_2016.subject.subject LIKE '%funk%',
        1,
        NULL)) AS 'funk',
    COUNT(IF(spl_2016.subject.subject LIKE '%rap music%'
            OR spl_2016.subject.subject LIKE '%hip hop%',
        1,
        NULL)) AS 'hip hop'
FROM
    spl_2016.subject
        JOIN
    spl_2016.outraw ON spl_2016.outraw.bibNumber = spl_2016.subject.bibNumber
WHERE
    (itemtype LIKE '%cd%'
        OR itemtype LIKE '%dvd%'
        OR itemtype LIKE '%bk%')
        AND deweyClass LIKE '78%'
        AND YEAR(cout) BETWEEN 2015 AND 2023
GROUP BY year , month
ORDER BY year , month;
