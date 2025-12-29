CREATE TABLE Fact_Ventas (
    FechaVenta DATE,
    IdProducto INT,
    IdCliente INT,
    IdTienda INT,
    Cantidad INT,
    PrecioVenta DECIMAL(18,2),
    ImporteVenta DECIMAL(18,2),
    FechaCreacion DATETIME,
	FechaActualizacion DATETIME,
);