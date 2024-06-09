USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[AperturaCierreFactura]    Script Date: 6/8/2024 4:35:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[AperturaCierreEstadosCuenta]
	@inFechaOperacion AS DATE
AS
BEGIN
    BEGIN TRY
        
		------------- Declaración de variables ---------------
		DECLARE @FechaCorte DATE
        
		------------------------- INSERTAR SIGUIENTES FACTURAS -----------------------------------
		 -- Verificar si el día de la fecha proporcionada es 5
		IF DAY(@inFechaOperacion) = 5
		BEGIN
			BEGIN TRANSACTION tAC_EC

				-- Establecer la fecha de apertura como la fecha proporcionada
				SET @FechaCorte = @inFechaOperacion

				-- Insertar los registros en EstadoCuentaOperador
				INSERT INTO [dbo].[EstadoCuentaOperador] (
					ID_Operador,
					TotalMinIN,
					TotalMinOut,
					FechaCorte
				)
				SELECT 
					o.ID AS ID_Operador,
					0 AS TotalMinIN,
					0 AS TotalMinOUT,
					@FechaCorte AS FechaCierre
				FROM [dbo].[Operador] o

			COMMIT TRANSACTION tAC_EC
		END

		-----------------------------------------------------------------
        

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE() AS ErrorMessage
    END CATCH
END