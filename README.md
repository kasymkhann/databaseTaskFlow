# DatabaseTaskFlow || TaskFlow

`databaseTaskFlow` содержит SQL-запросы и хранилище для процедур базы данных, используемых в приложении `TaskFlow`. Здесь вы найдете описание структуры базы данных, примеры запросов и процедур, а также полезные сведения о взаимодействии с базой данных.

## Структура

- `sql/` - В этой директории хранятся SQL-файлы с описанием структуры базы данных и запросами.
- `plpgsql/` - Директория, в которой содержатся файлы с хранимыми процедурами, написанными на языке PL/pgSQL.

## Примеры запросов

### Процедуры на sql

```sql
-- sql/proc.sql

CREATE PROCEDURE authors_dedup()
AS $$
DELETE FROM authors
WHERE author_id IN (
    SELECT author_id
    FROM (
        SELECT author_id,
               row_number() OVER (
                   PARTITION BY first_name, last_name, middle_name
                   ORDER BY author_id
               ) AS rn
        FROM authors
    ) t
    WHERE t.rn > 1
);
$$ LANGUAGE sql;

-- сохроняем целосность создав индекс
CREATE UNIQUE INDEX authors_full_name_idx ON authors(
    last_name, first_name, coalesce(middle_name,'')
);
```

## Как использовать

1.  **Склонируйте репозиторий:**

```bash
git clone <URL>
```

Используйте SQL-файлы из директории sql/

Используйте PL/pgSQL-файлы из директории plpgsql/

## Интегрируйте эти запросы и процедуры в ваше приложение. 🚀

## Примечание

Убедитесь, что у вас установлен PostgreSQL и вы имеете доступ к базе данных перед выполнением SQL-запросов и процедур. 🛠️
