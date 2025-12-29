CREATE TABLE Stg_Fact_Ventas (
    FechaVenta DATE,
    CodigoProducto INT,
    Producto VARCHAR(200),
    Cantidad INT,
    PrecioVenta DECIMAL(18,2),
    CodigoCliente INT,
    Cliente VARCHAR(200),
    CodigoTienda INT,
    Tienda VARCHAR(200)
);
