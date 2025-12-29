CREATE PROCEDURE [dbo].[SP_Carga_Int_Dim_Cliente]
    @Proceso_ID BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Limpio tabla intermedia
    TRUNCATE TABLE INT_Dim_Cliente;

    -- 2. Cargo desde staging
    INSERT INTO INT_Dim_Cliente
    (
        CodCliente,
        RazonSocial,
        Telefono,
        Mail,
        Direccion,
        Localidad,
        Provincia,
        CP,
        FechaRegistro
    )
    SELECT
        CAST(CodCliente AS INT),
        RazonSocial,
        Telefono,
        Mail,
        Direccion,
        Localidad,
        Provincia,
        CP,
        GETDATE()
    FROM STG_Dim_Cliente;

    -- 3. Elimino clientes sin ID
    DELETE
    FROM INT_Dim_Cliente
    WHERE CodCliente IS NULL;

    -- 4. Elimino duplicados por RazonSocial
    ;WITH cte AS (
        SELECT *,
               ROW_NUMBER() OVER (
                   PARTITION BY RazonSocial
                   ORDER BY CodCliente
               ) AS rn
        FROM INT_Dim_Cliente
    )
    DELETE FROM cte
    WHERE rn > 1;

    -- 5. Completo CP por Localidad y Provincia
    UPDATE c
    SET c.CP = x.CP
    FROM INT_Dim_Cliente c
    JOIN (
        SELECT Localidad, Provincia, MAX(CP) AS CP
        FROM INT_Dim_Cliente
        WHERE CP IS NOT NULL
        GROUP BY Localidad, Provincia
    ) x
        ON c.Localidad = x.Localidad
       AND c.Provincia = x.Provincia
    WHERE c.CP IS NULL;

    -- 6. Completo razón social faltante
    UPDATE INT_Dim_Cliente
    SET RazonSocial = 'razon social no informada'
    WHERE RazonSocial IS NULL;

END;
GO
