CREATE TABLE dbo.INT_Dim_Tienda (
    CodigoTienda      INT            NOT NULL,
	Descripcion       VARCHAR(200)    NULL,
    Direccion         VARCHAR(150)    NULL,
    Localidad         VARCHAR(100)    NULL,
    Provincia         VARCHAR(100)    NULL,
    CP                VARCHAR(10)     NULL,
    TipoTienda        VARCHAR(50)     NULL,
    FechaRegistro     DATETIME        NOT NULL
);
GO


