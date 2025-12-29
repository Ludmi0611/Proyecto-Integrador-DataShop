CREATE PROCEDURE [dbo].[SP_Carga_Int_Dim_Tienda]
    @Proceso_ID BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    /* 1. Limpio tabla intermedia */
    TRUNCATE TABLE INT_Dim_Tienda;

    /* 2. Cargo desde staging con normalización de texto */
    INSERT INTO INT_Dim_Tienda (
        CodigoTienda,
        Direccion,
        Localidad,
        Provincia,
        CP,
        TipoTienda,
        Descripcion,
        FechaRegistro
    )
    SELECT
        CAST(CodigoTienda AS INT),
        LOWER(LTRIM(RTRIM(Direccion))),
        LOWER(LTRIM(RTRIM(Localidad))),
        LOWER(LTRIM(RTRIM(Provincia))),
        CAST(CP AS VARCHAR(10)),
        LOWER(LTRIM(RTRIM(TipoTienda))),
        LOWER(LTRIM(RTRIM(Descripcion))),
        GETDATE()
    FROM Stg_Dim_Tienda;

    /* 3. Completo Localidad por Provincia + CP */
    UPDATE t
    SET Localidad = x.Localidad
    FROM INT_Dim_Tienda t
    JOIN (
        SELECT Provincia, CP, MAX(Localidad) AS Localidad
        FROM INT_Dim_Tienda
        WHERE Localidad IS NOT NULL
        GROUP BY Provincia, CP
    ) x
        ON t.Provincia = x.Provincia
       AND t.CP = x.CP
    WHERE t.Localidad IS NULL;

    /* 4. Completo valores faltantes con texto */
    UPDATE INT_Dim_Tienda
    SET Direccion = 'sin direccion'
    WHERE Direccion IS NULL;

    UPDATE INT_Dim_Tienda
    SET Localidad = 'sin localidad'
    WHERE Localidad IS NULL;

    UPDATE INT_Dim_Tienda
    SET TipoTienda = 'no definido'
    WHERE TipoTienda IS NULL;

    UPDATE INT_Dim_Tienda
    SET Descripcion = 'sin descripcion'
    WHERE Descripcion IS NULL;

    /* 5. Completo CP por Localidad + Provincia */
    UPDATE t
    SET CP = x.CP
    FROM INT_Dim_Tienda t
    JOIN (
        SELECT Localidad, Provincia, MAX(CP) AS CP
        FROM INT_Dim_Tienda
        WHERE CP IS NOT NULL
        GROUP BY Localidad, Provincia
    ) x
        ON t.Localidad = x.Localidad
       AND t.Provincia = x.Provincia
    WHERE t.CP IS NULL;

END;
GO
