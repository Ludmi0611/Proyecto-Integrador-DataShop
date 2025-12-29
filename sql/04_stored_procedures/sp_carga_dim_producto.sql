CREATE PROCEDURE [dbo].[SP_Carga_Dim_Producto]
    @Proceso_ID BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE D
    SET
        D.Descripcion           = I.Descripcion,
        D.Categoria             = I.Categoria,
        D.Marca                 = I.Marca,
        D.PrecioCosto           = I.PrecioCosto,
        D.PrecioVentaSugerido   = I.PrecioVentaSugerido,
        D.FechaActualizacion    = GETDATE()
    FROM Dim_Producto D
    INNER JOIN INT_Dim_Producto I
        ON D.CodigoProducto = I.CodigoProducto;

    INSERT INTO Dim_Producto
    (
        CodigoProducto,
        Descripcion,
        Categoria,
        Marca,
        PrecioCosto,
        PrecioVentaSugerido,
        FechaCreacion,
        FechaActualizacion
    )
    SELECT
        I.CodigoProducto,
        I.Descripcion,
        I.Categoria,
        I.Marca,
        I.PrecioCosto,
        I.PrecioVentaSugerido,
        GETDATE() AS FechaCreacion,
        NULL      AS FechaActualizacion
    FROM INT_Dim_Producto I
    LEFT JOIN Dim_Producto D
        ON I.CodigoProducto = D.CodigoProducto
    WHERE D.CodigoProducto IS NULL;

END;
GO
