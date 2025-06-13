USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[ObtenerEstadosCuentaXEmpresa]    Script Date: 9/6/2024 12:02:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ObtenerEstadosCuentaXEmpresa]
    @inNombreEmpresa AS VARCHAR(32) -- 'Empresa X' o 'Empresa Y'
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION TObtenerEstadosCuentaXEmpresa

        ----------------------------------------------------------------------------------
        SELECT 
            ec.Id,
            ec.TotalMinIN,
            ec.TotalMinOUT,
            ec.FechaCorte
        FROM [dbo].[EstadoCuentaOperador] ec
        INNER JOIN [dbo].[Operador] o ON o.ID = ec.ID_Operador
        WHERE o.Nombre = @inNombreEmpresa;
        ----------------------------------------------------------------------------------

        COMMIT TRANSACTION TObtenerEstadosCuentaXEmpresa

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH

    SET NOCOUNT OFF;
END
