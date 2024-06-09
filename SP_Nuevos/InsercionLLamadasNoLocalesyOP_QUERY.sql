INSERT INTO [dbo].[Operador](
    Nombre,
    digitoPrefijo
)
VALUES 
    ('Empresa X', 7),
    ('Empresa Y', 6);

INSERT INTO [dbo].[LlamadaNoLocal] (
    ID_Llamadas,
    ID_Operador
)
SELECT
    l.Id,
    o.Id
FROM [dbo].[Llamadas] l
INNER JOIN [dbo].[Operador] o
    ON LEFT(l.NumeroA, 1) = CAST(o.digitoPrefijo AS VARCHAR)
WHERE
    CONVERT(DATE, l.fechaHora_Inicio) = @inFechaOperacion;
