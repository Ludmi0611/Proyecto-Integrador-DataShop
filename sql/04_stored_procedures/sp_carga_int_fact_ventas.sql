CREATE PROCEDURE dbo.SP_Carga_Int_Fact_Ventas
    @Proceso_ID BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Limpio tabla intermedia
    TRUNCATE TABLE INT_Fact_Ventas;

    -- 2. Inserto desde staging con validaciones básicas
    INSERT INTO INT_Fact_Ventas (
        FechaVenta,
        CodigoProducto,
        CodigoCliente,
        CodigoTienda,
        Cantidad,
        PrecioVenta,
        ImporteVenta,
        FechaRegistro
    )
    SELECT
        CAST(FechaVenta AS DATE),
        CodigoProducto,
        CodigoCliente,
        CodigoTienda,
        Cantidad,
        PrecioVenta,
        Cantidad * PrecioVenta AS ImporteVenta,
        GETDATE()
    FROM Stg_Fact_Ventas
    WHERE
        FechaVenta IS NOT NULL
        AND CodigoProducto IS NOT NULL
        AND CodigoCliente IS NOT NULL
        AND CodigoTienda IS NOT NULL
        AND Cantidad > 0
        AND PrecioVenta >= 0;

END;
GO
