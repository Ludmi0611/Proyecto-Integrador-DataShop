CREATE TABLE INT_Dim_Cliente (
    CodCliente INT NOT NULL,
    RazonSocial NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(100) NOT NULL,
    Mail NVARCHAR(100),
    Direccion NVARCHAR(100),
    Localidad NVARCHAR(50),
    Provincia NVARCHAR(50),
	CP NVARCHAR(50),
	FechaRegistro DATETIME NOT NULL
);



