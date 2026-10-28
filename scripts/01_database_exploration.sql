
/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - Identify tables and views in the active database.
    - Inspect the structure of the Gold customer view.
===============================================================================
*/

-- 1. Explore tables and views in the active database

SELECT
    TABLE_SCHEMA AS database_name,
    TABLE_NAME AS object_name,
    TABLE_TYPE AS object_type
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = DATABASE()
ORDER BY TABLE_TYPE, TABLE_NAME;


-- 2. Explore columns in gold_dim_customers

SELECT
    TABLE_SCHEMA AS database_name,
    TABLE_NAME AS table_name,
    ORDINAL_POSITION AS column_position,
    COLUMN_NAME AS column_name,
    COLUMN_TYPE AS column_type,
    IS_NULLABLE AS is_nullable,
    CHARACTER_MAXIMUM_LENGTH AS max_character_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'gold_dim_customers'
ORDER BY ORDINAL_POSITION;
