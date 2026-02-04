--This shows all table in the database--
SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_SCHEMA, TABLE_NAME;

-- Shows Primary key in all available Tables--
SELECT
    A.TABLE_NAME,
    B.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS A  --stores rules applied to tables e.gPrimary keys, Foreign keys,Unique constraints etc--
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE B  --tells Which column is involved in which constraint--
    ON A.CONSTRAINT_NAME = B.CONSTRAINT_NAME -- this connects the rule to the table it applies to --
WHERE A.CONSTRAINT_TYPE = 'PRIMARY KEY' -- this filers everything except primary key--
ORDER BY A.TABLE_NAME;


--shows all foreign key----
SELECT
    fk.name AS ForeignKeyName,
    tp.name AS ParentTable,
    cp.name AS ParentColumn,
    tr.name AS ReferencedTable,
    cr.name AS ReferencedColumn
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc
    ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables tp
    ON fkc.parent_object_id = tp.object_id
JOIN sys.columns cp
    ON fkc.parent_object_id = cp.object_id
   AND fkc.parent_column_id = cp.column_id
JOIN sys.tables tr
    ON fkc.referenced_object_id = tr.object_id
JOIN sys.columns cr
    ON fkc.referenced_object_id = cr.object_id
   AND fkc.referenced_column_id = cr.column_id
ORDER BY ParentTable, ReferencedTable;
