--delete from dbo.ElementoTipoTarifa
--DBCC CHECKIDENT ('ElementoTipoTarifa', RESEED, 0) 

--delete from dbo.TipoRelacionFamiliar
--DBCC CHECKIDENT ('TipoRelacionFamiliar', RESEED, 0)

--delete from dbo.TipoElementoFijo
--DBCC CHECKIDENT ('TipoElementoFijo', RESEED, 0) 

--delete from dbo.TipoElemento
--DBCC CHECKIDENT ('TipoElemento', RESEED, 0) 

--delete from dbo.TipoUnidad
--DBCC CHECKIDENT ('TipoUnidad', RESEED, 0) 

--delete from dbo.TipoTarifa
--DBCC CHECKIDENT ('TipoTarifa', RESEED, 0) 

--delete from dbo.Llamadas
--DBCC CHECKIDENT ('Llamadas', RESEED, 0) 

--delete from dbo.UsoDatos
--DBCC CHECKIDENT ('UsoDatos', RESEED, 0) 

delete from dbo.DetalleLlamadaNoLocal
DBCC CHECKIDENT ('DetalleLlamadaNoLocal', RESEED, 0) 
delete from dbo.LlamadaNoLocal
DBCC CHECKIDENT ('LlamadaNoLocal', RESEED, 0) 
delete from dbo.EstadoCuentaOperador
DBCC CHECKIDENT ('EstadoCuentaOperador', RESEED, 0) 

delete from dbo.LlamadaNoLocal
DBCC CHECKIDENT ('LlamadaNoLocal', RESEED, 0) 
delete from dbo.DetalleLlamadas
DBCC CHECKIDENT ('DetalleLlamadas', RESEED, 0) 
delete from dbo.DetalleUsoDatos
DBCC CHECKIDENT ('DetalleUsoDatos', RESEED, 0) 
delete from dbo.DetalleFactura
DBCC CHECKIDENT ('DetalleFactura', RESEED, 0) 
delete from dbo.Factura
DBCC CHECKIDENT ('Factura', RESEED, 0) 

delete from dbo.Contrato
DBCC CHECKIDENT ('Contrato', RESEED, 0)
delete from dbo.Clientes
DBCC CHECKIDENT ('Clientes', RESEED, 0)
delete from dbo.RelacionFamiliar
DBCC CHECKIDENT ('RelacionFamiliar', RESEED, 0) --
delete from dbo.UsoDatos
DBCC CHECKIDENT ('UsoDatos', RESEED, 0) --
delete from dbo.Llamadas
DBCC CHECKIDENT ('Llamadas', RESEED, 0) 

select * from Clientes --80083385477

select * from Contrato WHERE ID_TipoTarifa = 7 OR ID_TipoTarifa = 8

select * from Factura WHERE ID_Contrato = 5 -- FALTA ARREGLAR LO DE QUE LAS FECHAFACTURA CAMBIAN

select * from DetalleFactura where ID_Factura = 5

select * from Descripcion

select * from DetalleLlamadas where ID_DetalleFactura = 4

select * from Llamadas where NumeroDe = '89738908' AND NumeroA = '86336401'

select * from DetalleLlamadas where ID_Llamada = 53

select * from Factura where Id = 1

select * from UsoDatos

select * from DetalleUsoDatos

select * from Contrato where Numero = '89738908'
select * from Factura where ID_Contrato = 1
select * from Llamadas where NumeroDe = '89738908'
select * from DetalleLlamadas where ID_DetalleFactura = 1

select * from TipoMinutos

select * from ElementoTipoTarifa order by ID_TipoElemento