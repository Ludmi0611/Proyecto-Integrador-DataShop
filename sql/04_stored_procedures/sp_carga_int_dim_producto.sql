CREATE PROCEDURE [dbo].[SP_Carga_Int_Dim_Producto]
    @Proceso_ID BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    /* 1. Limpio tabla intermedia */
    TRUNCATE TABLE INT_Dim_Producto;

    /* 2. Cargo desde staging */
    INSERT INTO INT_Dim_Producto (
        CodigoProducto,
        Descripcion,
        Categoria,
        Marca,
        PrecioCosto,
        PrecioVentaSugerido,
        FechaRegistro
    )
    SELECT
        CAST(CodigoProducto AS INT),
        LOWER(LTRIM(RTRIM(Descripcion))),
        LOWER(LTRIM(RTRIM(Categoria))),
        LOWER(LTRIM(RTRIM(Marca))),
        PrecioCosto,
        PrecioVentaSugerido,
        GETDATE()
    FROM Stg_Dim_Producto;

    /* 3. Elimino registros sin código */
    DELETE
    FROM INT_Dim_Producto
    WHERE CodigoProducto IS NULL;

    /* 4. Elimino producto duplicado según regla de negocio */
	-- es igual al registro 1
    DELETE
    FROM INT_Dim_Producto
    WHERE CodigoProducto = 12;

    /* 5. Calculo mediana PrecioCosto */
    DECLARE @MedianPrecioCosto DECIMAL(18,2);

    SELECT @MedianPrecioCosto = Mediana
    FROM (
        SELECT
            PERCENTILE_CONT(0.5)
                WITHIN GROUP (ORDER BY PrecioCosto)
                OVER () AS Mediana
        FROM INT_Dim_Producto
        WHERE PrecioCosto IS NOT NULL
    ) t
    GROUP BY Mediana;

    UPDATE INT_Dim_Producto
    SET PrecioCosto = @MedianPrecioCosto
    WHERE PrecioCosto IS NULL;

    /* 6. Calculo mediana PrecioVentaSugerido */
    DECLARE @MedianPrecioVenta DECIMAL(18,2);

    SELECT @MedianPrecioVenta = Mediana
    FROM (
        SELECT
            PERCENTILE_CONT(0.5)
                WITHIN GROUP (ORDER BY PrecioVentaSugerido)
                OVER () AS Mediana
        FROM INT_Dim_Producto
        WHERE PrecioVentaSugerido IS NOT NULL
    ) t
    GROUP BY Mediana;

    UPDATE INT_Dim_Producto
    SET PrecioVentaSugerido = @MedianPrecioVenta
    WHERE PrecioVentaSugerido IS NULL;

    /* 7. Corrección puntual de categoría */
    UPDATE INT_Dim_Producto
    SET Categoria = 'electrodomésticos'
    WHERE CodigoProducto = 14;

END;
GO
