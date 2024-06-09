USE [NewTelefoneria]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarDatosFactura]    Script Date: 6/8/2024 4:53:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ActualizarDatosEstadosCuenta]
	@inFechaOperacion AS DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION TActualizarDatosEstadoCuenta

			------------------------------------ TOTAL MINUTOS IN ------------------------------------
			UPDATE ec
			SET 
				ec.TotalMinIN = ISNULL((
					SELECT SUM(dl.Duracion)
					FROM [dbo].[DetalleLlamadas] dl
					INNER JOIN Llamadas l ON l.ID = dl.ID_Llamada
					WHERE (dl.ID_TipoMinutos1 = 3 OR dl.ID_TipoMinutos2 = 3)
					AND l.FechaHora_Inicio >= CASE 
													WHEN ec.ID <= 2 THEN '2024-01-01' -- Primeros dos estados de cuenta
													ELSE (
														SELECT TOP 1 ec_anterior.FechaCorte
														FROM [dbo].[EstadoCuentaOperador] ec_anterior
														WHERE ec_anterior.ID_Operador = ec.ID_Operador
														AND ec_anterior.ID < ec.ID 
														ORDER BY ec_anterior.ID DESC
													)
												END
					AND l.FechaHora_Inicio <= ec.FechaCorte
				), 0)
			FROM [dbo].[EstadoCuentaOperador] ec
			WHERE ec.ID_Operador = 1;


			UPDATE ec
			SET 
				ec.TotalMinIN = ISNULL((
					SELECT SUM(dl.Duracion)
					FROM [dbo].[DetalleLlamadas] dl
					INNER JOIN Llamadas l ON l.ID = dl.ID_Llamada
					WHERE (dl.ID_TipoMinutos1 = 4 OR dl.ID_TipoMinutos2 = 4)
					AND l.FechaHora_Inicio >= CASE 
													WHEN ec.ID <= 2 THEN '2024-01-01' -- Primeros dos estados de cuenta
													ELSE (
														SELECT TOP 1 ec_anterior.FechaCorte
														FROM [dbo].[EstadoCuentaOperador] ec_anterior
														WHERE ec_anterior.ID_Operador = ec.ID_Operador
														AND ec_anterior.ID < ec.ID 
														ORDER BY ec_anterior.ID DESC
													)
												END
					AND l.FechaHora_Inicio <= ec.FechaCorte
				), 0)
			FROM [dbo].[EstadoCuentaOperador] ec
			WHERE ec.ID_Operador = 2;

			-------------------------------------------------------------------------------------------
			------------------------------------ TOTAL MINUTOS OUT ------------------------------------
			UPDATE ec
			SET 
				ec.TotalMinOUT = ISNULL((
					SELECT SUM(dlnl.Duracion)
					FROM [dbo].[DetalleLlamadaNoLocal] dlnl
					INNER JOIN Llamadas l ON l.ID = dlnl.[ID_LlamadaNoLocal]
					WHERE (dlnl.[ID_TipoMinuto] = 3)
					AND l.FechaHora_Inicio >= CASE 
													WHEN ec.ID <= 2 THEN '2024-01-01' -- Primeros dos estados de cuenta
													ELSE (
														SELECT TOP 1 ec_anterior.FechaCorte
														FROM [dbo].[EstadoCuentaOperador] ec_anterior
														WHERE ec_anterior.ID_Operador = ec.ID_Operador
														AND ec_anterior.ID < ec.ID 
														ORDER BY ec_anterior.ID DESC
													)
												END
					AND l.FechaHora_Inicio <= ec.FechaCorte
				), 0)
			FROM [dbo].[EstadoCuentaOperador] ec
			WHERE ec.ID_Operador = 1;


			UPDATE ec
			SET 
				ec.TotalMinOUT = ISNULL((
					SELECT SUM(dlnl.Duracion)
					FROM [dbo].[DetalleLlamadaNoLocal] dlnl
					INNER JOIN Llamadas l ON l.ID = dlnl.ID_LlamadaNoLocal
					WHERE (dlnl.ID_TipoMinuto = 4)
					AND l.FechaHora_Inicio >= CASE 
													WHEN ec.ID <= 2 THEN '2024-01-01' -- Primeros dos estados de cuenta
													ELSE (
														SELECT TOP 1 ec_anterior.FechaCorte
														FROM [dbo].[EstadoCuentaOperador] ec_anterior
														WHERE ec_anterior.ID_Operador = ec.ID_Operador
														AND ec_anterior.ID < ec.ID 
														ORDER BY ec_anterior.ID DESC
													)
												END
					AND l.FechaHora_Inicio <= ec.FechaCorte
				), 0)
			FROM [dbo].[EstadoCuentaOperador] ec
			WHERE ec.ID_Operador = 2;

			-------------------------------------------------------------------------------------------



        COMMIT TRANSACTION TActualizarDatosEstadoCuenta

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SELECT ERROR_MESSAGE() AS ErrorMessage
    END CATCH
END