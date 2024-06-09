DECLARE @XML AS XML
DECLARE @id AS INT

-- Cargar el archivo XML en una variable XML
SELECT @XML = P.X
FROM OPENROWSET(BULK 'C:\Program Files\Microsoft SQL Server\MSSQL16.HIATUXHIATUSBD\MSSQL\config.xml', SINGLE_BLOB) AS P(X)

-- Crear un identificador de documento XML
--EXEC sp_xml_preparedocument @id OUTPUT, @XML


--NOTA: en usuarios cambien los & por ;
EXEC [dbo].[SPXMLinsertarDatos] @xml = @XML