CREATE TABLE Dim_Cliente (
    CodCliente INT IDENTITY(1,1) PRIMARY KEY,
    RazonSocial NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(100) NOT NULL,
    Mail NVARCHAR(100),
    Direccion NVARCHAR(100),
    Localidad NVARCHAR(50),
    Provincia NVARCHAR(50),
	CP NVARCHAR(50),
	FechaCreacion DATETIME NOT NULL,
    FechaActualizacion DATETIME
);