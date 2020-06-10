SELECT serial_no, date 
FROM test.dbo.from_postgres
WHERE operating_system = 'Win10'
AND up_to_date = 'no'

--DELETE 
--FROM test.dbo.from_postgres