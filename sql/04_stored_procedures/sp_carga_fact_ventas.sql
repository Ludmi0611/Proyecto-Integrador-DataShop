CREATE PROCEDURE SP_Carga_Fact_Ventas
    @Proceso_ID BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE Fact_Ventas;

    INSERT INTO Fact_Ventas (
        FechaVenta,
        IdProducto,
        IdCliente,
        IdTienda,
        Cantidad,
        PrecioVenta,
        ImporteVenta,
        FechaCreacion,
        FechaActualizacion
    )
    SELECT
        v.FechaVenta,
        p.CodigoProducto,
        c.CodCliente,
        t.CodigoTienda,
        v.Cantidad,
        v.PrecioVenta,
        v.ImporteVenta,
        GETDATE() AS FechaCreacion,
        NULL AS FechaActualizacion
    FROM INT_Fact_Ventas v
    INNER JOIN Dim_Producto p
        ON v.CodigoProducto = p.CodigoProducto
    INNER JOIN Dim_Cliente c
        ON v.CodigoCliente = c.CodCliente
    INNER JOIN Dim_Tienda t
        ON v.CodigoTienda = t.CodigoTienda;
END;
GO
