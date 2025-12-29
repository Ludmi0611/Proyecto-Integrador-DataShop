CREATE PROCEDURE [dbo].[SP_Carga_Dim_Tienda]
    @Proceso_ID BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    /* 1. Elimino registros inválidos */
    DELETE
    FROM INT_Dim_Tienda
    WHERE CodigoTienda IS NULL;

    /* 2. Actualizo tiendas existentes */
    UPDATE D
    SET
        D.Direccion          = I.Direccion,
        D.Localidad          = I.Localidad,
        D.Provincia          = I.Provincia,
        D.CP                 = I.CP,
        D.TipoTienda         = I.TipoTienda,
        D.Descripcion        = I.Descripcion,
        D.FechaActualizacion = GETDATE()
    FROM Dim_Tienda D
    INNER JOIN INT_Dim_Tienda I
        ON D.CodigoTienda = I.CodigoTienda;

    /* 3. Inserto nuevas tiendas */
    INSERT INTO Dim_Tienda (
        CodigoTienda,
        Direccion,
        Localidad,
        Provincia,
        CP,
        TipoTienda,
        Descripcion,
        FechaCreacion,
        FechaActualizacion
    )
    SELECT
        I.CodigoTienda,
        I.Direccion,
        I.Localidad,
        I.Provincia,
        I.CP,
        I.TipoTienda,
        I.Descripcion,
        GETDATE() AS FechaCreacion,
        NULL      AS FechaActualizacion
    FROM INT_Dim_Tienda I
    LEFT JOIN Dim_Tienda D
        ON I.CodigoTienda = D.CodigoTienda
    WHERE D.CodigoTienda IS NULL;

END;
GO
