--дл автора
CREATE VIEW authors_v AS
SELECT a.author_id,
       a.last_name || ' ' ||
       a.first_name ||
       coalesce(' ' || nullif(a.middle_name, ''), '') AS display_name
FROM   authors a;

-- Для католога
CREATE VIEW catalog_v AS
SELECT b.book_id,
       b.title AS display_name
FROM   books b;

-- Для операци
CREATE VIEW catalog_v AS
SELECT b.book_id,
       b.title AS display_name
FROM   books b;