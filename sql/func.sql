-- Функций на sql

-- для author_name
CREATE OR REPLACE FUNCTION author_name(
    last_name text,
    first_name text,
    middle_name text
) RETURNS text
AS $$
SELECT last_name || ' ' ||
       left(first_name, 1) || '.' ||
       CASE WHEN middle_name != ''
           THEN ' ' || left(middle_name, 1) || '.'
           ELSE ''
       END;
$$ IMMUTABLE LANGUAGE sql;

CREATE OR REPLACE VIEW authors_v AS
SELECT a.author_id,
       author_name(a.last_name, a.first_name, a.middle_name) AS display_name
FROM   authors a
ORDER BY display_name;

-- для book_name 

CREATE OR REPLACE FUNCTION book_name(book_id integer, title text)
RETURNS text
AS $$
SELECT title || '. ' ||
       string_agg(
           author_name(a.last_name, a.first_name, a.middle_name), ', '
           ORDER BY ash.seq_num
       )
FROM   authors a
       JOIN authorship ash ON a.author_id = ash.author_id
WHERE  ash.book_id = book_name.book_id;
$$ STABLE LANGUAGE sql;

DROP VIEW IF EXISTS catalog_v;

CREATE VIEW catalog_v AS
SELECT b.book_id,
       book_name(b.book_id, b.title) AS display_name
FROM   books b
ORDER BY display_name;