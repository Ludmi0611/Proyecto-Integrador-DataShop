CREATE TABLE dbo.Dim_Producto (
    -- Surrogate Key: ID autonumérico único para el DWH
    ProductoKey           INT IDENTITY(1,1) NOT NULL,
    CodigoProducto        INT NOT NULL, 
    Descripcion           VARCHAR(255),
    Categoria             VARCHAR(100),
    Marca                 VARCHAR(100),
    PrecioCosto           DECIMAL(18, 2),
    PrecioVentaSugerido   DECIMAL(18, 2),
    FechaCreacion         DATETIME NOT NULL,
    FechaActualizacion    DATETIME
	);