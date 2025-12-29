CREATE TABLE dbo.INT_Dim_Producto (
    CodigoProducto        INT NOT NULL, 
    Descripcion           VARCHAR(255),
    Categoria             VARCHAR(100),
    Marca                 VARCHAR(100),
    PrecioCosto           DECIMAL(18, 2),
    PrecioVentaSugerido   DECIMAL(18, 2),
    FechaRegistro         DATETIME
	);

