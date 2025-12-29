CREATE TABLE dbo.Dim_Tienda (
    IdTienda          INT IDENTITY(1,1) PRIMARY KEY,
    CodigoTienda      INT            NOT NULL,
	Descripcion       VARCHAR(200)    NOT NULL,
    Direccion         VARCHAR(150)    NOT NULL,
    Localidad         VARCHAR(100)    NOT NULL,
    Provincia         VARCHAR(100)    NOT NULL,
    CP                VARCHAR(10)     NOT NULL,
    TipoTienda        VARCHAR(50)     NOT NULL,
    FechaCreacion     DATETIME        NOT NULL,
    FechaActualizacion DATETIME       NULL
);
GO