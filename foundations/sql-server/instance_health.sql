SELECT @@SERVERNAME AS server_name,
       @@VERSION AS sql_version,
       GETDATE() AS collected_at;

SELECT name,
       state_desc,
       recovery_model_desc,
       compatibility_level
FROM sys.databases
ORDER BY name;
