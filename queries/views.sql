-- List all views from schemas
SELECT 
    table_schema AS schema_name,
	table_name AS view_name
FROM information_schema.views
WHERE 
    table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY schema_name, view_name;