CREATE PROCEDURE [dbo].[SP_Carga_Dim_Cliente]
    @Proceso_ID BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizo existentes
    UPDATE C
    SET
        C.RazonSocial = I.RazonSocial,
        C.Telefono = I.Telefono,
        C.Mail = I.Mail,
        C.Direccion = I.Direccion,
        C.Localidad = I.Localidad,
        C.Provincia = I.Provincia,
        C.CP = I.CP,
        C.FechaActualizacion = GETDATE()
    FROM Dim_Cliente C
    INNER JOIN INT_Dim_Cliente I
        ON C.CodCliente = I.CodCliente;

	-- activar permisos para insertar en columna Identity
	SET IDENTITY_INSERT Dim_Cliente ON;

    -- Inserto nuevos
    INSERT INTO Dim_Cliente
    (
        CodCliente,
        RazonSocial,
        Telefono,
        Mail,
        Direccion,
        Localidad,
        Provincia,
        CP,
        FechaCreacion,
        FechaActualizacion
    )
    SELECT
        I.CodCliente,
        I.RazonSocial,
        I.Telefono,
        I.Mail,
        I.Direccion,
        I.Localidad,
        I.Provincia,
        I.CP,
        GETDATE(),
        NULL
    FROM INT_Dim_Cliente I
    LEFT JOIN Dim_Cliente D
        ON I.CodCliente = D.CodCliente
    WHERE D.CodCliente IS NULL;

	--- desactivo permisos de identity, es el que me daba problemas
	SET IDENTITY_INSERT Dim_Cliente OFF;
END;
GO
